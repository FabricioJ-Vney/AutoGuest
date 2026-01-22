// 1. Cargar variables de entorno
require('dotenv').config();

// 2. Importar dependencias
const express = require('express');
const path = require('path');
const cors = require('cors'); // Importar CORS
const session = require('express-session');
const paymentRoutes = require('./routes/payment');
const mercadopagoRoutes = require('./routes/mercadopago');
const authRoutes = require('./routes/auth');
const vehiculosRoutes = require('./routes/vehiculos');
const talleresRoutes = require('./routes/talleres'); // <--- Importar
const tallerAuthRoutes = require('./routes/taller_auth');
const citasRoutes = require('./routes/citas');
const pedidosRoutes = require('./routes/pedidos');
const perfilRoutes = require('./routes/perfil');
const resenasRoutes = require('./routes/resenas');
const tallerServiciosRoutes = require('./routes/taller_servicios');
const tallerCitasRoutes = require('./routes/taller_citas');
const tallerAdminRoutes = require('./routes/taller_admin');
const mecanicoRoutes = require('./routes/auth_mecanico');
const inventarioRoutes = require('./routes/inventario');

// 3. Inicializar la aplicación de Express
const app = express();

// 4. Middlewares
app.use(cors()); // Usar CORS para permitir peticiones
app.use(express.json()); // Para poder entender JSON en el cuerpo de las peticiones

// Configuración de express-session
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // Poner en true si usas HTTPS
}));

// Servir archivos estáticos (nuestros archivos HTML, CSS, JS del frontend)
app.use(express.static(path.join(__dirname)));


app.use('/api/talleres', talleresRoutes); // <--- Usar

app.use('/api/registro', tallerAuthRoutes);
app.use('/api/citas', citasRoutes);

// Rutas del portal de taller
app.use('/api/taller', tallerServiciosRoutes);
app.use('/api/taller', tallerCitasRoutes);
app.use('/api/taller', tallerAdminRoutes);

// Usar las rutas de pago
app.use('/api/paypal', paymentRoutes);
app.use('/api/mercadopago', mercadopagoRoutes);

// Usar las rutas de autenticación
app.use('/api/registro', authRoutes);

// Usar las rutas de vehículos
app.use('/api/vehiculos', vehiculosRoutes);
app.use('/api/pedidos', pedidosRoutes);
app.use('/api/perfil', perfilRoutes);
app.use('/api/resenas', resenasRoutes);
app.use('/api/inventario', inventarioRoutes);

app.use('/api/mecanico', mecanicoRoutes);
app.use('/api/taller/citas', require('./routes/taller_citas'));
app.use('/api/taller/servicios', tallerServiciosRoutes);

// 5. Rutas
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Ruta para EDITAR (PUT)
app.put('/api/taller/servicios/:id', (req, res) => {
    const id = req.params.id;
    const { nombre, descripcion, precio } = req.body;

    const sql = "UPDATE servicios SET nombre = ?, descripcion = ?, precio = ? WHERE id = ?";
    
    db.query(sql, [nombre, descripcion, precio, id], (err, result) => {
        if (err) {
            console.error(err);
            // IMPORTANTE: Responder con error si falla
            return res.status(500).json({ error: "Error al actualizar en BD" });
        }

        // 🚨 AQUÍ ES DONDE SUELE FALTAR EL CÓDIGO 🚨
        // Si no pones esta línea, el botón se queda "Procesando..." para siempre
        res.json({ message: "Servicio actualizado correctamente", success: true });
    });
});
// CÓDIGO TEMPORAL PARA OBTENER HASH
const bcrypt = require('bcryptjs');
bcrypt.hash('12345', 10, function (err, hash) {
    console.log("---------------------------------------------------");
    console.log("COPIA ESTE CÓDIGO Y PÉGALO EN TU BASE DE DATOS:");
    console.log(hash);
    console.log("---------------------------------------------------");
});

// Ruta para CREAR (POST)
app.post('/api/taller/servicios', (req, res) => {
    const { nombre, descripcion, precio } = req.body;

    const sql = "INSERT INTO servicios (nombre, descripcion, precio) VALUES (?, ?, ?)";
    
    db.query(sql, [nombre, descripcion, precio], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Error al insertar en BD" });
        }

        // IMPORTANTE: Responder al finalizar
        res.json({ message: "Servicio creado correctamente", id: result.insertId });
    });
});
// 6. Iniciar el servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});