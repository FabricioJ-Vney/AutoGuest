const express = require('express');
const paypal = require('@paypal/checkout-server-sdk');
const paypalClient = require('../config/paypal');
const db = require('../config/database');

const router = express.Router();

// @route   POST /api/paypal/create-order
// @desc    Crear una orden de pago en PayPal basada en una cotización
router.post('/create-order', async (req, res) => {
    const { id_cotizacion } = req.body;

    if (!id_cotizacion) {
        return res.status(400).json({ message: 'El ID de la cotización es requerido.' });
    }

    try {
        // 1. Obtener el monto desde la cotización en la base de datos (temporalmente hardcodeado a 5.00 MXN para depuración)
        // const [rows] = await db.query('SELECT totalAprobado FROM cotizacion WHERE idCotizacion = ?', [id_cotizacion]);
        // if (rows.length === 0) {
        //     return res.status(404).send('Error: Cotización no encontrada.');
        // }
        // const totalAmount = rows[0].totalAprobado.toString();
        const totalAmount = '5.00'; // Monto hardcodeado para depuración
        const currencyCode = 'MXN'; // Moneda en Pesos Mexicanos

        // 2. Crear la orden en PayPal
        const request = new paypal.orders.OrdersCreateRequest();
        request.prefer("return=representation");
        request.requestBody({
            intent: 'CAPTURE',
            purchase_units: [{
                amount: {
                    currency_code: currencyCode,
                    value: totalAmount
                }
            }]
        });

        const order = await paypalClient.execute(request);
        const paypalOrderID = order.result.id;

        // 3. Guardar el ID de la transacción de PayPal en la cotización
        await db.query('UPDATE cotizacion SET id_transaccion = ? WHERE idCotizacion = ?', [paypalOrderID, id_cotizacion]);
        
        console.log(`Orden de PayPal ${paypalOrderID} creada para la cotización ${id_cotizacion}.`);
        res.status(200).json({ orderID: paypalOrderID });

    } catch (err) {
        console.error('Error al crear la orden:', err);
        res.status(500).send('Error al crear la orden de PayPal.');
    }
});

// @route   POST /api/paypal/capture-order
// @desc    Capturar el pago y actualizar el estado en la cotización
router.post('/capture-order', async (req, res) => {
    const { orderID } = req.body;

    const request = new paypal.orders.OrdersCaptureRequest(orderID);
    request.requestBody({});

    try {
        const capture = await paypalClient.execute(request);
        const status = capture.result.status;

        console.log(`Orden ${orderID} capturada con estado: ${status}`);

        if (status === 'COMPLETED') {
            // Actualizamos nuestra base de datos
            const [result] = await db.query(
                'UPDATE cotizacion SET estado_pago = ?, metodo_pago = ? WHERE id_transaccion = ?', 
                ['APROBADO', 'PAYPAL', orderID]
            );
            
            if (result.affectedRows > 0) {
                console.log(`La cotización con PayPal Order ID ${orderID} ha sido marcada como "APROBADO".`);
            } else {
                console.warn(`ADVERTENCIA: No se encontró ninguna cotización para actualizar con el PayPal Order ID ${orderID}.`);
            }

            res.status(200).json({ success: true, message: 'Pago completado con éxito.' });
        } else {
            res.status(400).json({ success: false, message: `El pago no se completó. Estado: ${status}` });
        }

    } catch (err) {
        console.error('Error al capturar el pago:', err);
        res.status(500).send('Error al capturar el pago.');
    }
});

module.exports = router;

