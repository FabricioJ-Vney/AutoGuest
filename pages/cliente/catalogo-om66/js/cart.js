// Variable global para almacenar el carrito
let cart = [];

// Elementos del DOM
const cartIcon = document.getElementById('cart-icon');
const cartCount = document.getElementById('cart-count');
const modal = document.getElementById('cart-modal');
const closeButton = document.querySelector('.close-button');
const cartItemsContainer = document.getElementById('cart-items');
const cartTotalElement = document.getElementById('cart-total');
const checkoutButton = document.getElementById('checkout-button');

// Cargar carrito desde localStorage al inicio
function loadCartFromLocalStorage() {
    const storedCart = localStorage.getItem('shoppingCart');
    if (storedCart) {
        try {
            const parsedCart = JSON.parse(storedCart);

            // Validar si hay items con IDs antiguos (que no empiezan con "IT")
            // Los IDs nuevos son del tipo "IT01", "IT02"...
            const hasInvalidItems = parsedCart.some(item => !item.id || !item.id.toString().startsWith('IT'));

            if (hasInvalidItems) {
                console.warn('Detectados items con formato antiguo. Reiniciando carrito.');
                alert('Hemos actualizado nuestro inventario. Por favor, vuelve a agregar tus productos al carrito.');
                cart = [];
                localStorage.removeItem('shoppingCart');
                updateCartCount();
                renderCart(); // Asegurar que se limpie la vista
            } else {
                cart = parsedCart;
                updateCartCount();
                renderCart();
            }
        } catch (e) {
            console.error('Error al cargar el carrito:', e);
            cart = [];
            localStorage.removeItem('shoppingCart');
        }
    }
}

// Guardar carrito en localStorage
function saveCartToLocalStorage() {
    localStorage.setItem('shoppingCart', JSON.stringify(cart));
}

// Evento para abrir la modal
cartIcon.addEventListener('click', () => {
    renderCart();
    modal.style.display = 'flex'; // Cambiado a flex para centrar
});

// Evento para cerrar la modal
closeButton.addEventListener('click', () => {
    modal.style.display = 'none';
});

// Cerrar la modal haciendo click fuera de ella
window.addEventListener('click', (event) => {
    if (event.target == modal) {
        modal.style.display = 'none';
    }
});

/**
 * Agrega un producto al carrito o incrementa su cantidad si ya existe.
 */
function addItemToCart(id, name, price, currentStock) {
    const existingItem = cart.find(item => item.id === id);

    if (existingItem) {
        if (existingItem.quantity < currentStock) {
            existingItem.quantity++;
            saveCartToLocalStorage(); // Guardar cambios
            updateCartCount();
            alert(`"${name}" agregado al carrito. Cantidad actual: ${existingItem.quantity}`);
        } else {
            alert(`No hay suficiente stock para "${name}". Stock disponible: ${currentStock}.`);
        }
    } else {
        if (currentStock > 0) {
            cart.push({ id, name, price, quantity: 1 });
            saveCartToLocalStorage(); // Guardar cambios
            updateCartCount();
            alert(`"${name}" agregado al carrito.`);
        } else {
            alert(`"${name}" está agotado y no se puede agregar al carrito.`);
        }
    }
}

/**
 * Actualiza el número de productos en el ícono del carrito.
 */
function updateCartCount() {
    const totalCount = cart.reduce((total, item) => total + item.quantity, 0);
    cartCount.textContent = totalCount;
}

/**
 * Renderiza la lista de productos dentro de la modal del carrito.
 */
function renderCart() {
    cartItemsContainer.innerHTML = ''; // Limpia la lista
    let total = 0;

    if (cart.length === 0) {
        cartItemsContainer.innerHTML = '<li>El carrito está vacío.</li>';
    } else {
        cart.forEach(item => {
            const li = document.createElement('li');
            const subtotal = item.price * item.quantity;
            total += subtotal;

            li.innerHTML = `
                <span>${item.name} (x${item.quantity})</span>
                <span>$${subtotal.toFixed(2)}</span>
            `;
            cartItemsContainer.appendChild(li);
        });
    }

    cartTotalElement.textContent = total.toFixed(2);
}

/**
 * Finaliza la compra enviando el pedido por WhatsApp.
 */
/**
 * Finaliza la compra enviando el pedido por WhatsApp y registrándolo en la BD.
 */
// Elementos del Modal de Pago
const paymentModal = document.getElementById('payment-modal');
const closePaymentButton = document.querySelector('.close-button-payment');
const paymentForm = document.getElementById('payment-form');
const paymentTotalElement = document.getElementById('payment-total');

// Abrir modal de pago al hacer click en "Proceder al Pago"
checkoutButton.addEventListener('click', () => {
    if (cart.length === 0) {
        alert('El carrito está vacío. Agrega productos para finalizar la compra.');
        return;
    }

    // Calcular total
    const total = cart.reduce((acc, item) => acc + (item.price * item.quantity), 0);
    paymentTotalElement.textContent = total.toFixed(2);

    // Cerrar modal del carrito y abrir modal de pago
    modal.style.display = 'none';
    paymentModal.style.display = 'block';
});

// Cerrar modal de pago
closePaymentButton.addEventListener('click', () => {
    paymentModal.style.display = 'none';
});

// Cerrar modal al hacer click fuera
window.addEventListener('click', (event) => {
    if (event.target == paymentModal) {
        paymentModal.style.display = 'none';
    }
    if (event.target == modal) {
        modal.style.display = 'none';
    }
});

// Manejar envío del formulario de pago
paymentForm.addEventListener('submit', async (e) => {
    e.preventDefault();

    // Simulación de procesamiento de pago
    const cardName = document.getElementById('card-name').value;
    const cardNumber = document.getElementById('card-number').value;

    if (cardNumber.length < 16) {
        alert('Por favor, ingresa un número de tarjeta válido.');
        return;
    }

    // Mostrar indicador de carga (opcional)
    const submitBtn = paymentForm.querySelector('button[type="submit"]');
    const originalBtnText = submitBtn.textContent;
    submitBtn.textContent = 'Procesando pago...';
    submitBtn.disabled = true;

    // Simular retardo de red
    await new Promise(resolve => setTimeout(resolve, 1500));

    // Preparar items para la API
    const apiItems = cart.map(item => ({
        idItemInventario: item.id,
        cantidad: item.quantity
    }));

    try {
        // Enviar pedido al backend
        const response = await fetch('/api/pedidos', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                items: apiItems,
                metodoPago: 'Tarjeta',
                detallesPago: {
                    titular: cardName,
                    ultimosDigitos: cardNumber.slice(-4)
                }
            })
        });

        const result = await response.json();

        if (!response.ok) {
            throw new Error(result.mensaje || 'Error al procesar el pedido.');
        }

        alert('¡Pago exitoso! Tu pedido ha sido registrado.');

        // Limpiar carrito
        cart = [];
        saveCartToLocalStorage();
        updateCartCount();
        renderCart();

        paymentModal.style.display = 'none';
        paymentForm.reset();

        // Abrir la nota/ticket en una nueva pestaña
        window.open(`/api/pedidos/${result.idPedido}/ticket`, '_blank');

        // Recargar para actualizar stock visual
        location.reload();

    } catch (error) {
        console.error('Error:', error);
        alert('Error al procesar el pedido: ' + error.message);
    } finally {
        submitBtn.textContent = originalBtnText;
        submitBtn.disabled = false;
    }
});

// Inicializa el contador del carrito y carga desde localStorage
loadCartFromLocalStorage();