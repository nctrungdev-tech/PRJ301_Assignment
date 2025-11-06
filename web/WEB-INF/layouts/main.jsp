<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" scope="session"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Google font -->
        <title>TLStore - HTML Ecommerce Template</title>
        <link href="<c:url value='https://fonts.googleapis.com/css?family=Montserrat:400,500,700' />" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="<c:url value='/css/bootstrap.min.css' />"/>
        <link type="text/css" rel="stylesheet" href="<c:url value='/css/slick.css' />"/>
        <link type="text/css" rel="stylesheet" href="<c:url value='/css/slick-theme.css' />"/>
        <link type="text/css" rel="stylesheet" href="<c:url value='/css/nouislider.min.css' />"/>
    <!-- Font Awesome: CDN first (fallback to local copy if needed) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css' />">
        <link type="text/css" rel="stylesheet" href="<c:url value='/css/style.css' />"/>
        <link rel="stylesheet" href="<c:url value='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css' />">

    </head>
    <body>
        <%--header--%>
        <jsp:include page="/WEB-INF/menu/header.jsp" />

        <%--content--%>
        <jsp:include page="/WEB-INF/${controller}/${action}.jsp" />

        <%--footer--%>
        <jsp:include page="/WEB-INF/menu/footer.jsp" />

        <!-- jQuery Plugins -->


        <script src="<c:url value='/js/jquery.min.js' />"></script>
        <script src="<c:url value='/js/bootstrap.min.js' />"></script>
        <script src="<c:url value='/js/slick.min.js' />"></script>
        <script src="<c:url value='/js/nouislider.min.js' />"></script>
        <script src="<c:url value='/js/jquery.zoom.min.js' />"></script>
        <script src="<c:url value='/js/main.js' />"></script>
    </body>
</html>
<script>
    // Safely expose login state to JavaScript using JSTL to avoid JSP/JS parsing issues
    var __isLoggedIn = false;
    <c:if test="${user != null}">
        __isLoggedIn = true;
    </c:if>

    $(document).ready(function () {
        function isLoggedIn() {
            return __isLoggedIn;
        }

        $(".add-to-wishlist").click(function (e) {
            e.preventDefault(); // Ngăn trang bị load lại

            if (!isLoggedIn()) {
                alert("Bạn cần đăng nhập để sử dụng tính năng này!");
                return;
            }

            var productId = $(this).data("id"); // Lấy ID sản phẩm
            $.ajax({
                url: "<c:url value='/cart/addWish.do' />",
                type: "POST",
                data: {id: productId, quantity: 1}, // Gửi ID và quantity
                success: function (count) {
                    alert("Đã thêm vào danh sách yêu thích!");

                    // Cập nhật số lượng wishlist
                    if ($("#wishlist-quantity").length) {
                        $("#wishlist-quantity").text(count); // Cập nhật số lượng
                    } else {
                        // Nếu chưa có, thêm mới thay vì reload
                        $(".dropdown-toggle").append('<div class="qty" id="wishlist-quantity">' + count + '</div>');
                    }

                    // Hiện số lượng wishlist nếu count > 0
                    if (count > 0) {
                        $("#wishlist-quantity").show();
                        $("#wishlist-icon").removeClass("bi-heart").addClass("bi-heart-fill");
                    } else {
                        $("#wishlist-quantity").hide();
                        $("#wishlist-icon").removeClass("bi-heart-fill").addClass("bi-heart");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("Error details:", textStatus, errorThrown); // Ghi lại lỗi
                    alert("Có lỗi xảy ra: " + textStatus);
                }
            });
        });



        $(".add-to-cart-btn").click(function (e) {
            e.preventDefault(); // Ngăn trang bị load lại

            if (!isLoggedIn()) {
                alert("Bạn cần đăng nhập để sử dụng tính năng này!");
                return;
            }

            var productId = $(this).data("id"); // Lấy ID sản phẩm
            $.ajax({
                url: "<c:url value='/cart/add.do' />",
                type: "POST",
                data: {id: productId, quantity: 1},
                success: function (newQuantity) {
                    alert("Đã thêm vào giỏ hàng!");

                    // Cập nhật số lượng giỏ hàng
                    if ($("#cart-quantity").length) {
                        $("#cart-quantity").text(newQuantity);
                    } else {
                        $(".dropdown-toggle").append('<div class="qty" id="cart-quantity">' + newQuantity + '</div>');
                    }

                    // Hiện số lượng nếu giỏ hàng có sản phẩm
                    if (newQuantity > 0) {
                        $("#cart-quantity").show();
                        $("#cart-icon").removeClass("bi-cart").addClass("bi-cart-fill");
                    } else {
                        $("#cart-quantity").hide();
                        $("#cart-icon").removeClass("bi-cart-fill").addClass("bi-cart");
                    }
                },
                error: function () {
                    alert("Có lỗi xảy ra!");
                }
            });
        });

    });
</script>