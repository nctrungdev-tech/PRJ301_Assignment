<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Product</title>
<style>
    .custom-form {
        width: 400px;
        margin: 50px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    .custom-form h1 {
        color: #FFA500; /* Đã đổi sang cam */
        margin-bottom: 10px;
    }
    .custom-form hr {
        border: none;
        height: 2px;
        background: #FFA500; /* Đã đổi sang cam */
        margin-bottom: 20px;
    }
    .custom-form input {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 15px;
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
    .btn-create {
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
    <h1>Create Product</h1>
    <hr/>
    
    <form action="<c:url value='/manager/create_handler.do' />">
        <input type="text" name="name" placeholder="Name" value="${param.name}"/>
        <input type="text" name="description" placeholder="Description" value="${param.description}"/>
        <input type="text" name="price" placeholder="Price" value="${param.price}"/>
        <input type="text" name="stock" placeholder="Stock" value="${param.stock}"/>
        <input type="text" name="categoryID" placeholder="Category ID" value="${param.categoryID}"/>
        <input type="text" name="imageURL" placeholder="Image URL" value="${param.imageURL}"/>
        <input type="text" name="sold" placeholder="Sold" value="${param.sold}"/>
        <input type="text" name="discount" placeholder="Discount" value="${param.discount}"/>

        <div class="btn-group">
            <button type="submit" value="create" name="op" class="btn-create">Create</button>
            <button type="submit" value="cancel" name="op" class="btn-cancel">Cancel</button>
        </div>

        
    </form>
</div>