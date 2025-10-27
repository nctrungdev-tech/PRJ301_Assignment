<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Ở đầu trang index.jsp --%>
<% if ("true".equals(request.getParameter("success"))) { %>
    <script>
        alert("Đặt hàng thành công!");
    </script>
<% } %>
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
                                                <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
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
<!-- /SECTION -->

<!-- HOT DEAL SECTION -->
<div id="hot-deal" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <div class="hot-deal">
                    <ul class="hot-deal-countdown">
                        <li>
                            <div>
                                <h3>02</h3>
                                <span>Days</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <h3>10</h3>
                                <span>Hours</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <h3>34</h3>
                                <span>Mins</span>
                            </div>
                        </li>
                        <li>
                            <div>
                                <h3>60</h3>
                                <span>Secs</span>
                            </div>
                        </li>
                    </ul>
                    <h2 class="text-uppercase">hot deal this week</h2>
                    <p>New Collection Up to 20% OFF</p>
                    <a class="primary-btn cta-btn" href="<c:url value="/product/store.do"/>">Shop now</a>
                </div>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /HOT DEAL SECTION -->

<!-- SECTION -->

<!-- /SECTION -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-4 col-xs-6">
                <div class="section-title">
                    <h4 class="title">Top selling</h4>
                    <div class="section-nav">
                        <div id="slick-nav-3" class="products-slick-nav"></div>
                    </div>
                </div>

                <div class="products-widget-slick" data-nav="#slick-nav-3">
                    <div>
                        <!-- product widget -->
                        <c:forEach var="product" items="${list1}">
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="<c:url value='${product.imageURL}' />" alt="">

                                </div>
                                <div class="product-body">

                                    <h3 class="product-name" ><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- /product widget -->

                    </div>

                    <div>
                        <!-- product widget -->
                        <c:forEach var="product" items="${list2}">
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="<c:url value='${product.imageURL}' />" alt="">

                                </div>
                                <div class="product-body">

                                    <h3 class="product-name" ><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- product widget -->
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-xs-6">
                <div class="section-title">
                    <h4 class="title">Top selling</h4>
                    <div class="section-nav">
                        <div id="slick-nav-4" class="products-slick-nav"></div>
                    </div>
                </div>

                <div class="products-widget-slick" data-nav="#slick-nav-4">
                    <div>
                        <!-- product widget -->
                        <c:forEach var="product" items="${list3}">
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="<c:url value='${product.imageURL}' />" alt="">

                                </div>
                                <div class="product-body">

                                    <h3 class="product-name" ><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- product widget -->
                    </div>

                    <div>
                        <!-- product widget -->
                        <c:forEach var="product" items="${list4}">
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="<c:url value='${product.imageURL}' />" alt="">

                                </div>
                                <div class="product-body">

                                    <h3 class="product-name" ><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- product widget -->
                    </div>
                </div>
            </div>

            <div class="clearfix visible-sm visible-xs"></div>

            <div class="col-md-4 col-xs-6">
                <div class="section-title">
                    <h4 class="title">Top selling</h4>
                    <div class="section-nav">
                        <div id="slick-nav-5" class="products-slick-nav"></div>
                    </div>
                </div>

                <div class="products-widget-slick" data-nav="#slick-nav-5">
                    <div>
                        <!-- product widget -->
                        <c:forEach var="product" items="${list5}">
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="<c:url value='${product.imageURL}' />" alt="">

                                </div>
                                <div class="product-body">

                                    <h3 class="product-name" ><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- product widget -->
                    </div>

                    <div>
                        <!-- product widget -->
                        <c:forEach var="product" items="${list6}">
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="<c:url value='${product.imageURL}' />" alt="">

                                </div>
                                <div class="product-body">

                                    <h3 class="product-name" ><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- product widget -->
                    </div>
                </div>
            </div>

        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->


<script>
    // Kiểm tra xem đã có thời gian kết thúc trong localStorage chưa
    let countdownDate = localStorage.getItem('countdownDate');

    // Nếu chưa có, đặt thời gian bắt đầu (7 ngày)
    if (!countdownDate) {
        countdownDate = new Date().getTime() + (7 * 24 * 60 * 60 * 1000); // 7 ngày tính bằng milliseconds
        localStorage.setItem('countdownDate', countdownDate);
    } else {
        countdownDate = parseInt(countdownDate, 10); // Chuyển đổi sang số
    }

    // Cập nhật mỗi giây
    const x = setInterval(function () {
        // Lấy thời gian hiện tại
        const now = new Date().getTime();

        // Tính khoảng thời gian còn lại
        const distance = countdownDate - now;

        // Tính toán thời gian còn lại
        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Cập nhật các phần tử trong HTML
        document.querySelector(".hot-deal-countdown li:nth-child(1) h3").innerText = days;
        document.querySelector(".hot-deal-countdown li:nth-child(2) h3").innerText = hours;
        document.querySelector(".hot-deal-countdown li:nth-child(3) h3").innerText = minutes;
        document.querySelector(".hot-deal-countdown li:nth-child(4) h3").innerText = seconds;

        // Nếu đếm ngược kết thúc
        if (distance < 0) {
            clearInterval(x);
            document.querySelector(".hot-deal-countdown").innerHTML = "Deal Expired";

            // Đặt lại thời gian cho 7 ngày tiếp theo
            countdownDate = new Date().getTime() + (7 * 24 * 60 * 60 * 1000);
            localStorage.setItem('countdownDate', countdownDate);

            // Bắt đầu lại đếm ngược
            setInterval(arguments.callee, 1000);
        }
    }, 1000);
</script>