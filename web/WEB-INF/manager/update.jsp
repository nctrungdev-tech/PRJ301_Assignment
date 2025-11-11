<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Product</title>
<style>
    .custom-form {
        width: 400px;
        margin: 50px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    .custom-form h1 {
        color: #FFA500; /* Đã đổi sang cam */
        margin-bottom: 10px;
        text-align: center;
    }
    .custom-form hr {
        border: none;
        height: 2px;
        background: #FFA500; /* Đã đổi sang cam */
        margin-bottom: 20px;
    }
    .custom-form .input-group {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 15px;
    }
    .custom-form label {
        font-weight: bold;
        flex: 1;
    }
    .custom-form input {
        flex: 2;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }
    .custom-form .btn-group {
        display: flex;
        justify-content: space-between;
    }
    .custom-form button {
        width: 48%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }
    .btn-update {
        background-color: #FFA500; /* Đã đổi sang cam */
        color: white;
    }
    .btn-cancel {
        background-color: #333;
        color: white;
    }
    .message {
        margin-top: 10px;
        font-size: 14px;
        text-align: center;
    }
    .error {
        color: red;
    }
    .success {
        color: green;
    }
</style>


<div class="custom-form">
    <div class="message">
        <span class="error">${message3}</span>
        <span class="error">${message2}</span>
        <span class="success">${message}</span>
    </div>
    <h1>Update Product</h1>
    <hr/>
    <form action="<c:url value='/manager/update_handler.do' />">
        <div class="input-group">
            <label>Product ID:</label>
            <input type="text" disabled value="${param.productID!=null?param.productID:product.productID}"/>
            <input type="hidden" name="productID" value="${product.productID}"/>
        </div>
        <div class="input-group">
            <label>Name:</label>
            <input type="text" name="name" value="${param.name!=null?param.name:product.name}"/>
        </div>
        <div class="input-group">
            <label>Description:</label>
            <input type="text" name="description" value="${param.description!=null?param.description:product.description}"/>
        </div>
        <div class="input-group">
            <label>Price:</label>
            <input type="text" name="price" value="${param.price!=null?param.price:product.price}"/>
        </div>
        <div class="input-group">
            <label>Stock:</label>
            <input type="text" name="stock" value="${param.stock!=null?param.stock:product.stock}"/>
        </div>
        <div class="input-group">
            <label>Category ID:</label>
            <input type="text" name="categoryID" value="${param.categoryID!=null?param.categoryID:product.categoryID}"/>
        </div>
        <div class="input-group">
            <label>Image URL:</label>
            <input type="text" name="imageURL" value="${param.imageURL!=null?param.imageURL:product.imageURL}"/>
        </div>
        <div class="input-group">
            <label>Sold:</label>
            <input type="text" name="sold" value="${param.sold!=null?param.sold:product.sold}"/>
        </div>
        <div class="input-group">
            <label>Discount:</label>
            <input type="text" name="discount" value="${param.discount!=null?param.discount:product.discount}"/>
        </div>
        <div class="btn-group">
            <button type="submit" value="update" name="op" class="btn-update">Update</button>
            <button type="submit" value="cancel" name="op" class="btn-cancel">Cancel</button>
        </div>

    </form>
</div>