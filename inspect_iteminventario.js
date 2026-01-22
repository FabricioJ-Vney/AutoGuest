require('dotenv').config();
const db = require('./config/database');

async function inspect() {
    try {
        console.log('--- Columns of iteminventario ---');
        const [cols] = await db.query('DESCRIBE iteminventario');
        console.table(cols);
        process.exit(0);
    } catch (e) {
        console.log('Error:', e.message);
        process.exit(1);
    }
}
inspect();
