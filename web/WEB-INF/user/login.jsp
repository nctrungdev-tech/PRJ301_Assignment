<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div class="login-page">

    <div class="login-container">

        <h2>Login with</h2>
        <!-- Login Form -->
        <form action="<c:url value='/user/login_handler.do' />" method="post">
            <input type="text" name="email" value="${param.email}" placeholder="Enter the email" required/>
            <input type="password" name="passwordHash" value="${param.passwordHash}" placeholder="Enter the password" required/>

            <!-- Forgot Password Link -->
            <div class="forgot-password">
                <a href="#">Forget password?</a>
            </div>
            <i style="color:red;">${message}</i><br/><br/>
            <!-- Submit Button -->
            <button type="submit" name="op" value="login">Login</button>
        </form>

        <!-- Registration Link -->
        <div class="register">
            Do you have a account?
            <a href="<c:url value='/user/create.do' />">Register now</a>
        </div>
    </div>
</div>

