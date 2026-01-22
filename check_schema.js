const db = require('./config/database');

async function checkSchema() {
    try {
        console.log('Checking vehiculo table structure...');
        const [columns] = await db.query('DESCRIBE vehiculo');
        console.log('\nVehiculo table columns:');
        console.table(columns);

        console.log('\nChecking cita table structure...');
        const [citaColumns] = await db.query('DESCRIBE cita');
        console.log('\nCita table columns:');
        console.table(citaColumns);

        process.exit(0);
    } catch (error) {
        console.error('Error:', error);
        process.exit(1);
    }
}

checkSchema();
