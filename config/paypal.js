const paypal = require('@paypal/checkout-server-sdk');

// 1. Configurar el entorno de PayPal
const environment = new paypal.core.LiveEnvironment(
    process.env.PAYPAL_CLIENT_ID,
    process.env.PAYPAL_CLIENT_SECRET
);

const client = new paypal.core.PayPalHttpClient(environment);

module.exports = client;
