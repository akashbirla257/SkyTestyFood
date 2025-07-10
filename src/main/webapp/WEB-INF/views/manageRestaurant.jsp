<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Restaurant - Sky Tasty Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #f8f9fa 0%, #ffebcd 100%); min-height: 100vh; }
        .container { padding: 20px; }
        .card { border-radius: 10px; margin-bottom: 20px; }
        .card-img-top { height: 150px; object-fit: cover; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Manage Restaurant: ${restaurant.name}</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
            <c:remove var="message" scope="session" />
        </c:if>
        <div class="mb-4">
            <a href="${pageContext.request.contextPath}/admin/updateRestaurant/${restaurant.restaurantId}" class="btn btn-warning">Update Restaurant</a>
            <a href="${pageContext.request.contextPath}/admin/deleteRestaurant/${restaurant.restaurantId}" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete Restaurant</a>
            <a href="${pageContext.request.contextPath}/admin/addFoodItem" class="btn btn-success">Add New Food Item</a>
        </div>
        <h3>Food Items</h3>
        <div class="row">
            <c:forEach var="item" items="${foodItems}">
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <c:if test="${not empty item.imagePath}">
                            <img src="${pageContext.request.contextPath}${item.imagePath}" class="card-img-top" alt="${item.name}">
                        </c:if>
                        <div class="card-body">
                            <h5 class="card-title">${item.name}</h5>
                            <p class="card-text">Price: $${item.price}</p>
                            <p class="card-text">${item.description}</p>
                            <a href="${pageContext.request.contextPath}/admin/editFoodItem/${item.foodId}" class="btn btn-info btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/deleteFoodItem/${item.foodId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>