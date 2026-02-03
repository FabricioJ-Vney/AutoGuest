const db = require('./config/database');

(async () => {
    try {
        console.log('--- TABLE: taller ---');
        const [tallerCols] = await db.query('SHOW COLUMNS FROM taller');
        console.log(tallerCols.map(c => c.Field).join(', '));

        console.log('\n--- TABLE: mecanico ---');
        const [mecCols] = await db.query('SHOW COLUMNS FROM mecanico');
        console.log(mecCols.map(c => c.Field).join(', '));

        console.log('\n--- TABLE: cita ---');
        const [citaCols] = await db.query('SHOW COLUMNS FROM cita');
        console.log(citaCols.map(c => c.Field).join(', '));

        process.exit(0);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
})();
