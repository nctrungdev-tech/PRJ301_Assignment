<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" scope="session"/>
<div class="header sticky-top">
    <header >
        <div id="top-header">
            <div class="container">
                <ul class="header-links pull-left">
                    <li><a><i class="fa fa-phone"></i> 0932 602 645</a></li>
                    <li><a><i class="fa fa-envelope-o"></i> hoadoan.2111990@gmail.com</a></li>
                    <li><a><i class="fa fa-map-marker"></i> 140 Dien Bien Phu Street, Ward 17, Binh Thanh District, Ho Chi Minh City</a></li>
                </ul>
                <ul class="header-links pull-right">
                    <c:if test="${user != null}">
                        <li><a href="#" data-toggle="modal" data-target="#walletModal"><i class="fa fa-wallet"></i> Wallet</a></li>
                    </c:if>
                    <c:if test="${user == null}">
                        <li><a href="#"><i class="fa fa-dollar"></i> USD</a></li>
                    </c:if>
                    <c:if test="${user != null}">                    
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true" style="color: white;" href="">
                                <i class="fa fa-user-o"></i>
                                <span>${user.fullName}</span>                        
                            </a>
                            <div class="cart-dropdown">                       
                                <h4><i class="fa fa-eye" aria-hidden="true"></i>View profile or logout <i class="fa fa-sign-out" aria-hidden="true"></i></h4>
                                <div class="cart-btns">                            
                                    <a href="<c:url value='/user/editProfile.do' />">View User</a>
                                    <a href="<c:url value='/user/logout.do' />"> Logout <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </li>
                    </c:if>

                    <c:if test="${user == null}">
                        <li><a href="<c:url value="/user/login.do" />"><i class="fa fa-user-o"></i> My Account</a></li>
                    </c:if>    

                </ul>
            </div>
        </div>
        <div id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <div class="header-logo">
                            <a href="<c:url value="/product/index.do" />" class="logo">
                                <img src="<c:url value='/img/logoX2.png' />" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">

                        <div class="header-search">
                            <form action="<c:url value="/product/search.do"/>" method="post">
                                <select class="input-select" name="category">
                                    <option value="0" ${categoryID == 0 ? "selected" : ""}>Categories</option>
                                    <option value="1" ${categoryID == 1 ? "selected" : ""}>Laptop</option>
                                    <option value="2" ${categoryID == 2 ? "selected" : ""}>Smartphones</option>
                                    <option value="3" ${categoryID == 3 ? "selected" : ""}>Cameras</option>
                                    <option value="4" ${categoryID == 4 ? "selected" : ""}>Accessories</option>
                                </select>
                                <input type="text" name="search" value="${search}" class="input" placeholder="Search here">
                                <button type="submit"  class="search-btn">Search</button>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-3 clearfix">
                        <div class="header-ctn">
                            <div class="dropdown">
                                <a href="" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                    <i id="wishlist-icon" class="bi ${cartWish.count > 0 ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                    <span>Your Wishlist</span>
                                    <div class="qty" id="wishlist-quantity" ${cartWish.count > 0 ? '' : 'style="display:none"'}>${cartWish.count}</div>
                                </a>
                                <div class="cart-dropdown">
                                    <div class="cart-list">
                                        <c:forEach items="${cartWish.items}" var="item">
                                            <div class="product-widget">
                                                <div class="product-img">
                                                    <img src="<c:url value='${item.product.imageURL}' />" alt="">
                                                </div>
                                                <div class="product-body">
                                                    <h3 class="product-name"><a href="<c:url value="/product/product.do?id=${item.product.productID}"/>">${item.product.name}</a></h3>
                                                    <h4 class="product-price">$${item.product.newPrice} <del class="product-old-price">$${item.product.price}</del></h4>
                                                </div>
                                                <a href="<c:url value="/cart/removeWish.do?id=${item.id}"/>"><button class="delete"><i class="fa fa-close"></i></button></a>
                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>
                            </div>
                            <div class="dropdown">
                                <a href="" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                    <i id="cart-icon" class="bi ${cart.totalQuantity > 0 ? 'bi-cart-fill' : 'bi-cart'}"></i>
                                    <span>Your Cart</span>
                                    <div class="qty" id="cart-quantity" ${cart.totalQuantity > 0 ? '' : 'style="display:none"'}>${cart.totalQuantity}</div>
                                </a>

                                <div class="cart-dropdown">
                                    <div class="cart-list">
                                        <c:forEach items="${cart.items}" var="item">
                                            <div class="product-widget">
                                                <div class="product-img">
                                                    <img src="<c:url value='${item.product.imageURL}' />" alt="">
                                                </div>
                                                <div class="product-body">
                                                    <h3 class="product-name"><a href="<c:url value="/product/product.do?id=${item.product.productID}"/>">${item.product.name}</a></h3>
                                                    <h4 class="product-price"><span class="qty">${item.quantity}</span>$${item.product.newPrice} <del class="product-old-price">$${item.product.price}</del> </h4>
                                                </div>

                                            </div>
                                        </c:forEach>
                                        
                                    </div>
                                    <div class="cart-summary">
                                        <small>${cart.count} Item(s) selected</small>
                                        <h5><fmt:formatNumber value="${cart.total}" type="currency"/> </h5>
                                    </div>
                                    <div class="cart-btns">
                                        <a href="<c:url value="/cart/index.do"/>">View Cart</a>
                                        <a href="<c:url value="/product/checkout.do" />">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div>
                            </div><div class="menu-toggle">
                                <a href="#">
                                    <i class="fa fa-bars"></i>
                                    <span>Menu</span>
                                </a>
                            </div>
                            </div>
                    </div>
                    </div>
                </div>
            </div>
        </header>
    </div>
<nav id="navigation">
    <div class="container">
        <div id="responsive-nav">
            <ul class="main-nav nav navbar-nav" >

                <li class="">
                    <a href="<c:url value='/index.do'/>">Home</a>
                </li>
                <li><a href="<c:url value='/product/store.do'/>">Store</a></li>

                <li class="">
                    <a href="<c:url value='/product/category.do?categoryId=1'/>">Laptops</a>
                </li>
                <li class="">
                    <a href="<c:url value='/product/category.do?categoryId=2'/>">Smartphones</a>
                </li>
                <li class="">
                    <a href="<c:url value='/product/category.do?categoryId=3'/>">Cameras</a>
                </li>
                <li class="">
                    <a href="<c:url value='/product/category.do?categoryId=4'/>">Accessories</a>
                </li>



            </ul>
            <c:if test="${ user.roled == 'admin'}">
                <ul class="main-nav nav navbar-nav" style="float:right">
                    <li><a href="<c:url value='/manager/index.do'/>">Product</a></li>
                    <li><a href="<c:url value='/order/index.do'/>">Order</a></li>
                </ul> 
            </c:if>




            </div>
        </div>
    </nav>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var qtyElement = document.getElementById("wishlist-quantity");
        var quantity = parseInt(qtyElement.textContent, 10);

        // Kiểm tra nếu quantity bằng 0 hoặc không phải là số
        if (isNaN(quantity) || quantity <= 0) {
            qtyElement.style.display = "none"; // Ẩn phần tử nếu không có số
        }
    });
    document.addEventListener("DOMContentLoaded", function () {
        var qtyElement = document.getElementById("cart-quantity");
        var quantity = parseInt(qtyElement.textContent, 10);

        // Kiểm tra nếu quantity bằng 0 hoặc không phải là số
        if (isNaN(quantity) || quantity <= 0) {
            qtyElement.style.display = "none"; // Ẩn phần tử nếu không có số
        }
    });

    // Top-up money function
    function topUpWallet() {
        var amount = document.getElementById('topUpAmount').value;
        if (amount && amount >= 1000) {
            var btn = document.querySelector('button[onclick="topUpWallet()"]');
            btn.disabled = true;
            btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Processing...';

            fetch('<c:url value="/user/wallet.do?action=topup&amount="/>' + amount, {
                method: 'POST'
            }).then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('✅ Top-up Successful!\n\nAmount: ' + new Intl.NumberFormat('vi-VN').format(amount) + ' USD\nYour wallet has been updated.');
                            location.reload();
                        } else {
                            alert('❌ Top-up Failed!\n\nPlease try again or contact support.');
                            btn.disabled = false;
                            btn.innerHTML = '<i class="fa fa-plus-circle"></i> Add Money';
                        }
                    }).catch(error => {
                alert('❌ Error Occurred!\n\nPlease check your connection and try again.');
                btn.disabled = false;
                btn.innerHTML = '<i class="fa fa-plus-circle"></i> Add Money';
            });
        } else {
            alert('⚠️ Invalid Amount!\n\nPlease enter a valid amount (minimum 1,000 USD).');
        }
    }
</script>

<div class="modal fade" id="walletModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #D10024; color: white;">
                <button type="button" class="close" data-dismiss="modal" style="color: white;">&times;</button>
                <h4 class="modal-title"><i class="fa fa-wallet"></i> My Wallet</h4>
            </div>
            <div class="modal-body text-center">
                <div style="margin-bottom: 20px;">
                    <img src="<c:url value='/img/maqr.png'/>" alt="QR Code" style="width: 200px; height: 200px; border: 2px solid #ddd; padding: 10px;">
                </div>

                <div style="margin-bottom: 30px;">
                    <h5 style="color: #666;">Current Balance</h5>
                    <h2 style="color: #D10024; font-weight: bold;">
                        <fmt:formatNumber value="${wallet.balance}" type="number" groupingUsed="true"/> USD
                    </h2>
                </div>

                <div style="border-top: 1px solid #ddd; padding-top: 20px;">
                    <h5 style="margin-bottom: 15px;">Top-up Money</h5>
                    <div class="input-group" style="max-width: 300px; margin: 0 auto 15px;">
                        <input type="number" id="topUpAmount" class="form-control" placeholder="Enter amount (USD)" min="1000" step="1000">
                        <span class="input-group-addon">USD</span>
                    </div>
                    <button onclick="topUpWallet()" class="primary-btn" style="padding: 10px 30px;">
                        <i class="fa fa-plus-circle"></i> Add Money
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>