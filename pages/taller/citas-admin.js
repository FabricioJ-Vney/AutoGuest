// Script para gestionar citas del taller
document.addEventListener('DOMContentLoaded', () => {
    console.log('Citas admin loaded');

    // Cargar citas y mecánicos
    cargarCitas();
    cargarMecanicos();
});

// Cargar todas las citas del taller
async function cargarCitas() {
    try {
        const response = await fetch('/api/taller/citas');

        if (!response.ok) {
            throw new Error('Error al cargar citas');
        }

        const citas = await response.json();
        mostrarCitas(citas);

    } catch (error) {
        console.error('Error:', error);
        alert('Error al cargar citas');
    }
}

// Mostrar citas en la tabla
function mostrarCitas(citas) {
    const tbody = document.querySelector('#citas-table tbody');

    if (!tbody) return;

    if (citas.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" style="text-align: center; color: #888;">No hay citas registradas</td></tr>';
        return;
    }

    tbody.innerHTML = citas.map(cita => {
        const fecha = new Date(cita.fechaHora).toLocaleDateString('es-ES');
        const hora = new Date(cita.fechaHora).toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' });

        return `
            <tr>
                <td>${fecha} ${hora}</td>
                <td>${cita.clienteNombre}</td>
                <td>${cita.marca} (${cita.placa})</td>
                <td>
                    <select class="select-mecanico" data-cita-id="${cita.idCita}" data-mecanico-actual="${cita.idMecanico}">
                        <option value="">Cargando...</option>
                    </select>
                </td>
                <td><span class="estado-${cita.estado.toLowerCase().replace(/ /g, '-')}">${cita.estado}</span></td>
                <td>
                    <button class="btn-cambiar-mecanico" onclick="cambiarMecanico('${cita.idCita}')">
                        <i class="fas fa-save"></i> Guardar
                    </button>
                </td>
            </tr>
        `;
    }).join('');
}

// Cargar mecánicos disponibles
let mecanicosDisponibles = [];

async function cargarMecanicos() {
    try {
        const response = await fetch('/api/taller/mecanicos');

        if (!response.ok) {
            throw new Error('Error al cargar mecánicos');
        }

        mecanicosDisponibles = await response.json();

        // Actualizar todos los selects de mecánicos
        document.querySelectorAll('.select-mecanico').forEach(select => {
            const mecanicoActual = select.dataset.mecanicoActual;
            select.innerHTML = mecanicosDisponibles.map(mec =>
                `<option value="${mec.idUsuario}" ${mec.idUsuario === mecanicoActual ? 'selected' : ''}>
                    ${mec.nombre} - ${mec.especialidad}
                </option>`
            ).join('');
        });

    } catch (error) {
        console.error('Error:', error);
        alert('Error al cargar mecánicos');
    }
}

// Cambiar mecánico asignado
async function cambiarMecanico(idCita) {
    const select = document.querySelector(`select[data-cita-id="${idCita}"]`);
    const nuevoMecanico = select.value;

    if (!nuevoMecanico) {
        alert('Por favor selecciona un mecánico');
        return;
    }

    try {
        const response = await fetch(`/api/taller/citas/${idCita}/mecanico`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ idMecanico: nuevoMecanico })
        });

        const result = await response.json();

        if (response.ok) {
            alert(result.mensaje);
            cargarCitas();
        } else {
            alert(result.error || 'Error al cambiar mecánico');
        }

    } catch (error) {
        console.error('Error:', error);
        alert('Error al cambiar mecánico');
    }
}

// Cargar citas de hoy para el dashboard
async function cargarCitasHoy() {
    try {
        const response = await fetch('/api/taller/citas-hoy');

        if (!response.ok) {
            throw new Error('Error al cargar citas de hoy');
        }

        const citas = await response.json();

        // Actualizar contador en el dashboard
        const contadorElement = document.getElementById('citas-hoy-count');
        if (contadorElement) {
            contadorElement.textContent = citas.length;
        }

        // Mostrar lista de citas de hoy
        const listaElement = document.getElementById('citas-hoy-lista');
        if (listaElement) {
            if (citas.length === 0) {
                listaElement.innerHTML = '<p style="color: #888;">No hay citas para hoy</p>';
            } else {
                listaElement.innerHTML = citas.map(cita => {
                    const hora = new Date(cita.fechaHora).toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' });
                    return `
                        <div class="cita-hoy-item">
                            <strong>${hora}</strong> - ${cita.clienteNombre}<br>
                            <small>${cita.marca} (${cita.placa}) - ${cita.mecanicoNombre}</small>
                        </div>
                    `;
                }).join('');
            }
        }

    } catch (error) {
        console.error('Error:', error);
    }
}

// Si estamos en el dashboard, cargar citas de hoy
if (window.location.pathname.includes('portal_taller')) {
    cargarCitasHoy();
}
