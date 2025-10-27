

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" scope="session"/>
<div class="header sticky-top">
    <header >
        <!-- TOP HEADER -->
        <div id="top-header">
            <div class="container">
                <ul class="header-links pull-left">
                    <li><a><i class="fa fa-phone"></i> 0325 029 045</a></li>
                    <li><a><i class="fa fa-envelope-o"></i> donglhlse185081@fpt.edu.vn</a></li>
                    <li><a><i class="fa fa-map-marker"></i> The Origami S9.03, Vinhomes Grand Park, Phuoc Thien St, Long Binh precinct, Thu Duc City</a></li>
                </ul>
                <ul class="header-links pull-right">
                    <li><a href="#"><i class="fa fa-dollar"></i> USD</a></li>
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
        <!-- /TOP HEADER -->

        <!-- MAIN HEADER -->
        <div id="header">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- LOGO -->
                    <div class="col-md-3">
                        <div class="header-logo">
                            <a href="<c:url value="/product/index.do" />" class="logo">
                                <img src="<c:url value='/img/logoX2.png' />" alt="">

                            </a>
                        </div>
                    </div>
                    <!-- /LOGO -->

                    <!-- SEARCH BAR -->
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
                    <!-- /SEARCH BAR -->

                    <!-- ACCOUNT -->
                    <div class="col-md-3 clearfix">
                        <div class="header-ctn">
                            <!-- Wishlist -->
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
                            <!-- /Wishlist -->

                            <!-- Cart -->
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

                                        <!--                                    
                                        -->                                </div>
                                    <div class="cart-summary">
                                        <small>${cart.count} Item(s) selected</small>
                                        <h5><fmt:formatNumber value="${cart.total}" type="currency"/> </h5>
                                    </div>
                                    <div class="cart-btns">
                                        <a href="<c:url value="/cart/index.do"/>">View Cart</a>
                                        <a href="<c:url value="/product/checkout.do" />">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div>
                            </div><!--
                            <!-- /Cart -->

                            <!-- Menu Toogle -->
                            <div class="menu-toggle">
                                <a href="#">
                                    <i class="fa fa-bars"></i>
                                    <span>Menu</span>
                                </a>
                            </div>
                            <!-- /Menu Toogle -->
                        </div>
                    </div>
                    <!-- /ACCOUNT -->
                </div>
                <!-- row -->
            </div>
            <!-- container -->
        </div>
        <!-- /MAIN HEADER -->
    </header>
    <!-- /HEADER -->
</div>
<!-- NAVIGATION -->
<nav id="navigation">
    <!-- container -->
    <div class="container">
        <!-- responsive-nav -->
        <div id="responsive-nav">
            <!-- NAV -->
            <ul class="main-nav nav navbar-nav" >

                <li class="">
                    <a href="<c:url value='/index.jsp'/>">Home</a>
                </li>
                <li><a href="<c:url value='/product/store.do'/>">Store</a></li>
                <li><a href="<c:url value='/product/hotDeals.do'/>">Hot Deals</a></li>
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




            <!-- /NAV -->
        </div>
        <!-- /responsive-nav -->
    </div>
    <!-- /container -->
</nav>

<!-- /NAVIGATION -->
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
</script>