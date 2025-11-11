<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3 class="breadcrumb-header">Checkout</h3>
            </div>
        </div>
    </div>
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <div class="container">
        <form action="<c:url value='/order/order.do'/>" method="post">
            <div class="row">
                <!-- Shipping Info -->
                <div class="col-md-7">
                    <div class="shiping-details">
                        <div class="section-title">
                            <h3 class="title">Shipping Address</h3>
                        </div>

                        <!-- Customer Info -->
                        <div style="background-color: #f5f5f5; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                            <h5 style="margin-bottom: 15px; color: #D10024;"><i class="fa fa-user"></i> Customer Information</h5>
                            <div><strong>Name:</strong> <span>${user.fullName}</span></div>
                            <div><strong>Phone:</strong> <span>${user.phone}</span></div>
                            <div><strong>Address:</strong> <span>${user.address}</span></div>
                        </div>

                        <!-- Different Shipping -->
                        <div class="input-checkbox">
                            <input type="checkbox" id="shipping-address" onclick="toggleShippingFields()">
                            <label for="shipping-address">
                                <span></span>
                                Ship to a different address?
                            </label>
                            <div class="caption" id="shipping-fields" style="display: none;">
                                <div class="form-group">
                                    <h6>Full name</h6>
                                    <input class="input" type="text" name="fullName" placeholder="Full name">
                                </div>
                                <div class="form-group">
                                    <h6>Address</h6>
                                    <input class="input" type="text" name="address" placeholder="Address">
                                </div>
                                <div class="form-group">
                                    <h6>Phone</h6>
                                    <input class="input" type="text" name="phone" placeholder="Telephone">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Notes -->
                    <div class="order-notes">
<textarea class="input" name="notes" placeholder="Order Notes"></textarea>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="col-md-5 order-details">
                    <div class="section-title text-center">
                        <h3 class="title">Your Order</h3>
                    </div>
                    <div class="order-summary">
                        <div class="order-col">
                            <div><strong>PRODUCT</strong></div>
                            <div><strong>COST</strong></div>
                        </div>

                        <div class="order-products">
                            <c:forEach items="${cart.items}" var="item">
                                <div class="order-col">
                                    <div>${item.quantity}x  ${item.product.name}</div>
                                    <input type="hidden" name="quantity" value="${item.quantity}" />
                                    <div><fmt:formatNumber value="${item.cost}" type="number" groupingUsed="true"/> USD</div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="order-col">
                            <div>Shipping</div>
                            <div><strong>FREE</strong></div>
                        </div>
                        <div class="order-col">
                            <div><strong>TOTAL</strong></div>
                            <div><strong class="order-total"><fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/> USD</strong></div>
                            <input type="hidden" name="total" value="${cart.total}" />
                        </div>
                    </div>

                    <!-- Payment Methods -->
                    <div class="payment-method">
                        <div class="input-radio">
                            <input type="radio" name="payment" value="QR Payment" id="payment-qr" checked>
                            <label for="payment-qr">
                                <span></span>
                                QR Code Payment (Wallet Balance: <fmt:formatNumber value="${wallet.balance}" type="number" groupingUsed="true"/> USD)
                            </label>
                        </div>

                        <div class="input-radio">
                            <input type="radio" name="payment" value="Cash on Delivery" id="payment-cod">
                            <label for="payment-cod">
                                <span></span>
                                Cash on Delivery (COD)
                            </label>
                        </div>
                    </div>

                    <div class="input-checkbox">
                        <input type="checkbox" id="terms">
                        <label for="terms">
                            <span></span>
I've read and accept the <a href="#">terms & conditions</a>
                        </label>
                    </div>
                    <button type="button" onclick="processOrder()" class="primary-btn order-submit" style="width: 100%;">Place Order</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- /SECTION -->

<!-- QR Payment Modal -->
<div class="modal fade" id="qrPaymentModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #D10024; color: white;">
                <button type="button" class="close" data-dismiss="modal" style="color: white;">&times;</button>
                <h4 class="modal-title"><i class="fa fa-qrcode"></i> QR Code Payment</h4>
            </div>
            <div class="modal-body text-center">
                <div id="insufficientBalance" style="display: none;">
                    <div style="color: #D10024; margin-bottom: 20px;">
                        <i class="fa fa-exclamation-triangle" style="font-size: 50px;"></i>
                        <h4>Insufficient Balance!</h4>
                        <p>Your current balance: <strong><fmt:formatNumber value="${wallet.balance}" type="number" groupingUsed="true"/> USD</strong></p>
                        <p>Order total: <strong id="orderTotalDisplay"></strong> USD</p>
                        <p>You need: <strong id="needMoreAmount" style="color: #D10024;"></strong> USD more</p>
                    </div>
                </div>

                <div id="sufficientBalance" style="display: none;">
                    <img src="<c:url value='/img/maqr.png'/>" alt="QR Code" style="width: 250px; height: 250px; border: 2px solid #ddd; padding: 10px; margin-bottom: 20px;">
                    <h4>Scan QR Code to Pay</h4>
                    <p>Amount: <strong style="color: #D10024; font-size: 24px;" id="paymentAmount"></strong> USD</p>
                    <button onclick="confirmPayment()" class="primary-btn" style="padding: 10px 40px; margin-top: 20px;">
                        <i class="fa fa-check-circle"></i> Confirm Payment
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function toggleShippingFields() {
    var checkbox = document.getElementById('shipping-address');
    var shippingFields = document.getElementById('shipping-fields');
    shippingFields.style.display = checkbox.checked ? 'block' : 'none';
}

function formatUSD(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount);
}

function processOrder() {
    var terms = document.getElementById('terms');
    if (!terms.checked) {
        alert('⚠️ Please accept the terms & conditions!');
        return;
    }

    var payment = document.querySelector('input[name="payment"]:checked');
    if (!payment) {
        alert('⚠️ Please select a payment method!');
        return;
}

    var paymentValue = payment.value;

    if (paymentValue === 'QR Payment') {
        var walletBalance = parseFloat('${wallet != null ? wallet.balance : 0}');
        var orderTotal = parseFloat('${cart != null ? cart.total : 0}');
        if (walletBalance < orderTotal) {
            var needMore = orderTotal - walletBalance;
            document.getElementById('orderTotalDisplay').textContent = formatUSD(orderTotal);
            document.getElementById('needMoreAmount').textContent = formatUSD(needMore);
            document.getElementById('insufficientBalance').style.display = 'block';
            document.getElementById('sufficientBalance').style.display = 'none';
        } else {
            document.getElementById('paymentAmount').textContent = formatUSD(orderTotal);
            document.getElementById('insufficientBalance').style.display = 'none';
            document.getElementById('sufficientBalance').style.display = 'block';
        }
        $('#qrPaymentModal').modal('show');
    } else if (paymentValue === 'Cash on Delivery') {
        alert('✅ Order placed successfully!\n\nYour order will be paid upon delivery.\nThank you for shopping with us!');
        document.querySelector('form').submit();
    }
}

function confirmPayment() {
    $('#qrPaymentModal').modal('hide');
    var form = document.querySelector('form[action*="order.do"]');
    var hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = 'qrConfirmed';
    hiddenInput.value = 'true';
    form.appendChild(hiddenInput);
    form.submit();
}

window.onload = function() {
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('paymentSuccess') === 'true') {
        alert('✅ Payment Successful!\n\nYour order has been placed successfully.\nThank you for shopping with us!');
    }
};
</script>