const express = require('express');
const db = require('../config/database');
const { nanoid } = require('nanoid');
const router = express.Router();

// ============================================================
// INICIALIZAR TABLA DE CHAT (se crea automáticamente si no existe)
// ============================================================
async function initChatTable() {
    try {
        await db.query(`
            CREATE TABLE IF NOT EXISTS chat_mensaje (
                idMensaje VARCHAR(20) PRIMARY KEY,
                idCita VARCHAR(20) NOT NULL,
                remitenteId VARCHAR(20) NOT NULL,
                remitenteTipo ENUM('cliente', 'mecanico') NOT NULL,
                tipoContenido ENUM('texto', 'imagen') NOT NULL DEFAULT 'texto',
                contenido LONGTEXT NOT NULL,
                nombreArchivo VARCHAR(255) NULL,
                leido TINYINT(1) NOT NULL DEFAULT 0,
                fechaEnvio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                INDEX idx_idCita (idCita),
                INDEX idx_fechaEnvio (fechaEnvio)
            )
        `);
        console.log('[Chat] Tabla chat_mensaje verificada/creada correctamente.');
    } catch (err) {
        console.error('[Chat] Error al crear tabla chat_mensaje:', err.message);
    }
}

// Ejecutar al cargar el módulo
initChatTable();

// ============================================================
// IMPORTANTE: Las rutas MÁS ESPECÍFICAS van PRIMERO en Express
// ============================================================

// GET /api/chat/:idCita/no-leidos - Contar mensajes no leídos (PRIMERO - más específica)
router.get('/:idCita/no-leidos', async (req, res) => {
    const { idCita } = req.params;
    const userId = req.session.userId;
    const role = req.session.role;

    if (!userId) {
        return res.status(401).json({ error: 'No autorizado' });
    }

    try {
        const otroTipo = role === 'mecanico' ? 'cliente' : 'mecanico';
        const [result] = await db.query(
            'SELECT COUNT(*) as total FROM chat_mensaje WHERE idCita = ? AND remitenteTipo = ? AND leido = 0',
            [idCita, otroTipo]
        );
        res.json({ noLeidos: result[0].total });
    } catch (error) {
        console.error('[Chat] Error al contar mensajes:', error);
        res.status(500).json({ error: 'Error al contar mensajes' });
    }
});

// ============================================================
// GET /api/chat/:idCita - Obtener historial de mensajes
// ============================================================
router.get('/:idCita', async (req, res) => {
    const { idCita } = req.params;

    const userId = req.session.userId;
    const role = req.session.role;

    if (!userId) {
        return res.status(401).json({ error: 'No autorizado' });
    }

    try {
        // Verificar que la cita existe y el usuario tiene relación con ella
        let citaQuery;
        if (role === 'mecanico') {
            citaQuery = await db.query(
                'SELECT idCita FROM cita WHERE idCita = ? AND idMecanico = ?',
                [idCita, userId]
            );
        } else {
            // Cliente
            citaQuery = await db.query(
                'SELECT idCita FROM cita WHERE idCita = ? AND idCliente = ?',
                [idCita, userId]
            );
        }

        if (citaQuery[0].length === 0) {
            return res.status(403).json({ error: 'No tienes acceso a este chat' });
        }

        // Obtener mensajes ordenados por fecha
        const [mensajes] = await db.query(`
            SELECT 
                m.idMensaje,
                m.remitenteId,
                m.remitenteTipo,
                m.tipoContenido,
                m.contenido,
                m.nombreArchivo,
                m.leido,
                m.fechaEnvio,
                u.nombre AS remitenteNombre
            FROM chat_mensaje m
            JOIN usuario u ON m.remitenteId = u.idUsuario
            WHERE m.idCita = ?
            ORDER BY m.fechaEnvio ASC
        `, [idCita]);

        // Marcar como leídos los mensajes del otro participante
        const otroTipo = role === 'mecanico' ? 'cliente' : 'mecanico';
        await db.query(
            'UPDATE chat_mensaje SET leido = 1 WHERE idCita = ? AND remitenteTipo = ? AND leido = 0',
            [idCita, otroTipo]
        );

        res.json(mensajes);
    } catch (error) {
        console.error('[Chat] Error al obtener mensajes:', error);
        res.status(500).json({ error: 'Error al obtener mensajes' });
    }
});

// ============================================================
// POST /api/chat/:idCita - Enviar un mensaje (texto o imagen)
// ============================================================
router.post('/:idCita', async (req, res) => {
    const { idCita } = req.params;
    const { contenido, tipoContenido, nombreArchivo } = req.body;

    const userId = req.session.userId;
    const role = req.session.role;

    if (!userId) {
        return res.status(401).json({ error: 'No autorizado' });
    }

    if (!contenido || !tipoContenido) {
        return res.status(400).json({ error: 'Contenido y tipo de contenido son requeridos' });
    }

    // Validar tipos permitidos
    if (!['texto', 'imagen'].includes(tipoContenido)) {
        return res.status(400).json({ error: 'Tipo de contenido no válido' });
    }

    // Validar tamaño de imagen (máx 5MB en base64 = ~6.7MB de texto)
    if (tipoContenido === 'imagen' && contenido.length > 7000000) {
        return res.status(400).json({ error: 'La imagen es demasiado grande. Máximo 5MB.' });
    }

    // Determinar el tipo de remitente
    const remitenteTipo = role === 'mecanico' ? 'mecanico' : 'cliente';

    try {
        // Verificar acceso a la cita
        let citaQuery;
        if (role === 'mecanico') {
            citaQuery = await db.query(
                'SELECT idCita FROM cita WHERE idCita = ? AND idMecanico = ?',
                [idCita, userId]
            );
        } else {
            citaQuery = await db.query(
                'SELECT idCita FROM cita WHERE idCita = ? AND idCliente = ?',
                [idCita, userId]
            );
        }

        if (citaQuery[0].length === 0) {
            return res.status(403).json({ error: 'No tienes acceso a este chat' });
        }

        const idMensaje = 'MSG' + nanoid(7);

        await db.query(
            `INSERT INTO chat_mensaje 
                (idMensaje, idCita, remitenteId, remitenteTipo, tipoContenido, contenido, nombreArchivo)
             VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [idMensaje, idCita, userId, remitenteTipo, tipoContenido, contenido, nombreArchivo || null]
        );

        // Devolver el mensaje recién creado con nombre del remitente
        const [nuevoMensaje] = await db.query(`
            SELECT 
                m.idMensaje,
                m.remitenteId,
                m.remitenteTipo,
                m.tipoContenido,
                m.contenido,
                m.nombreArchivo,
                m.leido,
                m.fechaEnvio,
                u.nombre AS remitenteNombre
            FROM chat_mensaje m
            JOIN usuario u ON m.remitenteId = u.idUsuario
            WHERE m.idMensaje = ?
        `, [idMensaje]);

        res.status(201).json({ success: true, mensaje: nuevoMensaje[0] });
    } catch (error) {
        console.error('[Chat] Error al enviar mensaje:', error);
        res.status(500).json({ error: 'Error al enviar mensaje' });
    }
});

// ============================================================
// GET /api/chat/taller/conversaciones - Ver TODOS los chats del taller (SOLO DUEÑO)
// Monitoreo de seguridad: el dueño puede ver conversaciones entre mecánicos y clientes
// ============================================================
router.get('/taller/conversaciones', async (req, res) => {
    const userId = req.session.userId;
    const role = req.session.role;

    // Permitir acceso solo a administradores del taller
    if (!userId || role !== 'taller') {
        return res.status(403).json({ error: 'No autorizado. Solo el dueño/administrador del taller puede ver esto.' });
    }

    try {
        // Obtener el tallerId de la sesión (debe estar establecido en login)
        const tallerId = req.session.tallerId;
        
        if (!tallerId) {
            return res.status(400).json({ error: 'ID de taller no encontrado en sesión.' });
        }

        // Obtener todas las citas de este taller
        const [citas] = await db.query(`
            SELECT c.idCita, c.idCliente, c.idMecanico, c.estado, c.fecha
            FROM cita c
            WHERE c.idTaller = ?
            ORDER BY c.fecha DESC
        `, [tallerId]);

        // Para cada cita, obtener los mensajes
        const conversaciones = [];
        for (const cita of citas) {
            const [mensajes] = await db.query(`
                SELECT 
                    m.idMensaje,
                    m.remitenteId,
                    m.remitenteTipo,
                    m.tipoContenido,
                    m.contenido,
                    m.nombreArchivo,
                    m.leido,
                    m.fechaEnvio,
                    u.nombre AS remitenteNombre,
                    u.email AS remitenteEmail
                FROM chat_mensaje m
                JOIN usuario u ON m.remitenteId = u.idUsuario
                WHERE m.idCita = ?
                ORDER BY m.fechaEnvio ASC
            `, [cita.idCita]);

            conversaciones.push({
                idCita: cita.idCita,
                estadoCita: cita.estado,
                fechaCita: cita.fecha,
                mensajes: mensajes
            });
        }

        res.json({ conversaciones });
    } catch (error) {
        console.error('[Chat] Error al obtener conversaciones del taller:', error);
        res.status(500).json({ error: 'Error al obtener conversaciones' });
    }
});

// ============================================================
// GET /api/chat/taller/cita/:idCita - Ver chat de UNA CITA específica (SOLO DUEÑO)
// ============================================================
router.get('/taller/cita/:idCita', async (req, res) => {
    const { idCita } = req.params;
    const userId = req.session.userId;
    const role = req.session.role;

    // Permitir acceso solo a administradores del taller
    if (!userId || role !== 'taller') {
        return res.status(403).json({ error: 'No autorizado. Solo el dueño/administrador del taller puede ver esto.' });
    }

    try {
        const tallerId = req.session.tallerId;
        
        if (!tallerId) {
            return res.status(400).json({ error: 'ID de taller no encontrado en sesión.' });
        }

        // Verificar que la cita pertenece al taller del usuario
        const [citaVerify] = await db.query(`
            SELECT c.idCita, c.idCliente, c.idMecanico, c.estado, c.fecha,
                   u_cliente.nombre AS nombreCliente,
                   u_mecanico.nombre AS nombreMecanico
            FROM cita c
            JOIN usuario u_cliente ON c.idCliente = u_cliente.idUsuario
            JOIN usuario u_mecanico ON c.idMecanico = u_mecanico.idUsuario
            WHERE c.idTaller = ? AND c.idCita = ?
        `, [tallerId, idCita]);

        if (citaVerify.length === 0) {
            return res.status(403).json({ error: 'No tienes acceso a esta cita' });
        }

        const citaInfo = citaVerify[0];

        // Obtener todos los mensajes de la cita
        const [mensajes] = await db.query(`
            SELECT 
                m.idMensaje,
                m.remitenteId,
                m.remitenteTipo,
                m.tipoContenido,
                m.contenido,
                m.nombreArchivo,
                m.leido,
                m.fechaEnvio,
                u.nombre AS remitenteNombre,
                u.email AS remitenteEmail
            FROM chat_mensaje m
            JOIN usuario u ON m.remitenteId = u.idUsuario
            WHERE m.idCita = ?
            ORDER BY m.fechaEnvio ASC
        `, [idCita]);

        res.json({
            cita: {
                idCita: citaInfo.idCita,
                nombreCliente: citaInfo.nombreCliente,
                nombreMecanico: citaInfo.nombreMecanico,
                estado: citaInfo.estado,
                fecha: citaInfo.fecha
            },
            mensajes: mensajes
        });
    } catch (error) {
        console.error('[Chat] Error al obtener chat de cita:', error);
        res.status(500).json({ error: 'Error al obtener chat de la cita' });
    }
});

module.exports = router;
