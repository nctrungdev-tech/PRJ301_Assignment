<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    .order-container {
        width: 90%;
        margin: 30px auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }
    .order-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
    .order-table th, .order-table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        text-align: center; /* Căn giữa toàn bộ nội dung */
    }
    .order-table th {
        background-color: #000;
        color: white;
    }
    .order-table tr:hover {
        background-color: #f5f5f5;
    }
    .btn-container {
        text-align: right;
        margin-bottom: 15px;
    }
    .btn-revenue {
        background-color: #FFA500; /* Đã đổi sang cam */
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        cursor: pointer;
    }
    .btn-revenue:hover {
        background-color: #E69500; /* Đổi sang cam đậm */
    }
    .btn-action {
        display: inline-block;
        width: 36px;
        height: 36px;
        margin: 2px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 14px;
        text-align: center;
        line-height: 36px;
    }
    .btn-update {
        background-color: #FFA500; /* Đã đổi sang cam */
        color: white;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px;
        width: 40px;
        height: 40px;
    }
    .btn-update:hover {
        background-color: #E69500; /* Đổi sang cam đậm */
    }
    .btn-delete {
        background-color: #000;
        color: white;
        border-radius: 4px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 5px 10px;
    }
    .btn-delete:hover {
        background-color: #333;
    }
</style>

<div class="order-container">
    <div class="btn-container">
        <a class="btn-revenue" href="<c:url value='/order/revenue.do'/>">Revenue</a>
    </div>
    <table class="order-table">
        <tr>
            <th>No.</th>
            <th>Order Id</th>
            <th>User Id</th>
            <th>Shipping Id</th>
            <th>Total Price</th>
            <th>Status</th>
            <th>Date Created</th>      
            <th>Operations</th>
        </tr>
        <c:forEach items="${list}" var="order" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td>${order.orderID}</td>
                <td>${order.userID}</td>
                <td>${order.shippingID}</td>    
                <td>
                    <fmt:formatNumber value="${order.totalPrice}" type="currency"/>
                </td>
                <td>
                    <select class="order-status">
                        <option value="Pending" ${order.orderStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Shipped" ${order.orderStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                        <option value="Paid" ${order.orderStatus == 'Paid' ? 'selected' : ''}>Paid</option>
                    </select>
                </td>
                <td>${order.createdAt}</td>
                <td>
                    <a class="btn-action btn-update" href="#" data-id="${order.orderID}">
                        <i class="fas fa-sync-alt"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    $(document).ready(function(){
        $(".btn-update").click(function(event){
            event.preventDefault(); // Ngăn chặn link chuyển trang ngay lập tức
            
            var id = $(this).data("id"); // Lấy orderID
            var orderStatus = $(this).closest("tr").find(".order-status").val(); // Lấy giá trị trạng thái
            var url = `<c:url value="/order/update.do?id=\${id}&orderStatus=\${orderStatus}" />`;
            window.location = url; // Chuyển hướng
        });
    });
</script>