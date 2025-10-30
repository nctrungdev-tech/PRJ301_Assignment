<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Ở đầu trang index.jsp --%>
<% if ("true".equals(request.getParameter("success"))) { %>
<script>
    alert("Đặt hàng thành công!");
</script>
<% }%>
<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="<c:url value='/img/shop01.png' />" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Laptops<br>Collection</h3>
                        <a href="<c:url value='/product/category.do?categoryId=1'/>" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="<c:url value='/img/shop03.png' />" alt="">

                    </div>
                    <div class="shop-body">
                        <h3>Accessories<br>Collection</h3>
                        <a href="<c:url value='/product/category.do?categoryId=4'/>" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="<c:url value='/img/shop02.png' />" alt="">

                    </div>
                    <div class="shop-body">
                        <h3>Cameras<br>Collection</h3>
                        <a href="<c:url value='/product/category.do?categoryId=3'/>" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <!-- section title -->
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title">New Products</h3>

                </div>
            </div>
            <!-- /section title -->

            <!-- Products tab & slick -->
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab1" class="tab-pane active">
                            <div class="products-slick" data-nav="#slick-nav-1">
                                <!-- product -->
                                <!--                                        
                                                                               
                                                                                    
                                <c:forEach var="product" items="${listN}">

                                    -->                                            <div class="product">
                                        <div class="product-img">
                                            <img src="<c:url value='${product.imageURL}' />" style="height: 263px; width: 263px" alt="">

                                            <div class="product-label">
                                                <span class="sale">${product.discount}%</span>
                                                <span class="new">NEW</span>
                                            </div>
                                        </div>
                                        <div class="product-body">

                                            <h3 class="product-name"><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                            <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                            <div class="product-rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="product-btns">
                                                <button class="add-to-wishlist" data-id="${product.productID}">
                                                    <i class="fa fa-heart-o"></i>
                                                    <span class="tooltipp">Add to wishlist</span>
                                                </button>
                                                <a href="<c:url value='/product/product.do?id=${product.productID}'/>" class="quick-view">
                                                    <i class="fa fa-eye"></i>
                                                    <span class="tooltipp">quick view</span>
                                                </a>

                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn" data-id="${product.productID}">
                                                <i class="fa fa-shopping-cart"></i> add to cart
                                            </button>
                                        </div>
                                    </div><!--
                                </c:forEach>
                            

                                <!-- /product -->
                            </div>
                            <div id="slick-nav-1" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- Products tab & slick -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>