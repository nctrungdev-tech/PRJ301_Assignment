<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .create-page {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background: linear-gradient(135deg, #fff5eb, #ffe0c2);
        font-family: Arial, sans-serif;
    }

    .form-container {
        background-color: #fff;
        padding: 40px 35px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(255, 122, 0, 0.25);
        width: 100%;
        max-width: 400px;
        text-align: center;
    }

    .form-container h2 {
        color: #ff7a00;
        font-weight: bold;
        margin-bottom: 25px;
    }

    .form-outline {
        margin-bottom: 18px;
        text-align: left;
    }

    .form-outline input {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-sizing: border-box;
        transition: 0.3s;
        font-size: 15px;
    }

    .form-outline input:focus {
        border-color: #ff7a00;
        outline: none;
        box-shadow: 0 0 5px rgba(255, 122, 0, 0.4);
    }

    .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #ff7a00;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
        margin-top: 10px;
    }

    .btn-submit:hover {
        background-color: #e86d00;
        box-shadow: 0 3px 8px rgba(255, 122, 0, 0.4);
    }

    .form-check {
        display: flex;
        align-items: center;
        margin-top: 10px;
        font-size: 14px;
    }

    .form-check a {
        color: #ff7a00;
        text-decoration: none;
    }

    .form-check a:hover {
        text-decoration: underline;
    }

    .text-link {
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
    }

    .text-link a {
        color: #ff7a00;
        text-decoration: none;
        font-weight: bold;
    }

    .text-link a:hover {
        text-decoration: underline;
    }

    #agreement-message {
        font-size: 13px;
        margin-top: 8px;
    }

    #message {
        margin-top: 10px;
        font-size: 14px;
    }
</style>

<div class="create-page">
    <div class="form-container">
        <h2>Register New Account</h2>

        <form action="<c:url value='/user/create_handler.do' />" method="post">
            <div class="form-outline">
                <input type="text" name="fullName" value="${param.fullName}" id="fullName" placeholder="Enter your fullname" required />
            </div>

            <div class="form-outline">
                <input type="email" name="email" value="${param.email}" id="email" placeholder="Enter your email" required />
            </div>

            <div class="form-outline">
                <input type="text" name="phone" value="${param.phone}" id="phone" placeholder="Enter your phone number" required />
            </div>

            <div class="form-outline">
                <input type="text" name="address" value="${param.address}" id="address" placeholder="Enter your address" required />
            </div>

            <div class="form-outline">
                <input type="password" name="passwordHash" value="${param.passwordHash}" id="passwordHash" placeholder="Enter your password" oninput="checkPasswords()" required />
            </div>

            <div class="form-outline">
                <input type="password" name="rePassword" value="${param.rePassword}" id="rePassword" placeholder="Confirm your password" oninput="checkPasswords()" required />
            </div>

            <input type="hidden" name="role" value="customer" />

            <div id="message">
                <i style="color:green;">${message}</i>
                <i style="color:red;">${message2}</i>
                <i style="color:red;">${message3}</i>
            </div>

            <div class="form-check">
                <input type="checkbox" id="checkBox" name="agreePolicy" value="true" onchange="updateAgreementMessage()" required>
                <label for="checkBox">&nbsp;I agree with <a href="#">service policy</a></label>
            </div>

            <div id="agreement-message" style="color:red;">You must agree with the service policy</div>

            <button type="submit" value="create" name="op" class="btn-submit">Register</button>

            <div class="text-link">
                Already have an account? <a href="<c:url value='/user/login.do' />">Login now</a>
            </div>
        </form>
    </div>
</div>

<script>
    function checkPasswords() {
        const password = document.getElementById('passwordHash').value;
        const rePassword = document.getElementById('rePassword').value;
        const messageDiv = document.getElementById('message');

        if (password && rePassword) {
            if (password !== rePassword) {
                messageDiv.innerHTML = '<span style="color: red;">Passwords do not match!</span>';
            } else {
                messageDiv.innerHTML = '<span style="color: green;">Passwords match!</span>';
            }
        } else {
            messageDiv.innerHTML = '';
        }
    }

    function updateAgreementMessage() {
        const checkbox = document.getElementById('checkBox');
        const agreementMessage = document.getElementById('agreement-message');

        if (checkbox.checked) {
            agreementMessage.innerHTML = '<span style="color: green;">You have agreed to the Terms of Service.</span>';
        } else {
            agreementMessage.innerHTML = '<span style="color: red;">You must agree with the service policy.</span>';
        }
    }
</script>
