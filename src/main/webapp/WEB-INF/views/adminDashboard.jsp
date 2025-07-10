 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffebcd 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            width: 100%;
            max-width: 600px;
            margin: 20px;
            padding: 20px;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            background: linear-gradient(135deg, #ffffff 0%, #fff3e6 100%);
        }
        .card-header {
            background: #ff5733;
            color: white;
            text-align: center;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .alert {
            margin-bottom: 20px;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn {
            flex: 1;
            min-width: 150px;
        }
        .restaurant-list {
            margin-top: 20px;
        }
        .restaurant-list h4 {
            color: #ff5733;
        }
        .restaurant-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background: #fff;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        .food-item-card {
            margin-top: 10px;
            padding: 10px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .footer {
            background: #ff5733;
            color: white;
            padding: 10px 0;
            margin-top: auto;
            text-align: center;
        }
        @media (max-width: 768px) {
            .card { max-width: 100%; margin: 10px; }
            .card-header { font-size: 1.2rem; }
            .btn { min-width: 100px; }
            .restaurant-item { flex-direction: column; text-align: center; gap: 10px; }
            .food-item-card { margin-left: 0; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">Admin Dashboard - Sky Tasty</div>
            <div class="card-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <div class="btn-group">
                     <a href="${pageContext.request.contextPath}/admin/searchRestaurant" class="btn btn-primary mb-3">Search Restaurants</a>
                    <a href="${pageContext.request.contextPath}/admin/addRestaurant" class="btn btn-primary">Add Restaurant</a>
                    <a href="${pageContext.request.contextPath}/admin/addFoodItem" class="btn btn-primary">Add Food Item</a>
                </div>
                <div class="restaurant-list">
                    <h4>Manage Restaurants</h4>
                    <c:forEach var="restaurant" items="${restaurants}">
                        <div class="restaurant-item">
                            <span>${restaurant.name}</span>
                            <div>
                                <a href="${pageContext.request.contextPath}/admin/updateRestaurant/${restaurant.restaurantId}" class="btn btn-primary btn-sm">Update</a>
                                <form action="${pageContext.request.contextPath}/admin/deleteRestaurant/${restaurant.restaurantId}" method="post" style="display:inline;">
                                    <input type="hidden" name="restaurantId" value="${restaurant.restaurantId}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this restaurant? This action cannot be undone.');">Delete</button>
                                </form>
                            </div>
                        </div>
                        
                        <!-- <c:if test="${not empty restaurant.foodItems}">
                            <div class="food-item-card">
                                 <h5>Food Items for ${restaurant.name}</h5>
                                <c:forEach var="item" items="${restaurant.foodItems}">
                                    <div class="card mb-2">
                                        <img src="${pageContext.request.contextPath}${item.imagePath}" class="card-img-top" alt="${item.name}" style="height: 150px; object-fit: cover;">
                                        <div class="card-body">
                                            <h6 class="card-title">${item.name}</h6>
                                            <p class="card-text">Price: $${item.price}</p>
                                            <p class="card-text">${item.description}</p>
                                            <a href="${pageContext.request.contextPath}/admin/editFoodItem/${item.foodId}" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="${pageContext.request.contextPath}/admin/deleteFoodItem/${item.foodId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if> -->
                        
                        
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <footer class="footer">
        <p class="text-center">© 2025 Sky Tasty. All rights reserved.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
