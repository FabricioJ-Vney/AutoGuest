const express = require('express');
const db = require('../config/database');
const router = express.Router();

// Middleware de autenticación para administrador de taller
const isAuthenticated = (req, res, next) => {
    if (req.session.userId && req.session.role === 'taller') {
        next();
    } else {
        res.status(401).json({ error: 'Acceso no autorizado' });
    }
};

// @route   GET /api/taller/clientes
// @desc    Obtener clientes que han tenido citas en el taller
// @access  Private (Admin)
router.get('/clientes', isAuthenticated, async (req, res) => {
    try {
        // Obtener idTaller del administrador
        const [admin] = await db.query(
            'SELECT idTaller FROM administrador WHERE idUsuario = ?',
            [req.session.userId]
        );

        if (!admin || admin.length === 0) {
            return res.status(404).json({ error: 'Taller no encontrado' });
        }

        const idTaller = admin[0].idTaller;

        // Obtener clientes con citas en este taller
        const [clientes] = await db.query(`
            SELECT DISTINCT u.idUsuario, u.nombre, u.email, u.telefono,
                   COUNT(c.idCita) as totalCitas,
                   MAX(c.fechaHora) as ultimaCita
            FROM usuario u
            JOIN cliente cl ON u.idUsuario = cl.idUsuario
            JOIN cita c ON cl.idUsuario = c.idCliente
            JOIN mecanico m ON c.idMecanico = m.idUsuario
            WHERE m.idTaller = ?
            GROUP BY u.idUsuario, u.nombre, u.email, u.telefono
            ORDER BY totalCitas DESC
        `, [idTaller]);

        res.json(clientes);

    } catch (error) {
        console.error('Error al obtener clientes:', error);
        res.status(500).json({ error: 'Error al obtener clientes' });
    }
});

// @route   GET /api/taller/resenas
// @desc    Obtener reseñas del taller
// @access  Private (Admin)
router.get('/resenas', isAuthenticated, async (req, res) => {
    try {
        // Obtener idTaller del administrador
        const [admin] = await db.query(
            'SELECT idTaller FROM administrador WHERE idUsuario = ?',
            [req.session.userId]
        );

        if (!admin || admin.length === 0) {
            return res.status(404).json({ error: 'Taller no encontrado' });
        }

        const idTaller = admin[0].idTaller;

        // Obtener reseñas del taller
        const [resenas] = await db.query(`
            SELECT r.idResena, r.calificacion, r.comentario, r.fecha,
                   u.nombre as clienteNombre
            FROM resenas r
            JOIN usuario u ON r.idUsuario = u.idUsuario
            WHERE r.idTaller = ?
            ORDER BY r.fecha DESC
        `, [idTaller]);

        res.json(resenas);

    } catch (error) {
        console.error('Error al obtener reseñas:', error);
        res.status(500).json({ error: 'Error al obtener reseñas' });
    }
});

module.exports = router;
