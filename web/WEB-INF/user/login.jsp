<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #fff5eb, #ffe0c2);
    }

    .login-page {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .login-container {
        background-color: #fff;
        padding: 40px 35px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(255, 122, 0, 0.25);
        width: 100%;
        max-width: 380px;
        text-align: center;
    }

    .login-container h2 {
        color: #ff7a00;
        font-weight: bold;
        margin-bottom: 25px;
    }

    form {
        margin-bottom: 20px;
    }

    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 15px;
        transition: 0.3s;
    }

    input[type="email"]:focus,
    input[type="password"]:focus {
        border-color: #ff7a00;
        box-shadow: 0 0 6px rgba(255, 122, 0, 0.4);
        outline: none;
    }

    button {
        width: 100%;
        padding: 12px;
        background-color: #ff7a00;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background-color: #e86d00;
        box-shadow: 0 3px 8px rgba(255, 122, 0, 0.4);
    }

    .forgot-password {
        text-align: right;
        margin-bottom: 10px;
    }

    .forgot-password a {
        font-size: 13px;
        color: #ff7a00;
        text-decoration: none;
    }

    .forgot-password a:hover {
        text-decoration: underline;
    }

    .register {
        font-size: 14px;
        margin-top: 15px;
    }

    .register a {
        color: #ff7a00;
        font-weight: bold;
        text-decoration: none;
    }

    .register a:hover {
        text-decoration: underline;
    }

    i {
        font-size: 14px;
    }
</style>

<div class="login-page">
    <div class="login-container">
        <h2>Login</h2>

        <!-- Form đăng nhập -->
        <form action="<c:url value='/user/login_handler.do' />" method="post">
            <input type="hidden" name="op" value="login">
            <input type="email" name="email" value="${param.email}" placeholder="Enter your email" required />
            <input type="password" name="passwordHash" value="${param.passwordHash}" placeholder="Enter your password" required />

            <div class="forgot-password">
                <a href="#">Forgot password?</a>
            </div>

            <i style="color:red;">${message}</i><br/><br/>

            <button type="submit">Login</button>
        </form>

        <!-- Login Guest -->
        <form action="<c:url value='/user/login_handler.do' />" method="post">
            <input type="hidden" name="op" value="guest">
            <button type="submit" style="background-color: #fff; color: #ff7a00; border: 1px solid #ff7a00;">
                Login as Guest
            </button>
        </form>

        <!-- Link đăng ký -->
        <div class="register">
            Don't have an account?
            <a href="<c:url value='/user/create.do' />">Register now</a>
        </div>
    </div>
</div>
