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
    
    .avatar-section {
        text-align: center;
        margin-bottom: 20px;
    }
    
    .avatar-preview {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 15px;
        border: 3px solid #744DA9;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
    
    .avatar-upload {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px;
    }
    
    #avatarInput {
        display: none;
    }
    
    .btn-upload-avatar {
        background-color: #744DA9;
        color: white;
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }
    
    .btn-upload-avatar:hover {
        background-color: #5a3a7f;
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
    .btn-update:hover {
        background-color: #5a3a7f;
    }
    .btn-cancel {
        background-color: #333;
        color: white;
    }
    .btn-cancel:hover {
        background-color: #555;
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
    
    .avatar-info {
        font-size: 12px;
        color: #666;
        margin-top: 5px;
    }
</style>

<div class="custom-form">
    <div class="message">
        <span class="error">${message3}</span>
        <span class="success">${message}</span>
    </div>
    <h1>User Profile</h1>
    <hr/>
    
    <!-- Avatar Upload Section -->
    <div class="avatar-section">
        <img id="avatarPreview" class="avatar-preview" 
             src="${user.avatarBase64 != null ? user.avatarBase64 : 'data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22%3E%3Ccircle cx=%2250%22 cy=%2250%22 r=%2250%22 fill=%22%23744DA9%22/%3E%3Ctext x=%2250%22 y=%2250%22 text-anchor=%22middle%22 dy=%22.3em%22 fill=%22white%22 font-size=%2240%22%3E?%3C/text%3E%3C/svg%3E'}" 
             alt="User Avatar">
        <div class="avatar-upload">
            <button type="button" class="btn-upload-avatar" onclick="document.getElementById('avatarInput').click()">
                Choose Avatar
            </button>
            <input type="file" id="avatarInput" accept="image/*" onchange="previewAvatar(event)"/>
            <div class="avatar-info">JPG, PNG (Max 5MB)</div>
        </div>
        <input type="hidden" id="hiddenAvatarData" name="avatarData" value=""/>
    </div>
    
    <form action="<c:url value='/user/editProfile_handler.do' />" enctype="multipart/form-data">
        <input type="hidden" name="userID" value="${user.userID}"/>
        <input type="hidden" id="hiddenAvatarData" name="avatar" value=""/>

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
    
    function previewAvatar(event) {
        const file = event.target.files[0];
        
        if (file) {
            // Kiểm tra kích thước file (5MB)
            const maxSize = 5 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB');
                return;
            }
            
            // Kiểm tra loại file
            if (!file.type.startsWith('image/')) {
                alert('Vui lòng chọn một file hình ảnh');
                return;
            }
            
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
                document.getElementById('hiddenAvatarData').value = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
</script>