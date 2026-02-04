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

// @route   GET /api/taller/stats
// @desc    Obtener estadísticas generales del taller (incluyendo contador de mecánicos)
// @access  Private (Admin)
router.get('/stats', isAuthenticated, async (req, res) => {
    try {
        const [admin] = await db.query('SELECT idTaller FROM administrador WHERE idUsuario = ?', [req.session.userId]);
        if (!admin || admin.length === 0) return res.status(404).json({ error: 'Taller no encontrado' });
        const idTaller = admin[0].idTaller;

        const [mecanicos] = await db.query('SELECT COUNT(*) as total FROM mecanico WHERE idTaller = ?', [idTaller]);
        const [clientes] = await db.query(`
            SELECT COUNT(DISTINCT c.idCliente) as total 
            FROM cita c 
            JOIN mecanico m ON c.idMecanico = m.idUsuario 
            WHERE m.idTaller = ?`, [idTaller]);

        res.json({
            mecanicos: mecanicos[0].total,
            clientes: clientes[0].total
        });
    } catch (error) {
        console.error('Error stats:', error);
        res.status(500).json({ error: 'Error al obtener estadísticas' });
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

// @route   GET /api/taller/info
// @desc    Obtener información básica del taller (ID para compartir)
// @access  Private (Admin)
router.get('/info', isAuthenticated, async (req, res) => {
    try {
        const [admin] = await db.query(`
            SELECT t.idTaller, t.nombre, t.direccion 
            FROM administrador a
            JOIN taller t ON a.idTaller = t.idTaller
            WHERE a.idUsuario = ?
        `, [req.session.userId]);

        if (!admin || admin.length === 0) return res.status(404).json({ error: 'Taller no encontrado' });

        res.json(admin[0]);
    } catch (error) {
        console.error('Error info:', error);
        res.status(500).json({ error: 'Error al obtener información' });
    }
});

module.exports = router;
