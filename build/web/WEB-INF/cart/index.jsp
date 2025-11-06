<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    .cart-container {
        width: 90%;
        margin: 30px auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }
    .cart-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
    .cart-table th, .cart-table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        text-align: center;
        vertical-align: middle;
        height: 50px;
    }
    .cart-table th {
        background-color: #000;
        color: white;
    }
    .cart-table tr:hover {
        background-color: #f5f5f5;
    }
    .cart-table img {
        max-width: 100px;
        max-height: 80px;
        object-fit: contain;
        border-radius: 5px;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
    }
    .total-label {
        text-align: center;
        font-weight: bold;
        background-color: black;
        color: white;
        padding: 10px;
        border-radius: 5px;
    }
    .total-row td {
        text-align: center;
        font-weight: bold;
        height: 60px; /* Đảm bảo hàng Total có chiều cao cố định */
    }
    .btn-action {
        display: inline-flex;
        width: 36px;
        height: 36px;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        text-decoration: none;
        font-size: 14px;
        cursor: pointer;
    }
    .btn-update {
        background-color: #744DA9;
        color: white;
    }
    .btn-update:hover {
        background-color: #744DA9;
    }
    .btn-delete {
        background-color: #000;
        color: white;
    }
    .btn-delete:hover {
        background-color: #333;
    }
    .btn-cart {
        flex: 1; /* Để nút giãn đều */
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%; /* Đảm bảo chiều cao bằng ô Total */
        padding: 12px 20px;
        font-size: 14px;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-weight: bold;
    }
    .btn-empty {
        background-color: black;
    }
    .btn-empty:hover {
        background-color: #333;
    }
    .btn-checkout {
        background-color: #744DA9;
    }
    .btn-checkout:hover {
        background-color: #744DA9;
    }
    .cart-table input[type="number"] {
        width: 60px;
        height: 36px;
        text-align: center;
    }
    .cart-table td:last-child {
        display: flex;
        justify-content: center;
        gap: 5px;
    }
    .total-row td:last-child {
        display: flex;
        align-items: stretch; /* Để các nút kéo dài toàn bộ chiều cao */
        justify-content: center;
        gap: 10px;
    }
</style>

<div class="cart-container">
    <table class="cart-table">
        <tr>
            <th>No.</th>
            <th>Image</th>
            <th>Id</th>
            <th>Name</th>   
            <th style="text-align: right;">Price</th>
            <th style="text-align: right;">Quantity</th>
            <th style="text-align: right;">Cost</th>
            <th>Operations</th>
        </tr>
        <c:forEach items="${cart.items}" var="item" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td><img src="${pageContext.request.contextPath}/${product.imageURL}" 
     alt="${product.name}" 
     style="width: 100%; height: 300px; object-fit: contain;">
</td>
                <td>${item.id}</td>
                <td>${item.product.name}</td>
                <td style="text-align: right;">
                    <fmt:formatNumber value="${item.product.newPrice}" type="currency"/>
                </td>
                <td style="text-align: right;">
                    <input type="number" min="0" name="quantity" value="${item.quantity}" />
                </td>
                <td style="text-align: right;">
                    <fmt:formatNumber value="${item.cost}" type="currency"/>
                </td>
                <td>
                    <a href="#" class="btn-action btn-update update" data-id="${item.id}">
                        <i class="fas fa-sync-alt"></i>
                    </a>
                    <a href="<c:url value='/cart/remove.do?id=${item.id}'/>" class="btn-action btn-delete">
                        <i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        <tr class="total-row">
            <td colspan="6" class="total-label">Total</td>
            <td style="text-align: right;">
                <fmt:formatNumber value="${cart.total}" type="currency"/>
            </td>
            <td>
                <a href="<c:url value='/cart/empty.do'/>" class="btn-cart btn-empty">Empty Cart</a>
                <a href="<c:url value='/product/checkout.do'/>" class="btn-cart btn-checkout">
                    Checkout <i class="fa fa-arrow-circle-right"></i>
                </a>
            </td>
        </tr>
    </table>
</div>

<script>
    $(".update").click(function(){
        var id = $(this).data("id");
        var quantity = $(this).closest("tr").find("input[name='quantity']").val();
        var url = `<c:url value="/cart/update.do?id=\${id}&quantity=\${quantity}" />`;
        window.location = url;
    });
</script>
