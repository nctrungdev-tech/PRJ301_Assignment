<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div style="display: flex; gap: 10px;">
            <a href="<c:url value="/product/price.do?op=asc"/>"><button type="submit"  class="primary-btn " style="padding: 5px 5px;font-size: 10px ">Price:Low-Hight</button></a>
            <a href="<c:url value="/product/price.do?op=desc"/>"><button type="submit"  class="primary-btn " style="padding: 5px 5px;font-size: 10px ">Price:Hight-Low</button></a>
        </div>
        <form action="<c:url value="/product/store_handler.do" />" method="post">
            <div class="row">
                <!-- ASIDE -->
                <div id="aside" class="col-md-3">
                    <!-- aside Widget -->
                    <div class="aside">


                        <h3 class="aside-title">Categories</h3>
                        <div class="checkbox-filter">
                            <div class="input-checkbox">
                                <input type="checkbox" name="category" value="1" id="category-1"
                                       <c:forEach var="selectedCat" items="${selectedCategories}">
                                           <c:if test="${selectedCat == 1}">checked</c:if>
                                       </c:forEach> >
                                <label for="category-1">
                                    <span></span>
                                    Laptops

                                </label>
                            </div>

                            <div class="input-checkbox">
                                <input type="checkbox" name="category" value="2" id="category-2"
                                       <c:forEach var="selectedCat" items="${selectedCategories}">
                                           <c:if test="${selectedCat == 2}">checked</c:if>
                                       </c:forEach> >
                                <label for="category-2">
                                    <span></span>
                                    Smartphones

                                </label>
                            </div>

                            <div class="input-checkbox">
                                <input type="checkbox" name="category" value="3" id="category-3"
                                       <c:forEach var="selectedCat" items="${selectedCategories}">
                                           <c:if test="${selectedCat == 3}">checked</c:if>
                                       </c:forEach> >
                                <label for="category-3">
                                    <span></span>
                                    Cameras

                                </label>
                            </div>

                            <div class="input-checkbox">
                                <input type="checkbox" name="category" value="4" id="category-4"
                                       <c:forEach var="selectedCat" items="${selectedCategories}">
                                           <c:if test="${selectedCat == 4}">checked</c:if>
                                       </c:forEach> >
                                <label for="category-4">
                                    <span></span>
                                    Accessories

                                </label>
                            </div>



                        </div>
                    </div>
                    <!-- /aside Widget -->

                    <!-- aside Widget -->
                    <div class="aside">
                        <h3 class="aside-title">Price</h3>
                        <div class="price-filter">

                            <div class="input-number ">
                                <input  name="min" value="${min != null ? min : 0}" type="number" min="0" max="2999">
                                <span class="qty-up">+</span>
                                <span class="qty-down">-</span>
                            </div>
                            <span>-</span>
                            <div class="input-number ">
                                <input  name="max" value="${max != null ? max : 3000}"  type="number" max="3000">
                                <span class="qty-up">+</span>
                                <span class="qty-down">-</span>
                            </div>
                        </div>
                    </div>
                    <br/>
                    <button type="submit" name="action" value="store" class="primary-btn order-submit" style="width: 100%;">Screen</button>
                    <!-- /aside Widget -->

                    <!-- aside Widget -->

                    <!-- /aside Widget -->

                    <!-- aside Widget -->
                    <div class="aside">
                        <h3 class="aside-title">Top selling</h3>
                        <c:forEach var="product" items="${list1}">
                            <div class="product-widget">
                                <div class="product-img">
<<<<<<< HEAD
                                    <img src="<c:url value='${product.imageURL}' />" alt="">
=======
<img src="<c:url value='/${product.imageURL}'/>" alt="${product.name}">
>>>>>>> recovery
                                </div>
                                <div class="product-body">

                                    <h3 class="product-name"><a href="<c:url value="/product/product.do?id=${product.productID}"/>">${product.name}</a></h3>
                                    <h4 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h4>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                    <!-- /aside Widget -->
                </div>
                <!-- /ASIDE -->

                <!-- STORE -->
                <div id="store" class="col-md-9">
                    <div class="row">
                        <c:forEach var="product" items="${allProducts}">
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="<c:url value='${product.imageURL}' />" style="height: 202.5px; width: 232.5px" alt="">
                                        <div class="product-label">
                                            <span class="sale">${product.discount}%</span>
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
                                </div>
                            </div>
                        </c:forEach>   
                        <!-- /product -->


                        <!-- /product -->
                    </div>

                    <!-- /store products -->

                    <!-- store bottom filter -->

                    <!-- /store bottom filter -->
                </div>
                <!-- /STORE -->
            </div>
        </form>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<script>
    document.querySelectorAll(".input-number").forEach(container => {
        const input = container.querySelector("input");
        const min = parseInt(input.min) || Number.NEGATIVE_INFINITY;
        const max = parseInt(input.max) || Number.POSITIVE_INFINITY;

        container.querySelector(".qty-up").addEventListener("click", () => {
            let currentValue = Math.round(parseInt(input.value) / 100) * 100;
            let newValue = currentValue + 99;

            if (newValue > max) {
                input.value = max; // Chặn cứng tại max, không tăng nữa
            } else {
                input.value = newValue;
            }
        });

        container.querySelector(".qty-down").addEventListener("click", () => {
            let currentValue = Math.round(parseInt(input.value) / 100) * 100;
            let newValue = currentValue - 99;

            if (newValue < min) {
                input.value = min; // Chặn cứng tại min, không giảm nữa
            } else {
                input.value = newValue;
            }
        });
    });
</script>

