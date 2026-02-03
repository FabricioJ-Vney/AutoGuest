const express = require('express');
const db = require('../config/database');
const { nanoid } = require('nanoid');
const router = express.Router();

// Middleware de autenticación (Reutilizable)
const isAuthenticated = (req, res, next) => {
    if (req.session.userId) {
        next();
    } else {
        res.status(401).json({ error: 'Acceso no autorizado' });
    }
};

// Crear nueva cita
router.post('/', isAuthenticated, async (req, res) => {
    const { idTaller, idVehiculo, fecha, hora, servicio } = req.body;
    const idCliente = req.session.userId; // Obtener ID del cliente de la sesión

    try {
        // Validación de fecha futura
        const fechaCita = new Date(`${fecha}T${hora}:00`);
        const ahora = new Date();
        if (fechaCita < ahora) {
            return res.status(400).json({ error: 'No se puede agendar una cita en el pasado.' });
        }

        // 0. VERIFICAR QUE EL USUARIO EXISTA EN LA TABLA CLIENTE (Evitar Error FK)
        const [clienteExists] = await db.query('SELECT idUsuario FROM cliente WHERE idUsuario = ?', [idCliente]);
        if (clienteExists.length === 0) {
            // Si no existe, lo insertamos automáticamente
            console.log(`Usuario ${idCliente} no estaba en tabla cliente. Insertando...`);
            await db.query('INSERT INTO cliente (idUsuario) VALUES (?)', [idCliente]);
        }

        // 1. Asignar un mecánico aleatorio de ese taller (OPCIONAL)
        const [mecanicos] = await db.query('SELECT idUsuario FROM mecanico WHERE idTaller = ?', [idTaller]);

        let idMecanico = null;
        if (mecanicos.length > 0) {
            const random = Math.floor(Math.random() * mecanicos.length);
            idMecanico = mecanicos[random].idUsuario;
        } else {
            console.warn("No hay mecánicos en el taller " + idTaller + ". Cita quedará pendiente de asignar.");
        }

        // 2. Crear ID de cita
        const idCita = 'CIT' + nanoid(5);
        const fechaHora = `${fecha} ${hora}:00`;

        // 3. Insertar con idTaller
        await db.query(
            'INSERT INTO cita (idCita, fechaHora, estado, idCliente, idVehiculo, idMecanico, idTaller) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [idCita, fechaHora, 'Pendiente', idCliente, idVehiculo, idMecanico, idTaller]
        );

        res.json({ success: true, message: 'Cita agendada con éxito', idCita });

    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al agendar cita' });
    }
});

// Obtener citas para el taller (autenticado)
router.get('/taller', async (req, res) => {
    // Check session
    if (!req.session.tallerId) {
        return res.status(401).json({ error: 'No autorizado' });
    }

    try {
        const [citas] = await db.query(`
            SELECT c.*, u.nombre as clienteNombre, u.email as clienteEmail, 
                   v.marca as vehiculoMarca, v.placa as vehiculoPlaca, 
                   m.nombre as mecanicoNombre 
            FROM cita c 
            JOIN usuario u ON c.idCliente = u.idUsuario 
            JOIN vehiculo v ON c.idVehiculo = v.idVehiculo 
            LEFT JOIN usuario m ON c.idMecanico = m.idUsuario 
            WHERE c.idTaller = ?
            ORDER BY c.fechaHora DESC
        `, [req.session.tallerId]);
        res.json(citas);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al cargar citas del taller' });
    }
});

// Obtener vehículos de un cliente (Para llenar el select del formulario)
router.get('/vehiculos/:idCliente', async (req, res) => {
    try {
        const [vehiculos] = await db.query('SELECT * FROM vehiculo WHERE idDuenio = ?', [req.params.idCliente]);
        res.json(vehiculos);
    } catch (error) {
        res.status(500).json({ error: 'Error al cargar vehículos' });
    }
});

// Obtener citas del cliente autenticado
router.get('/', isAuthenticated, async (req, res) => {
    const idCliente = req.session.userId;
    try {
        const [citas] = await db.query(`
            SELECT c.idCita, c.fechaHora, c.estado, 
                   COALESCE(t.nombre, 'Taller no disponible') as tallerNombre, 
                   v.marca as vehiculoMarca, v.placa as vehiculoPlaca
            FROM cita c
            JOIN vehiculo v ON c.idVehiculo = v.idVehiculo
            LEFT JOIN mecanico mec ON c.idMecanico = mec.idUsuario
            LEFT JOIN taller t ON mec.idTaller = t.idTaller
            WHERE c.idCliente = ?
            ORDER BY c.fechaHora DESC
        `, [idCliente]);
        res.json(citas);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener citas' });
    }
});

// Obtener detalles de una cita específica
router.get('/:id', isAuthenticated, async (req, res) => {
    const { id } = req.params;
    const idCliente = req.session.userId;

    try {
        const [citas] = await db.query(`
            SELECT c.*, 
                   COALESCE(t.nombre, 'Taller no disponible') as tallerNombre, 
                   t.direccion as tallerDireccion, 
                   v.marca as vehiculoMarca, v.modelo as vehiculoModelo, v.placa as vehiculoPlaca,
                   m.nombre as mecanicoNombre
            FROM cita c
            JOIN vehiculo v ON c.idVehiculo = v.idVehiculo
            LEFT JOIN mecanico mec ON c.idMecanico = mec.idUsuario
            LEFT JOIN taller t ON mec.idTaller = t.idTaller
            LEFT JOIN usuario m ON c.idMecanico = m.idUsuario
            WHERE c.idCita = ? AND c.idCliente = ?
        `, [id, idCliente]);

        if (citas.length === 0) {
            return res.status(404).json({ error: 'Cita no encontrada' });
        }

        res.json(citas[0]);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener detalles de la cita' });
    }
});

// Actualizar estado de cita
router.put('/:id/estado', async (req, res) => {
    const { id } = req.params;
    const { estado } = req.body;

    // Validar que el usuario sea taller (opcional pero recomendado)
    if (!req.session.tallerId) {
        return res.status(401).json({ error: 'No autorizado' });
    }

    try {
        await db.query('UPDATE cita SET estado = ? WHERE idCita = ?', [estado, id]);
        res.json({ success: true, message: 'Estado actualizado' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al actualizar estado' });
    }
});

// Cancelar cita (cliente)
router.delete('/:id', isAuthenticated, async (req, res) => {
    const { id } = req.params;
    const idCliente = req.session.userId;

    try {
        // Verificar que la cita pertenece al cliente
        const [cita] = await db.query(
            'SELECT estado FROM cita WHERE idCita = ? AND idCliente = ?',
            [id, idCliente]
        );

        if (cita.length === 0) {
            return res.status(404).json({ error: 'Cita no encontrada o no tienes permiso para cancelarla' });
        }

        // Validar que no esté completada
        if (cita[0].estado === 'Completado') {
            return res.status(400).json({ error: 'No se puede cancelar una cita ya completada' });
        }

        // Actualizar estado a Cancelado
        await db.query('UPDATE cita SET estado = ? WHERE idCita = ?', ['Cancelado', id]);

        res.json({ success: true, message: 'Cita cancelada exitosamente' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al cancelar la cita' });
    }
});

module.exports = router;