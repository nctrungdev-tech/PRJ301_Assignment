<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="col-md-12">
            <div class="col-md-6">
                <img src="<c:url value='${product.imageURL}' />" style="height: 281px; width: 400px" alt="">

            </div>
            <div class="col-md-6">
                <div class="product-details">
                    <h2 class="product-name">${product.name}</h2>
                    <div>
                        <div class="product-rating">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star-o"></i>
                        </div>
                        <a class="review-link" href="#">10 Review(s) | Add your review</a>
                    </div>
                    <div>
                        <h3 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h3>
                        <span class="product-available">Sold: ${product.sold}</span>
                        <span class="product-available">Stock: ${product.stock}</span>
                    </div>
                    <p>${product.description}</p>



                    <div class="add-to-cart">
                        <button class="add-to-cart-btn" data-id="${product.productID}">
                            <i class="fa fa-shopping-cart"></i> add to cart
                        </button>
                    </div>

                    <ul class="product-btns">

                        <li>
                            <a href="#" class="add-to-wishlist" data-id="${product.productID}">
                                <i class="fa fa-heart-o"></i>
                                <span class="tooltipp">Add to wishlist</span>
                            </a>
                        </li>
                    </ul>



                </div>
            </div>
        </div>
        <!-- /Product details -->

        <!-- Product tab -->
        <div class="col-md-12">
            <div id="product-tab">
                <!-- product tab nav -->
                <ul class="tab-nav">
                    <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                    <li><a data-toggle="tab" href="#tab2">Details</a></li>
                    <li><a data-toggle="tab" href="#tab3">Reviews (3)</a></li>
                </ul>
                <!-- /product tab nav -->

                <!-- product tab content -->
                <div class="tab-content">
                    <!-- tab1  -->
                    <div id="tab1" class="tab-pane fade in active">
                        <div class="row">
                            <div class="col-md-12">
                                <p>ElectroShop specializes in providing genuine devices and high-quality packaging materials, helping retailers operate efficiently, optimize performance, and enhance the shopping experience. With a commitment to quality and convenience, we offer comprehensive solutions that support sustainable business growth and maximize customer satisfaction.</p>
                            </div>
                        </div>
                    </div>
                    <!-- /tab1  -->

                    <!-- tab2  -->
                    <div id="tab2" class="tab-pane fade in">
                        <div class="row">
                            <div class="col-md-12">
                                <p>ElectroShop is dedicated to supplying authentic devices and premium packaging materials, empowering retailers to streamline operations, boost efficiency, and elevate the shopping experience. Committed to excellence and convenience, we deliver all-in-one solutions that foster sustainable business growth and enhance customer satisfaction to the fullest.</p>
                            </div>
                        </div>
                    </div>
                    <!-- /tab2  -->

                    <!-- tab3  -->
                    <div id="tab3" class="tab-pane fade in">
                        <div class="row">
                            <!-- Rating -->
                            <div class="col-md-3">
                                <div id="rating">
                                    <div class="rating-avg">
                                        <span>4.5</span>
                                        <div class="rating-stars">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                    </div>
                                    <ul class="rating">
                                        <li>
                                            <div class="rating-stars">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="rating-progress">
                                                <div style="width: 80%;"></div>
                                            </div>
                                            <span class="sum">3</span>
                                        </li>
                                        <li>
                                            <div class="rating-stars">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                            <div class="rating-progress">
                                                <div style="width: 60%;"></div>
                                            </div>
                                            <span class="sum">2</span>
                                        </li>
                                        <li>
                                            <div class="rating-stars">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                            <div class="rating-progress">
                                                <div></div>
                                            </div>
                                            <span class="sum">0</span>
                                        </li>
                                        <li>
                                            <div class="rating-stars">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                                <i class="fa fa-star-o"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                            <div class="rating-progress">
                                                <div></div>
                                            </div>
                                            <span class="sum">0</span>
                                        </li>
                                        <li>
                                            <div class="rating-stars">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                                <i class="fa fa-star-o"></i>
                                                <i class="fa fa-star-o"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                            <div class="rating-progress">
                                                <div></div>
                                            </div>
                                            <span class="sum">0</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /Rating -->

                            <!-- Reviews -->
                            <div class="col-md-6">
                                <div id="reviews">
                                    <ul class="reviews">
                                        <li>
                                            <div class="review-heading">
                                                <h5 class="name">Alice</h5>
                                                <p class="date">15 JAN 2025, 2:30 PM</p>
                                                <div class="review-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-half-alt"></i>
                                                </div>
                                            </div>
                                            <div class="review-body">
                                                <p>Great product quality and carefully packaged. I'm very satisfied with the service!</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="review-heading">
                                                <h5 class="name">David</h5>
                                                <p class="date">08 JAN 2025, 10:15 AM</p>
                                                <div class="review-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-o empty"></i>
                                                </div>
                                            </div>
                                            <div class="review-body">
                                                <p>Reasonable price and fast delivery. I will continue to support in the future.</p>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="review-heading">
                                                <h5 class="name">Emma</h5>
                                                <p class="date">22 JAN 2025, 5:45 PM</p>
                                                <div class="review-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-half-alt"></i>
                                                    <i class="fa fa-star-o empty"></i>
                                                </div>
                                            </div>
                                            <div class="review-body">
                                                <p>The product is fine, but the delivery took longer than expected. Hope it will be faster next time!</p>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="reviews-pagination">
                                        <li class="active">1</li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /Reviews -->


                            <!-- Review Form -->
                            <div class="col-md-3">
                                <div id="review-form">
                                    <form class="review-form">
                                        <input class="input" type="text" placeholder="Your Name">
                                        <input class="input" type="email" placeholder="Your Email">
                                        <textarea class="input" placeholder="Your Review"></textarea>
                                        <div class="input-rating">
                                            <span>Your Rating: </span>
                                            <div class="stars">
                                                <input id="star5" name="rating" value="5" type="radio"><label for="star5"></label>
                                                <input id="star4" name="rating" value="4" type="radio"><label for="star4"></label>
                                                <input id="star3" name="rating" value="3" type="radio"><label for="star3"></label>
                                                <input id="star2" name="rating" value="2" type="radio"><label for="star2"></label>
                                                <input id="star1" name="rating" value="1" type="radio"><label for="star1"></label>
                                            </div>
                                        </div>
                                        <button class="primary-btn">Submit</button>
                                    </form>
                                </div>
                            </div>
                            <!-- /Review Form -->
                        </div>
                    </div>
                    <!-- /tab3  -->
                </div>
                <!-- /product tab content  -->
            </div>
        </div>
        <!-- /product tab -->

        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- Section -->
