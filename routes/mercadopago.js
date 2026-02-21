const express = require('express');
const router = express.Router();
const { Preference } = require('mercadopago');
const client = require('../config/mercadopago');
const db = require('../config/database');

// Almacén temporal en memoria para mapear preferenceId -> { items, total }
const tempPreferences = new Map();

// Ruta para obtener la clave pública de MercadoPago
router.get('/public-key', (req, res) => {
    res.json({ publicKey: process.env.MP_PUBLIC_KEY });
});

router.post('/create-preference', async (req, res) => {
    const { items, total, id_cotizacion } = req.body;

    try {
        console.log('Solicitud recibida:', { items, total, id_cotizacion });

        let amount = parseFloat(total) || 0;
        let itemsList = items || [];

        // Si hay id_cotizacion (servicio de taller), obtener el monto de la cotización
        if (id_cotizacion && !amount) {
            const [rows] = await db.query('SELECT totalAprobado FROM cotizacion WHERE idCotizacion = ?', [id_cotizacion]);
            if (rows.length === 0) {
                return res.status(404).json({ error: 'Cotización no encontrada.' });
            }
            amount = rows[0].totalAprobado;
            itemsList = [{
                title: 'Servicio de Taller',
                unit_price: amount,
                quantity: 1,
                description: 'Servicio de Taller'
            }];
        }

        // Convertir precios a números en items del cliente
        if (itemsList.length > 0 && !id_cotizacion) {
            itemsList = itemsList.map(item => ({
                title: item.title || 'Producto',
                unit_price: parseFloat(item.unit_price) || 0,
                quantity: parseInt(item.quantity) || 1,
                description: item.description || ''
            }));
        }

        // Validar que tengamos al menos un monto
        if (!amount || amount <= 0) {
            return res.status(400).json({ error: 'Monto inválido o no proporcionado.' });
        }

        // Si no hay items, crear uno por defecto
        if (itemsList.length === 0) {
            itemsList = [{
                title: 'Compra de Productos',
                unit_price: amount,
                quantity: 1,
                description: 'Compra de productos'
            }];
        }

        const preference = new Preference(client);

        const preferenceBody = {
            items: itemsList,
            back_urls: {
                success: 'http://localhost:3000/pages/cliente/catalogo-om66/mercadopago_retorno.html?status=success',
                failure: 'http://localhost:3000/pages/cliente/catalogo-om66/mercadopago_retorno.html?status=failure',
                pending: 'http://localhost:3000/pages/cliente/catalogo-om66/mercadopago_retorno.html?status=pending'
            },
            external_reference: `catalogo_${Date.now()}`
        };

        const response = await preference.create(preferenceBody);

        console.log('Respuesta de MP:', response);

        // Guardar en memoria
        tempPreferences.set(response.id, { items: itemsList, total: amount });

        // Intentar crear pedido provisional en BD (solo para catálogo, no para cotizaciones de taller)
        if (!id_cotizacion) {
            try {
                const insertQuery = `
                    INSERT INTO pedidos_catalogo (items, total, estado, metodo_pago, id_transaccion_externa)
                    VALUES (?, ?, ?, ?, ?)
                `;
                const [result] = await db.query(insertQuery, [JSON.stringify(itemsList), amount, 'pendiente', 'mercadopago', response.id]);
                tempPreferences.set(response.id, Object.assign(tempPreferences.get(response.id) || {}, { idPedido: result.insertId }));
                console.log('Pedido provisional creado con id:', result.insertId);
            } catch (e) {
                console.warn('No se pudo crear pedido provisional en BD:', e);
            }
        }

        // Devolver init_point e idPedido provisional
        const tempData = tempPreferences.get(response.id) || {};
        res.json({ id: response.id, preferenceId: response.id, init_point: response.init_point, idPedido: tempData.idPedido || null });
    } catch (error) {
        console.error('Error en create-preference:', error);
        res.status(500).json({ error: 'Error al crear preferencia de pago: ' + error.message });
    }
});

// Ruta para recuperar items/total guardados temporalmente por preference id
router.get('/preference/:preferenceId', (req, res) => {
    const { preferenceId } = req.params;
    if (!preferenceId) return res.status(400).json({ error: 'preferenceId requerido' });

    const data = tempPreferences.get(preferenceId);
    if (!data) return res.status(404).json({ error: 'No se encontró data para esa preferencia' });

    res.json({ items: data.items, total: data.total });
});

module.exports = router;
