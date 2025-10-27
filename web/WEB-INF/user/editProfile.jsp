<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>
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
        color: #744DA9;
        margin-bottom: 10px;
        text-align: center;
    }
    .custom-form hr {
        border: none;
        height: 2px;
        background: #744DA9;
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
        background-color: #744DA9;
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
        <span class="success">${message}</span>
    </div>
    <h1>User Profile</h1>
    <hr/>
    <form action="<c:url value='/user/editProfile_handler.do' />">
        <input type="hidden" name="userID" value="${user.userID}"/>
        
        <div class="input-group">
            <label>Full Name:</label>
            <input type="text" name="fullName" value="${param.fullName!=null?param.fullName:user.fullName}"/>
        </div>
        <div class="input-group">
            <label>Email:</label>
            <input type="email" name="email" value="${param.email!=null?param.email:user.email}"/>
        </div>
        <div class="input-group">
            <label>Password:</label>
            <input type="password" name="passwordHash" id="passwordHash" oninput="checkPasswords()"/>
        </div>
        <div class="input-group">
            <label>Re-enter Password:</label>
            <input type="password" name="rePassword" id="rePassword" oninput="checkPasswords()"/>
        </div>
        <div class="message" id="message"></div>
        <div class="input-group">
            <label>Phone:</label>
            <input type="text" name="phone" value="${param.phone!=null?param.phone:user.phone}"/>
        </div>
        <div class="input-group">
            <label>Address:</label>
            <input type="text" name="address" value="${param.address!=null?param.address:user.address}"/>
        </div>
        <div class="btn-group">
            <button type="submit" value="update" name="op" class="btn-update">Update</button>
            <button type="submit" value="cancel" name="op" class="btn-cancel">Cancel</button>
        </div>
    </form>
</div>

<script>
    function checkPasswords() {
        const password = document.getElementById('passwordHash').value;
        const rePassword = document.getElementById('rePassword').value;
        const messageDiv = document.getElementById('message');

        if (password && rePassword) {
            if (password !== rePassword) {
                messageDiv.innerHTML = '<span class="error">Passwords do not match!</span>';
            } else {
                messageDiv.innerHTML = '<span class="success">Passwords match!</span>';
            }
        } else {
            messageDiv.innerHTML = '';
        }
    }
</script>
