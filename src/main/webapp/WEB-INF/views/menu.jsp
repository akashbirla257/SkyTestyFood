<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Menu - ${restaurant.name} - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; margin: 0; padding: 0; background: url('https://source.unsplash.com/1920x1080/?restaurant') no-repeat center center fixed, linear-gradient(135deg, rgba(248, 249, 250, 0.8) 0%, rgba(255, 235, 205, 0.8) 100%); background-size: cover, cover; min-height: 100vh; display: flex; flex-direction: column; }
        .content-overlay { background: rgba(255, 255, 255, 0.9); min-height: 100vh; padding: 20px 0; }
        .navbar-brand { font-weight: bold; color: #ff5733 !important; transition: color 0.3s; }
        .navbar-brand:hover { color: #ff8c42 !important; }
        .nav-link { color: #ff5733; font-weight: 500; transition: color 0.3s; }
        .nav-link:hover { color: #ff8c42; }
        .container { flex: 1; }
        .card { border: none; border-radius: 12px; background: linear-gradient(135deg, #ffffff 0%, #fffaf0 100%); box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); transition: transform 0.3s, box-shadow 0.3s; overflow: hidden; position: relative; }
        .card:hover { transform: scale(1.02); box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15); }
        .card-img-top { width: 100%; height: 200px; object-fit: cover; border-bottom: 1px solid #eee; }
        .card-title { color: #ff5733; font-size: 1.25rem; font-weight: 600; margin-bottom: 0.5rem; }
        .card-text { color: #555; margin-bottom: 1rem; }
        .add-to-cart { display: flex; gap: 10px; align-items: center; padding: 0.5rem; }
        .add-to-cart input { width: 70px; padding: 0.25rem; border-radius: 5px; border: 1px solid #ddd; }
        .btn-primary { background: linear-gradient(90deg, #ff5733, #ff8c42); border: none; padding: 0.5rem 1rem; font-weight: 600; border-radius: 10px; transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .btn-primary:hover { transform: scale(1.05); box-shadow: 0 4px 12px rgba(255, 87, 51, 0.4); }
        .footer { background: linear-gradient(90deg, #ff5733, #ff8c42); color: white; padding: 15px 0; margin-top: auto; text-align: center; }
        .cart-link { position: fixed; bottom: 20px; right: 20px; z-index: 1000; }
        @media (max-width: 768px) { .card { margin-bottom: 15px; } .card-title { font-size: 1.1rem; } .card-img-top { height: 150px; } .add-to-cart { flex-direction: column; gap: 5px; } .add-to-cart input { width: 60px; } .cart-link { bottom: 10px; right: 10px; } }
    </style>
</head>
<body>
    <div class="content-overlay">
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">Sky Tasty</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
                        <c:if test="${sessionScope.userRole == 'ADMIN'}">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin">Admin</a></li>
                        </c:if>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: #ff5733;">Menu - ${restaurant.name}</h2>
            <c:if test="${empty foodItems}">
                <p class="text-muted">No items available. Please check the admin panel or logs for issues.</p>
            </c:if>
            <c:if test="${not empty foodItems}">
                <div class="row">
                    <c:forEach var="item" items="${foodItems}">
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <c:choose>
                                    <c:when test="${not empty item.imagePath}">
                                        <img src="${pageContext.request.contextPath}${item.imagePath}" class="card-img-top" alt="${item.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card-img-top" style="height: 200px; background: #f8f9fa; display: flex; align-items: center; justify-content: center;">
                                            <p class="text-danger">No Image Available</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <h5 class="card-title">${item.name}</h5>
                                    <p class="card-text">Price: $${item.price}</p>
                                    <p class="card-text">${item.description}</p>
                                    <form action="${pageContext.request.contextPath}/order/cart/add" method="post" class="add-to-cart">
                                        <input type="hidden" name="foodId" value="${item.foodId}">
                                        <input type="number" name="quantity" value="1" min="1" class="form-control" required>
                                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-secondary mt-3">Back to Restaurants</a>
            <a href="${pageContext.request.contextPath}/order/cart" class="btn btn-success cart-link">View Cart</a>
        </div>
    </div>

    <footer class="footer">
        <p class="text-center">© 2025 Sky Tasty. All rights reserved.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>