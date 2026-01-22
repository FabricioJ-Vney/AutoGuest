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

// @route   GET /api/taller/citas-hoy
// @desc    Obtener citas de hoy del taller
// @access  Private (Admin)
router.get('/citas-hoy', isAuthenticated, async (req, res) => {
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

        // Obtener citas de hoy
        const [citas] = await db.query(`
            SELECT c.idCita, c.fechaHora, c.estado,
                   u.nombre as clienteNombre,
                   v.marca, v.placa,
                   m.nombre as mecanicoNombre
            FROM cita c
            JOIN cliente cl ON c.idCliente = cl.idUsuario
            JOIN usuario u ON cl.idUsuario = u.idUsuario
            JOIN vehiculo v ON c.idVehiculo = v.idVehiculo
            JOIN mecanico mec ON c.idMecanico = mec.idUsuario
            JOIN usuario m ON mec.idUsuario = m.idUsuario
            WHERE mec.idTaller = ?
              AND DATE(c.fechaHora) = CURDATE()
            ORDER BY c.fechaHora ASC
        `, [idTaller]);

        res.json(citas);

    } catch (error) {
        console.error('Error al obtener citas de hoy:', error);
        res.status(500).json({ error: 'Error al obtener citas' });
    }
});

// @route   GET /api/taller/citas
// @desc    Obtener todas las citas del taller
// @access  Private (Admin)
router.get('/citas', isAuthenticated, async (req, res) => {
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

        // Obtener todas las citas
        const [citas] = await db.query(`
            SELECT c.idCita, c.fechaHora, c.estado,
                   u.nombre as clienteNombre,
                   v.marca, v.placa,
                   mec.idUsuario as idMecanico,
                   m.nombre as mecanicoNombre
            FROM cita c
            JOIN cliente cl ON c.idCliente = cl.idUsuario
            JOIN usuario u ON cl.idUsuario = u.idUsuario
            JOIN vehiculo v ON c.idVehiculo = v.idVehiculo
            JOIN mecanico mec ON c.idMecanico = mec.idUsuario
            JOIN usuario m ON mec.idUsuario = m.idUsuario
            WHERE mec.idTaller = ?
            ORDER BY c.fechaHora DESC
        `, [idTaller]);

        res.json(citas);

    } catch (error) {
        console.error('Error al obtener citas:', error);
        res.status(500).json({ error: 'Error al obtener citas' });
    }
});

// @route   GET /api/taller/mecanicos
// @desc    Obtener mecánicos del taller
// @access  Private (Admin)
router.get('/mecanicos', isAuthenticated, async (req, res) => {
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

        // Obtener mecánicos del taller
        const [mecanicos] = await db.query(`
            SELECT m.idUsuario, u.nombre, m.especialidad
            FROM mecanico m
            JOIN usuario u ON m.idUsuario = u.idUsuario
            WHERE m.idTaller = ?
            ORDER BY u.nombre ASC
        `, [idTaller]);

        res.json(mecanicos);

    } catch (error) {
        console.error('Error al obtener mecánicos:', error);
        res.status(500).json({ error: 'Error al obtener mecánicos' });
    }
});

// @route   PUT /api/taller/citas/:id/mecanico
// @desc    Cambiar mecánico asignado a una cita
// @access  Private (Admin)
router.put('/citas/:id/mecanico', isAuthenticated, async (req, res) => {
    const { id } = req.params;
    const { idMecanico } = req.body;

    if (!idMecanico) {
        return res.status(400).json({ error: 'ID de mecánico es obligatorio' });
    }

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

        // Verificar que el mecánico pertenece al taller
        const [mecanico] = await db.query(
            'SELECT * FROM mecanico WHERE idUsuario = ? AND idTaller = ?',
            [idMecanico, idTaller]
        );

        if (!mecanico || mecanico.length === 0) {
            return res.status(404).json({ error: 'Mecánico no encontrado en este taller' });
        }

        // Actualizar mecánico de la cita
        await db.query(
            'UPDATE cita SET idMecanico = ? WHERE idCita = ?',
            [idMecanico, id]
        );

        res.json({
            success: true,
            mensaje: 'Mecánico asignado exitosamente'
        });

    } catch (error) {
        console.error('Error al cambiar mecánico:', error);
        res.status(500).json({ error: 'Error al cambiar mecánico' });
    }
});

module.exports = router;
