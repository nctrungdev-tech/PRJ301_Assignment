<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
<img src="<c:url value='/${product.imageURL}'/>" alt="${product.name}">
        </div>
        <div class="col-md-6">
            <h2>${product.name}</h2>
            <p>${product.description}</p>
            <p><b>Price:</b> 
                <fmt:formatNumber value="${product.price}" type="currency"/>
            </p>
            <p><b>Discount:</b> ${product.discount}%</p>
            <p><b>Stock:</b> ${product.stock}</p>

            <form action="<c:url value='/cart/add.do'/>" method="post">
                <input type="hidden" name="pid" value="${product.productID}">
                <button class="btn btn-dark">
                    <i class="fa fa-shopping-cart"></i> Add to Cart
                </button>
            </form>
        </div>
    </div>

    <hr>
    <h4 class="mt-4">Related Products</h4>
    <div class="row">
        <c:forEach var="r" items="${related}">
            <div class="col-md-3 mb-4">
                <div class="card h-100">
                    <img src="<c:url value='${r.imageURL}'/>" class="card-img-top" style="height:200px;object-fit:cover;">
                    <div class="card-body text-center">
                        <h6>${r.name}</h6>
                        <p><fmt:formatNumber value="${r.price}" type="currency"/></p>
                        <a href="<c:url value='/product/product.do?id=${r.productID}'/>" class="btn btn-outline-dark btn-sm">View</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
