<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .create-page{
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0;
        background-color: #f9f9f9;
    }

    .login-container {
        text-align: center;
        width: 100%;
        max-width: 400px;
        padding: 20px;
    }
    .form-container h2 {
        text-align: center;
        font-weight: bold;
        margin-bottom: 30px;
    }

    .form-outline {
        margin-bottom: 20px;
    }

    .form-outline input {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-sizing: border-box;
    }

    .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #744DA9;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
    }

    .btn-submit:hover {
        background-color: #744DA9;
    }

    .text-link {
        text-align: center;
        margin-top: 20px;
    }

    .text-link a {
        color: #744DA9;
        text-decoration: none;
    }

    #agreement-message {
        font-size: 14px;
        color: red;
        margin-top: 10px;
    }
    .center-container {
        display: flex;
        justify-content: center; /* Căn giữa ngang */
        align-items: center;     /* Căn giữa dọc */
        min-height: 100vh;       /* Chiều cao toàn màn hình */
    }

    /* Đảm bảo input đồng nhất */
    .form-control {
        width: 100%; /* Đảm bảo input full width */
        box-sizing: border-box; /* Giữ kích thước không bị lệch */
    }

    /* Căn checkbox và nút đăng ký */
    .form-check {
        display: flex;
        align-items: center; /* Canh giữa checkbox và nội dung */

        /* Sửa lỗi lệch chiều ngang */
        .container {
            max-width: 600px; /* Điều chỉnh lại chiều rộng form */
            margin: auto; /* Căn giữa */
        }
    </style>
    <div class="create-page">
        <div class="form-container">
            <h2>Register new account</h2>
            <form action="<c:url value='/user/create_handler.do' />" method="post">

                <div class="form-outline">
                    <input type="text" name="fullName" value="${param.fullName}" id="fullName" placeholder="Enter the fullname" required />
                </div>

                <div class="form-outline">
                    <input type="email" name="email" value="${param.email}" id="email" placeholder="Enter the mail" required />
                </div>

                <div class="form-outline">
                    <input type="text" name="phone" value="${param.phone}" id="phone" placeholder="Enter the phone number" required />
                </div>

                <div class="form-outline">
                    <input type="text" name="address" value="${param.address}" id="address" placeholder="Enter the address" required />
                </div>

                <div class="form-outline">
                    <input type="password" name="passwordHash" value="${param.passwordHash}" id="passwordHash" placeholder="Enter the password" oninput="checkPasswords()" required />
                </div>

                <div class="form-outline">
                    <input type="password" name="rePassword" value="${param.rePassword}" id="rePassword" placeholder="Confirm the password" oninput="checkPasswords()" required />
                </div>

                <div id="message" style="margin-top: 10px;">
                    <i style="color:green;">${message}</i>
                    <i style="color:red;">${message2}</i>
                    <i style="color:red;">${message3}</i>
                </div>

                <div class="form-check">
                    <input type="checkbox" id="checkBox" onchange="updateAgreementMessage()" required>
                    <label for="checkBox">I agree with <a href="#">service policy</a></label>
                </div>

                <div id="agreement-message">You must to agree with service policy</div>

                <button type="submit" value="create" name="op" class="btn-submit">Register</button>

                <div class="text-link">
                    Do you have a account? <a href="<c:url value="/user/login.do"/>" >Login now</a>
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
                    messageDiv.innerHTML = '<span style="color: red;">Password not match!</span>';
                } else {
                    messageDiv.innerHTML = '<span style="color: green;">Password match!</span>';
                }
            } else {
                messageDiv.innerHTML = '';
            }
        }

        function updateAgreementMessage() {
            const checkbox = document.getElementById('checkBox');
            const agreementMessage = document.getElementById('agreement-message');

            if (checkbox.checked) {
                agreementMessage.innerHTML = '<span style="color: green;">You ticked agree Terms of service.</span>';
            } else {
                agreementMessage.innerHTML = '<span style="color: red;">You need to tick agree Terms of service.</span>';
            }
        }
    </script>