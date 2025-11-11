

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


<!-- FOOTER -->
<footer id="footer">
    <!-- top footer -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">About Us</h3>
                        <p>TL Store provides genuine devices, supporting efficient retail operations.</p>
                        <ul class="footer-links">
                            <li><a><i class="fa fa-map-marker"></i>140 Dien Bien Phu Street, Ward 17, Binh Thanh District, Ho Chi Minh City</a></li>
                            <li><a><i class="fa fa-phone"></i>0932 602 645</a></li>
                            <li><a><i class="fa fa-envelope-o"></i>hoadoan.2111990@gmail.com</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Categories</h3>
                        <ul class="footer-links">
                            <li><a href="<c:url value='/product/hotDeals.do'/>">Hot deals</a></li>
                            <li><a href="<c:url value='/product/category.do?categoryId=1'/>">Laptops</a></li>
                            <li><a href="<c:url value='/product/category.do?categoryId=2'/>">Smartphones</a></li>
                            <li><a href="<c:url value='/product/category.do?categoryId=3'/>">Cameras</a></li>
                            <li><a href="<c:url value='/product/category.do?categoryId=4'/>">Accessories</a></li>
                        </ul>
                    </div>
                </div>

                <div class="clearfix visible-xs"></div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Information</h3>
                        <ul class="footer-links">
                            <li><a>About Us</a></li>
                            <li><a>Contact Us</a></li>
                            <li><a>Privacy Policy</a></li>
                            <li><a>Orders and Returns</a></li>
                            <li><a>Terms & Conditions</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Service</h3>
                        <ul class="footer-links">
                            <c:if test="${user == null}">
                                <li><a href="<c:url value="/user/login.do" />">My Account</a></li>
                            </c:if>
                            <c:if test="${user != null}">
                                <li><a>${user.fullName}</a></li>
                            </c:if>
                            <li><a href="<c:url value="/cart/index.do"/>">View Cart</a></li>
                            <li><a href="<c:url value="/product/checkout.do" />">Checkout</a></li>
                            <li><a>Track My Order</a></li>
                            <li><a>Help</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /top footer -->

    <!-- bottom footer -->
    <div id="bottom-footer" class="section">
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-12 text-center">
                    <ul class="footer-payments">
                        <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                        <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                    </ul>
                    <span class="copyright">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </span>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /bottom footer -->
</footer>
<!-- /FOOTER -->
<!-- jQuery Plugins -->
