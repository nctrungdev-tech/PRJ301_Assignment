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

    .avatar-section {
        text-align: center;
        margin-bottom: 20px;
        padding: 15px;
        background-color: #f5f5f5;
        border-radius: 8px;
    }

    .avatar-preview {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 15px;
        border: 3px solid #744DA9;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }

    #avatarInput {
        display: none;
    }

    .btn-upload-avatar {
        width: 100%;
        padding: 10px;
        background-color: #f0f0f0;
        color: #333;
        border: 2px dashed #744DA9;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        margin-bottom: 8px;
    }

    .btn-upload-avatar:hover {
        background-color: #e8e8e8;
    }

    .avatar-info {
        font-size: 12px;
        color: #999;
        margin-top: 5px;
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
    }
</style>

<div class="create-page">
    <div class="form-container">
        <h2>Register new account</h2>
        <form action="<c:url value='/user/create_handler.do' />" method="post" enctype="multipart/form-data">

            <!-- Avatar Upload Section -->
            <div class="avatar-section">
                <img id="avatarPreview" class="avatar-preview" 
                     src="data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22%3E%3Ccircle cx=%2250%22 cy=%2250%22 r=%2250%22 fill=%22%23744DA9%22/%3E%3Ctext x=%2250%22 y=%2250%22 text-anchor=%22middle%22 dy=%22.3em%22 fill=%22white%22 font-size=%2240%22%3E?%3C/text%3E%3C/svg%3E" 
                     alt="User Avatar">
                <button type="button" class="btn-upload-avatar" onclick="document.getElementById('avatarInput').click()">
                    Choose Avatar
                </button>
                <input type="file" id="avatarInput" name="avatarData" accept="image/*" onchange="previewAvatar(event)"/>
                <div class="avatar-info">JPG, PNG (Max 5MB) - Optional</div>
            </div>

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

    function previewAvatar(event) {
        const file = event.target.files[0];

        if (file) {
            // Kiểm tra kích thước file (5MB)
            const maxSize = 5 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB');
                event.target.value = '';
                return;
            }

            // Kiểm tra loại file
            if (!file.type.startsWith('image/')) {
                alert('Vui lòng chọn một file hình ảnh');
                event.target.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
</script>