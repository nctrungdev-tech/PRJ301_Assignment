<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    .product-container {
        width: 90%;
        margin: 30px auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }
    .product-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
    .product-table th, .product-table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
    }
    .product-table th {
        background-color: #000;
        color: white;
    }
    .product-table tr:hover {
        background-color: #f5f5f5;
    }
    .product-table img {
        border-radius: 5px;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
    }
    .btn-container {
        text-align: right;
        margin-bottom: 15px;
    }
    .btn-create {
        background-color: #744DA9;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        cursor: pointer;
    }
    .btn-create:hover {
        background-color: #744DA9;
    }
    .btn-action {
        display: inline-block;
        width: 36px;
        height: 36px;
        margin: 2px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 14px;
        text-align: center;
        line-height: 36px;
    }
    .btn-update {
        background-color: #744DA9;
        color: white;
        border-radius: 4px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    .btn-update:hover {
        background-color: #744DA9;
    }
    .btn-delete {
        background-color: #000;
        color: white;
        border-radius: 4px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    .btn-delete:hover {
        background-color: #333;
    }
    .btn-action i {
        font-size: 18px;
    }
</style>

<div class="product-container">
    <div class="btn-container">
        <a class="btn-create" href="<c:url value='/manager/create.do'/>">Create New Product</a>
    </div>
    <table class="product-table">
        <tr>
            <th>No.</th>
            <th>Image</th>
            <th>Id</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Category Id</th>
            <th>Sold</th>
            <th>Discount</th>
            <th>Operations</th>
        </tr>
        <c:forEach items="${list}" var="product" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td><img src="<c:url value='${product.imageURL}'/>" height="100px" width="150px"/></td>
                <td>${product.productID}</td>
                <td>${product.name}</td>
                <td>${product.description}</td>
                <td><fmt:formatNumber value="${product.price}" type="currency"/></td>
                <td>${product.stock}</td>
                <td>${product.categoryID}</td>
                <td>${product.sold}</td>
                <td>${product.discount}</td>
                <td>
                    <a class="btn-action btn-update" href="<c:url value='/manager/update.do?productID=${product.productID}'/>">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a class="btn-action btn-delete" href="#" onclick="confirmDelete(${product.productID})">
                        <i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    function confirmDelete(productID) {
        let confirmAction = confirm("Bạn có chắc chắn muốn xóa sản phẩm này không?");
        if (confirmAction) {
            window.location.href = "<c:url value='/manager/delete.do'/>?productID=" + productID;
        }
    }
</script>
