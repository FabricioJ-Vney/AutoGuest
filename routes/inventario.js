const express = require('express');
const db = require('../config/database');
const router = express.Router();

// Obtener todos los productos del inventario
router.get('/', async (req, res) => {
    try {
        // Usamos iteminventario.
        // Columnas disponibles: idItem, nombre, precio, stock, esParaVenta, imagen (agregada)
        const [rows] = await db.query('SELECT idItem, nombre, precio, stock, imagen FROM iteminventario WHERE stock > 0 AND esParaVenta = 1');

        // Mapeamos para el frontend
        const products = rows.map(row => ({
            id_producto: row.idItem,
            nombre: row.nombre,
            descripcion: 'Sin descripción disponible', // Valor por defecto
            precio: row.precio,
            stock: row.stock,
            imagen: row.imagen // Ahora tomamos la imagen de la BD
        }));

        res.json(products);
    } catch (error) {
        console.error('Error al obtener productos:', error);
        res.status(500).json({ mensaje: 'Error al obtener productos del inventario.' });
    }
});

// Actualizar el stock de un producto (Restock seguro)
router.put('/:id/restock', async (req, res) => {
    const { id } = req.params;
    const { email, password, cantidad } = req.body;

    console.log(`[DEBUG] Intento de reabastecimiento para producto ${id}. Email: ${email}`);

    if (!email || !password || !cantidad) {
        return res.status(400).json({ mensaje: 'Email, contraseña y cantidad son obligatorios.' });
    }

    if (isNaN(cantidad) || cantidad <= 0) {
        return res.status(400).json({ mensaje: 'La cantidad debe ser un número positivo.' });
    }

    try {
        // 1. Verificar credenciales del taller (administrador)
        const [users] = await db.query('SELECT * FROM usuario WHERE email = ?', [email]);

        if (users.length === 0) {
            return res.status(401).json({ mensaje: 'Credenciales inválidas.' });
        }

        const user = users[0];

        // Verificar contraseña
        const bcrypt = require('bcrypt');
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(401).json({ mensaje: 'Credenciales inválidas.' });
        }

        // Verificar si es administrador de taller
        const [admins] = await db.query('SELECT * FROM administrador WHERE idUsuario = ?', [user.idUsuario]);

        if (admins.length === 0) {
            return res.status(403).json({ mensaje: 'No tiene permisos de administrador para reabastecer.' });
        }

        // 2. Actualizar stock
        // Sumamos la cantidad al stock actual
        await db.query('UPDATE iteminventario SET stock = stock + ? WHERE idItem = ?', [cantidad, id]); // Usamos tabla y columna correcta

        res.json({ mensaje: `Stock reabastecido correctamente.`, nuevoStock: -1 });

    } catch (error) {
        console.error('Error al reabastecer:', error);
        res.status(500).json({ mensaje: 'Error interno al reabastecer.' });
    }
});

module.exports = router;
