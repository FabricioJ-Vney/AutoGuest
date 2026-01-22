const express = require('express');
const { nanoid } = require('nanoid');
const db = require('../config/database');
const router = express.Router();

// Crear un nuevo pedido
router.post('/', async (req, res) => {
    const { items } = req.body;

    // Obtener usuario de la sesión (Importante: cart.js debe llamarse desde una sesión activa)
    // Obtener usuario de la sesión o usar NULL si es invitado
    const idCliente = req.session.userId || null;

    // if (!idCliente) {
    //     return res.status(401).json({ mensaje: 'No autorizado. Inicia sesión.' });
    // }

    if (!items || items.length === 0) {
        return res.status(400).json({ mensaje: 'El carrito está vacío.' });
    }

    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        const idPedido = 'PED' + nanoid(5);
        let total = 0;

        // Verificar y calcular total
        for (const item of items) {
            // CORREGIDO: Usar iteminventario y idItem para satisfacer FK de lineapedido
            const [productRows] = await connection.query('SELECT stock, precio FROM iteminventario WHERE idItem = ?', [item.idItemInventario]);

            if (productRows.length === 0) {
                throw new Error(`Producto con ID ${item.idItemInventario} no encontrado.`);
            }

            const product = productRows[0];

            if (product.stock < item.cantidad) {
                // throw new Error(`Stock insuficiente para el producto ${item.idItemInventario}. Disponible: ${product.stock}, Solicitado: ${item.cantidad}`);
                // Si el stock es insuficiente, lanzamos error
                return res.status(400).json({ mensaje: `Stock insuficiente.` });
            }

            total += product.precio * item.cantidad;
        }

        // Insertar Pedido
        await connection.query(
            'INSERT INTO pedido (idPedido, estado, total_pedido, estado_pago, idCliente) VALUES (?, ?, ?, ?, ?)',
            [idPedido, 'Procesando', total, 'PENDIENTE', idCliente]
        );

        // Insertar Líneas de Pedido y actualizar stock
        for (const item of items) {
            await connection.query(
                'INSERT INTO lineapedido (idPedido, cantidad, idItemInventario) VALUES (?, ?, ?)',
                [idPedido, item.cantidad, item.idItemInventario]
            );
            // Actualizar stock
            await connection.query(
                'UPDATE iteminventario SET stock = stock - ? WHERE idItem = ?',
                [item.cantidad, item.idItemInventario]
            );
        }

        await connection.commit();
        res.status(201).json({ mensaje: 'Pedido creado con éxito', idPedido });

    } catch (error) {
        if (connection) await connection.rollback();
        console.error(error);
        res.status(500).json({ mensaje: 'Error al guardar el pedido: ' + error.message });
    } finally {
        if (connection) connection.release();
    }
});

// Generar Ticket (Simulado)
router.get('/:id/ticket', (req, res) => {
    const { id } = req.params;
    res.send(`
        <h1>Ticket de Compra</h1>
        <p><strong>Pedido:</strong> ${id}</p>
        <p>Gracias por tu compra en AutoGuest.</p>
        <script>window.print();</script>
    `);
});

module.exports = router;