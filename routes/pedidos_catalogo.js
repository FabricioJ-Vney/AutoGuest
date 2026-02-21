const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { nanoid } = require('nanoid');

// ============================================================
// POST /api/pedidos-catalogo/crear-pedido
// Crear un pedido de catálogo (cuando se completa un pago)
// ============================================================
router.post('/crear-pedido', async (req, res) => {
    const { items, total, metodo_pago, id_transaccion_externa, email_cliente } = req.body;

    if (!items || !total || !metodo_pago) {
        return res.status(400).json({ error: 'Items, total y método de pago son requeridos' });
    }

    try {
        const idPedido = 'PED' + nanoid(10);
        
        const [result] = await db.query(
            `INSERT INTO pedidos_catalogo (id_pedido, items, total, estado, metodo_pago, id_transaccion_externa, EMAIL_CLIENTE)
             VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [idPedido, JSON.stringify(items), total, 'pagado', metodo_pago, id_transaccion_externa || null, email_cliente || null]
        );

        res.status(201).json({ 
            success: true, 
            idPedido: idPedido,
            message: 'Pedido creado exitosamente' 
        });
    } catch (error) {
        console.error('[Pedidos Catálogo] Error al crear pedido:', error);
        res.status(500).json({ error: 'Error al crear el pedido' });
    }
});

// ============================================================
// POST /api/pedidos-catalogo/crear-pedido-pendiente
// Crear un pedido en estado pendiente (para reserva antes de pago)
// ============================================================
router.post('/crear-pedido-pendiente', async (req, res) => {
    const { items, total, id_transaccion_externa } = req.body;

    if (!items || !total) {
        return res.status(400).json({ error: 'Items y total son requeridos' });
    }

    try {
        const idPedido = 'PED' + nanoid(10);
        
        await db.query(
            `INSERT INTO pedidos_catalogo (id_pedido, items, total, estado, id_transaccion_externa)
             VALUES (?, ?, ?, ?, ?)`,
            [idPedido, JSON.stringify(items), total, 'pendiente', id_transaccion_externa || null]
        );

        res.json({ 
            success: true, 
            idPedido: idPedido
        });
    } catch (error) {
        console.error('[Pedidos Catálogo] Error al crear pedido pendiente:', error);
        res.status(500).json({ error: 'Error al crear el pedido pendiente' });
    }
});

// ============================================================
// POST /api/pedidos-catalogo/finalizar-pedido
// Marcar un pedido pendiente como pagado (cuando regresa de MercadoPago)
// ============================================================
router.post('/finalizar-pedido', async (req, res) => {
    const { id_transaccion_externa } = req.body;

    if (!id_transaccion_externa) {
        return res.status(400).json({ error: 'id_transaccion_externa es requerido' });
    }

    try {
        const [result] = await db.query(
            `UPDATE pedidos_catalogo 
             SET estado = 'pagado', UPDATED_AT = NOW()
             WHERE id_transaccion_externa = ? AND estado = 'pendiente'`,
            [id_transaccion_externa]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Pedido no encontrado o ya pagado' });
        }

        // Obtener el idPedido que fue actualizado
        const [pedido] = await db.query(
            `SELECT id_pedido FROM pedidos_catalogo 
             WHERE id_transaccion_externa = ?
             ORDER BY CREATED_AT DESC LIMIT 1`,
            [id_transaccion_externa]
        );

        res.json({ 
            success: true, 
            idPedido: pedido[0]?.id_pedido,
            message: 'Pedido finalizado exitosamente'
        });
    } catch (error) {
        console.error('[Pedidos Catálogo] Error al finalizar pedido:', error);
        res.status(500).json({ error: 'Error al finalizar el pedido' });
    }
});

// ============================================================
// GET /api/pedidos-catalogo/ticket/:idPedido
// Obtener los detalles del ticket/factura de un pedido
// ============================================================
router.get('/ticket/:idPedido', async (req, res) => {
    const { idPedido } = req.params;

    try {
        const [pedido] = await db.query(
            `SELECT * FROM pedidos_catalogo WHERE id_pedido = ?`,
            [idPedido]
        );

        if (pedido.length === 0) {
            return res.status(404).json({ error: 'Pedido no encontrado' });
        }

        const data = pedido[0];
        
        // Mapear a esquema de ticket
        const ticket = {
            id: data.id_pedido,
            fecha_creacion: data.CREATED_AT,
            items: JSON.parse(data.items || '[]'),
            monto_total: data.total,
            metodo_pago: data.metodo_pago || 'N/A',
            estado: data.estado,
            id_transaccion_externa: data.id_transaccion_externa,
            email_cliente: data.EMAIL_CLIENTE
        };

        res.json(ticket);
    } catch (error) {
        console.error('[Pedidos Catálogo] Error al obtener ticket:', error);
        res.status(500).json({ error: 'Error al obtener el ticket' });
    }
});

// ============================================================
// GET /api/pedidos-catalogo/:idPedido
// Obtener detalles completos de un pedido
// ============================================================
router.get('/:idPedido', async (req, res) => {
    const { idPedido } = req.params;

    try {
        const [pedido] = await db.query(
            `SELECT * FROM pedidos_catalogo WHERE id_pedido = ?`,
            [idPedido]
        );

        if (pedido.length === 0) {
            return res.status(404).json({ error: 'Pedido no encontrado' });
        }

        const data = pedido[0];
        data.items = JSON.parse(data.items || '[]');

        res.json(data);
    } catch (error) {
        console.error('[Pedidos Catálogo] Error al obtener pedido:', error);
        res.status(500).json({ error: 'Error al obtener el pedido' });
    }
});

module.exports = router;
