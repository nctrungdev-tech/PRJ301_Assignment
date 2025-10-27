<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" scope="session"/>
<section>
            <div class="text-center container py-5">
                <h4 class="mt-4 mb-5" style="margin-top: 30px;"><strong>Search: ${search}</strong></h4>
                <div id="store" class="col-md-12">
                    <div class="row">

                        <c:forEach var="product" items="${list}">
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="<c:url value='${product.imageURL}' />" style="height: 220px; width: 330px" alt="">
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
                                            <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                            <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
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
                    </div>
                </div>




            </div>
        </section>