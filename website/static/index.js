function addToCart(productId) {
    quant = document.getElementById("quantity").value;
    fetch("/add_to_cart", {
        method: "POST",
        body: JSON.stringify({ product_id: productId, quantity: quant })
    }).then((_res) => {
        // Reload window -> refresh data
        window.location.href = "/";
    });
}

function removeFromCart(productId) {
    fetch("/remove_from_cart", {
        method: "POST",
        body: JSON.stringify({ product_id: productId })
    }).then((_res) => {
        // Reload window -> refresh data
        window.location.href = "/";
    });
}

function checkout() {
    fetch("/checkout_cart", {
        method: "POST",
        body: JSON.stringify({})
    }).then((_res) => {
        // Reload window -> refresh data
        window.location.href = "/";
    });
}

function getOrderDetails(orderId) {
    fetch("/get_order_details", {
        method: "POST",
        body: JSON.stringify({ order_id: orderId })
    }).then((_res) => {
        // Reload window -> refresh data
        window.location.href = _res.url;
    });
}


function deleteOrder(orderId) {
    fetch("/delete_order", {
        method: "POST",
        body: JSON.stringify({ order_id: orderId })
    }).then((_res) => {
        // Reload window -> refresh data
        window.location.href = "/";
    });
}

function deleteAccount() {
    fetch("/delete_account", {
        method: "POST",
        body: JSON.stringify({})
    }).then((_res) => {
        // Reload window -> refresh data
        window.location.href = "/";
    });
}