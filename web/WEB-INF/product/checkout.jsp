<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <h3 class="breadcrumb-header">Checkout</h3>

            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <form action="<c:url value="/order/order.do" />" method="post">
            <div class="row">

                <div class="col-md-7">
                    <!-- Billing Details -->

                    <!-- /Billing Details -->

                    <!-- Shiping Details -->
                    <div class="shiping-details">
                        <div class="section-title">
                            <h3 class="title">Shiping address</h3>
                        </div>
                        <div class="input-checkbox">
    <input type="checkbox" id="shipping-address" name="shipping-address" onclick="toggleShippingFields()">
    <label for="shipping-address">
        <span></span>
        Ship to a different address?
    </label>
    <div class="caption" id="shipping-fields" style="display: none;">
        <div class="form-group">
            <h6>Full name</h6>
            <input class="input" type="text" name="fullName" value="${param.fullName}" placeholder="Full name">
        </div>
        <div class="form-group">
            <h6>Address</h6>
            <input class="input" type="text" name="address" value="${param.address}" placeholder="Address">
        </div>
        <div class="form-group">
            <h6>Phone</h6>
            <input class="input" type="text" name="phone" value="${param.phone}" placeholder="Telephone">
        </div>
    </div>
</div>
                    </div>
                    <!-- /Shiping Details -->

                    <!-- Order notes -->
                    <div class="order-notes">
                        <textarea class="input" name="notes" placeholder="Order Notes"></textarea>
                    </div>
                    <!-- /Order notes -->
                </div>

                <!-- Order Details -->


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

                                    <div>$${item.cost}</div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="order-col">
                            <div>Shiping</div>
                            <div><strong>FREE</strong></div>
                        </div>
                        <div class="order-col">
                            <div><strong>TOTAL</strong></div>
                            <div><strong class="order-total">$${cart.total}</strong></div>
                            <input type="hidden" name="total" value="${cart.total}" />
                        </div>
                    </div>
                    <div class="payment-method">
                        <div class="input-radio">
                            <input type="radio" name="payment" value="Bank Transfer" id="payment-1">
                            <label for="payment-1">
                                <span></span>
                                Bank Transfer
                            </label>

                        </div>
                        <div class="input-radio">
                            <input type="radio" name="payment" value="Cash on Delivery" id="payment-2">
                            <label for="payment-2">
                                <span></span>
                                Cash on Delivery
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
                    <button type="submit" name="action" value="order" class="primary-btn order-submit" style="width: 100%;">Place order</button>
                </div>

                <!-- /Order Details -->
            </div>
        </form>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->
<script>
function toggleShippingFields() {
    var checkbox = document.getElementById('shipping-address');
    var shippingFields = document.getElementById('shipping-fields');
    shippingFields.style.display = checkbox.checked ? 'block' : 'none';
}
</script>

