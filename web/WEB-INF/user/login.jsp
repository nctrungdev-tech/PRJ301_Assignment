<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="login-page">
    <div class="login-container">
        <h2>Login with</h2>

        <!-- Form đăng nhập -->
        <form action="<c:url value='/user/login_handler.do' />" method="post">
            <input type="hidden" name="op" value="login">
            <input type="email" name="email" value="${param.email}" placeholder="Enter the email" required />
            <input type="password" name="passwordHash" value="${param.passwordHash}" placeholder="Enter the password" required />

            <!-- Forgot Password -->
            <div class="forgot-password">
                <a href="#">Forget password?</a>
            </div>

            <i style="color:red;">${message}</i><br/><br/>

            <!-- Nút Login -->
            <button type="submit">Login</button>
        </form>

        <!-- Form login guest (tách riêng, không bị bắt nhập email/password) -->
        <form action="<c:url value='/user/login_handler.do' />" method="post">
            <input type="hidden" name="op" value="guest">
            <button type="submit">Login as Guest</button>
        </form>

        <!-- Link đăng ký -->
        <div class="register">
            Do you have a account?
            <a href="<c:url value='/user/create.do' />">Register now</a>
        </div>
    </div>
</div>
