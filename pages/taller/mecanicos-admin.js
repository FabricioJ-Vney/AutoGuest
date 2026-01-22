// Script para ver mecánicos del taller
document.addEventListener('DOMContentLoaded', () => {
    console.log('Mecánicos admin loaded');
    cargarMecanicos();
});

// Cargar mecánicos desde el backend
async function cargarMecanicos() {
    try {
        const response = await fetch('/api/taller/mecanicos');

        if (!response.ok) {
            if (response.status === 401) {
                alert('Tu sesión ha expirado. Por favor, inicia sesión de nuevo.');
                window.location.href = '../../login_taller.html';
                return;
            }
            throw new Error('Error al cargar mecánicos');
        }

        const mecanicos = await response.json();
        mostrarMecanicos(mecanicos);
        actualizarEstadisticas(mecanicos);

    } catch (error) {
        console.error('Error:', error);
        mostrarError();
    }
}

// Mostrar mecánicos en la página
function mostrarMecanicos(mecanicos) {
    const container = document.getElementById('mecanicos-container');

    if (!container) return;

    if (mecanicos.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-users-slash"></i>
                <p>No hay mecánicos registrados en tu taller</p>
                <small style="color: #888;">Contacta al administrador del sistema para agregar mecánicos</small>
            </div>
        `;
        return;
    }

    container.innerHTML = mecanicos.map(mecanico => {
        // Obtener iniciales para el avatar
        const iniciales = mecanico.nombre
            .split(' ')
            .map(n => n[0])
            .join('')
            .substring(0, 2)
            .toUpperCase();

        return `
            <div class="mecanico-card">
                <div class="mecanico-header">
                    <div class="mecanico-avatar">${iniciales}</div>
                    <div class="mecanico-info">
                        <h3>${mecanico.nombre}</h3>
                        <p><i class="fas fa-wrench"></i> ${mecanico.especialidad || 'Mecánico General'}</p>
                    </div>
                </div>
                <div class="mecanico-details">
                    <div class="detail-item">
                        <i class="fas fa-id-badge"></i>
                        <span>ID: ${mecanico.idUsuario}</span>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-check-circle"></i>
                        <span>Disponible</span>
                    </div>
                </div>
            </div>
        `;
    }).join('');
}

// Actualizar estadísticas
function actualizarEstadisticas(mecanicos) {
    // Total de mecánicos
    const totalElement = document.getElementById('total-mecanicos');
    if (totalElement) {
        totalElement.textContent = mecanicos.length;
    }

    // Contar especialidades únicas
    const especialidades = new Set(
        mecanicos
            .map(m => m.especialidad || 'General')
            .filter(e => e)
    );

    const especialidadesElement = document.getElementById('especialidades-count');
    if (especialidadesElement) {
        especialidadesElement.textContent = especialidades.size;
    }
}

// Mostrar error
function mostrarError() {
    const container = document.getElementById('mecanicos-container');
    if (container) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Error al cargar los mecánicos</p>
                <button class="btn" onclick="cargarMecanicos()" style="margin-top: 20px;">
                    <i class="fas fa-redo"></i> Reintentar
                </button>
            </div>
        `;
    }
}
