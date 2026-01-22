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
checkoutButton.addEventListener('click', async () => {
    if (cart.length === 0) {
        alert('El carrito está vacío. Agrega productos para finalizar la compra.');
        return;
    }

    // Preparar items para la API
    // Nota: cart tiene {id, name, price, quantity}. La API espera {idItemInventario, cantidad}
    const apiItems = cart.map(item => ({
        idItemInventario: item.id,
        cantidad: item.quantity
    }));

    try {
        // Enviar pedido al backend para descontar stock
        const response = await fetch('/api/pedidos', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ items: apiItems })
        });

        const result = await response.json();

        if (!response.ok) {
            throw new Error(result.mensaje || 'Error al procesar el pedido.');
        }

        // Si el backend procesó bien, procedemos a WhatsApp
        const phoneNumber = '529991287457';
        let message = '¡Hola! Quisiera realizar el siguiente pedido:\n\n';
        let total = 0;

        cart.forEach(item => {
            const subtotal = item.price * item.quantity;
            message += `*${item.name}* (x${item.quantity}) - $${subtotal.toFixed(2)}\n`;
            total += subtotal;
        });

        message += `\n*Total a pagar: $${total.toFixed(2)}*`;
        message += `\n(Pedido ID: ${result.idPedido})`; // Incluimos el ID del pedido del backend

        const encodedMessage = encodeURIComponent(message);
        const whatsappURL = `https://wa.me/${phoneNumber}?text=${encodedMessage}`;

        // Limpiar carrito
        cart = [];
        saveCartToLocalStorage();
        updateCartCount();
        renderCart();
        modal.style.display = 'none';

        alert('Pedido registrado correctamente. Redirigiendo a WhatsApp...');
        window.open(whatsappURL, '_blank');

        // Recargar la página para actualizar stocks visuales
        location.reload();

    } catch (error) {
        console.error('Error:', error);
        alert('Error al procesar el pedido: ' + error.message);
    }
});

// Inicializa el contador del carrito y carga desde localStorage
loadCartFromLocalStorage();