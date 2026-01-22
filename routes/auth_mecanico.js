const express = require('express');
const { nanoid } = require('nanoid');
const db = require('../config/database');
const router = express.Router();

// --- REGISTRO DE MECÁNICO ---
router.post('/registro', async (req, res) => {
    // 1. AHORA RECIBIMOS 'especialidad' TAMBIÉN
    const { nombre, email, password, telefono, idTaller, especialidad } = req.body;

    // --- Validaciones ---
    if (!nombre || !email || !password || !telefono || !idTaller || !especialidad) {
        return res.status(400).json({ mensaje: 'Todos los campos son obligatorios.' });
    }

    const telefonoRegex = /^\d{10}$/;
    if (!telefonoRegex.test(telefono)) {
        return res.status(400).json({ mensaje: 'El teléfono debe tener 10 dígitos.' });
    }

    try {
        // 2. Validar Taller
        const [taller] = await db.query('SELECT idTaller FROM taller WHERE idTaller = ?', [idTaller]);
        if (taller.length === 0) {
            return res.status(400).json({ mensaje: 'ID de Taller no válido.' });
        }

        // 3. Validar Email Duplicado
        const [userExists] = await db.query('SELECT email FROM usuario WHERE email = ?', [email]);
        if (userExists.length > 0) {
            return res.status(400).json({ mensaje: 'El correo ya está registrado.' });
        }

        // 4. Crear Usuario
        const idUsuario = 'MEC' + nanoid(7);

        // Guardar en tabla USUARIO
        await db.query(
            'INSERT INTO usuario (idUsuario, nombre, email, password, telefono) VALUES (?, ?, ?, ?, ?)',
            [idUsuario, nombre, email, password, telefono]
        );

        // 5. Guardar en tabla MECANICO con la ESPECIALIDAD
        await db.query(
            'INSERT INTO mecanico (idUsuario, idTaller, especialidad) VALUES (?, ?, ?)',
            [idUsuario, idTaller, especialidad] // <--- Aquí usamos el dato real
        );

        res.status(201).json({ success: true, mensaje: 'Mecánico registrado exitosamente.' });

    } catch (error) {
        console.error(error);
        res.status(500).json({ mensaje: 'Error en el servidor.' });
    }
});

// ... (El resto del archivo con el login y demás rutas se queda igual) ...
// --- LOGIN DE MECÁNICO ---
router.post('/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        const [users] = await db.query('SELECT * FROM usuario WHERE email = ?', [email]);
        if (users.length === 0) return res.status(401).json({ mensaje: 'Usuario no encontrado.' });

        const user = users[0];
        if (password !== user.password) return res.status(401).json({ mensaje: 'Contraseña incorrecta.' });

        const [mecanico] = await db.query('SELECT * FROM mecanico WHERE idUsuario = ?', [user.idUsuario]);
        if (mecanico.length === 0) return res.status(403).json({ mensaje: 'No tienes cuenta de mecánico.' });

        req.session.userId = user.idUsuario;
        req.session.role = 'mecanico';
        req.session.tallerId = mecanico[0].idTaller;

        res.status(200).json({
            success: true,
            redirectTo: 'portal_mecanico.html',
            userName: user.nombre
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({ mensaje: 'Error al iniciar sesión.' });
    }
});

// --- OBTENER CITAS ASIGNADAS AL MECÁNICO ---
router.get('/mis-citas', async (req, res) => {
    if (!req.session.userId || req.session.role !== 'mecanico') {
        return res.status(401).json({ error: 'No autorizado' });
    }

    try {
        const [citas] = await db.query(`
            SELECT c.idCita, c.fechaHora, c.estado, 
                   v.marca, v.modelo, v.placa, 
                   u.nombre as clienteNombre
            FROM cita c
            JOIN vehiculo v ON c.idVehiculo = v.idVehiculo
            JOIN usuario u ON c.idCliente = u.idUsuario
            WHERE c.idMecanico = ?
            ORDER BY c.fechaHora ASC
        `, [req.session.userId]);

        res.json(citas);
    } catch (error) {
        res.status(500).json({ error: 'Error al cargar citas' });
    }
});

// --- CREAR COTIZACIÓN (DIAGNÓSTICO) ---
router.post('/cotizar', async (req, res) => {
    if (!req.session.userId || req.session.role !== 'mecanico') return res.status(401).json({ error: 'No autorizado' });

    const { idCita, diagnostico, manoObra, refacciones } = req.body;
    const total = parseFloat(manoObra) + parseFloat(refacciones);
    const idCotizacion = 'COT' + nanoid(6);

    try {
        // 1. Crear cotización
        await db.query(
            'INSERT INTO cotizacion (idCotizacion, idCita, diagnostico, mano_obra, costo_refacciones, totalAprobado, estado_pago) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [idCotizacion, idCita, diagnostico, manoObra, refacciones, total, 'PENDIENTE']
        );

        // 2. Actualizar estado de la cita
        await db.query('UPDATE cita SET estado = ? WHERE idCita = ?', ['Cotizado', idCita]);

        res.json({ success: true, mensaje: 'Cotización enviada al cliente.' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al guardar cotización' });
    }
});

// --- CREAR ORDEN EXPRESS (NUEVO TRABAJO / WALK-IN) ---
router.post('/crear-orden-express', async (req, res) => {
    if (!req.session.userId || req.session.role !== 'mecanico') {
        return res.status(401).json({ error: 'No autorizado' });
    }

    const { nombreCliente, telefonoCliente, marca, modelo, placa, notaInicial } = req.body;
    const idMecanico = req.session.userId;
    const idTaller = req.session.tallerId;

    if (!nombreCliente || !telefonoCliente || !marca || !placa) {
        return res.status(400).json({ error: 'Faltan datos obligatorios.' });
    }

    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        // 1. Buscar o Crear Usuario (Cliente)
        let idCliente;
        const [existingUser] = await connection.query('SELECT idUsuario FROM usuario WHERE email = ? OR telefono = ?', [telefonoCliente + "@temp.com", telefonoCliente]); // Hack para email unico si no se pide

        if (existingUser.length > 0) {
            idCliente = existingUser[0].idUsuario;
        } else {
            idCliente = 'CLI' + nanoid(7);
            // Creamos usuario con telefono como password temporal
            const fakeEmail = telefonoCliente + "@temp.com";
            await connection.query(
                'INSERT INTO usuario (idUsuario, nombre, email, password, telefono) VALUES (?, ?, ?, ?, ?)',
                [idCliente, nombreCliente, fakeEmail, telefonoCliente, telefonoCliente]
            );
            // Insertar en tabla cliente tambien si es necesario por integridad referencial
            await connection.query('INSERT INTO cliente (idUsuario) VALUES (?)', [idCliente]);
        }

        // 2. Buscar o Crear Vehiculo
        let idVehiculo;
        const [existingCar] = await connection.query('SELECT idVehiculo FROM vehiculo WHERE placa = ?', [placa]);

        if (existingCar.length > 0) {
            idVehiculo = existingCar[0].idVehiculo;
        } else {
            idVehiculo = 'VEH' + nanoid(7);
            await connection.query(
                'INSERT INTO vehiculo (idVehiculo, idDuenio, marca, modelo, placa, anio) VALUES (?, ?, ?, ?, ?, ?)',
                [idVehiculo, idCliente, marca, modelo, placa, new Date().getFullYear()]
            );
        }

        // 3. Crear Cita
        const idCita = 'CIT' + nanoid(5);
        // Fecha actual
        const now = new Date();
        const fechaHora = now.toISOString().slice(0, 19).replace('T', ' ');

        await connection.query(
            'INSERT INTO cita (idCita, fechaHora, estado, idCliente, idVehiculo, idMecanico) VALUES (?, ?, ?, ?, ?, ?)',
            [idCita, fechaHora, 'Pendiente', idCliente, idVehiculo, idMecanico]
        );

        await connection.commit();
        res.json({ success: true, message: 'Trabajo creado exitosamente', idCita });

    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error al crear orden express:', error);
        res.status(500).json({ error: 'Error al crear la orden.' });
    } finally {
        if (connection) connection.release();
    }
});

module.exports = router;