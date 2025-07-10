<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Order History - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://source.unsplash.com/1920x1080/?restaurant') no-repeat center center fixed, linear-gradient(135deg, rgba(248, 249, 250, 0.8) 0%, rgba(255, 235, 205, 0.8) 100%);
            background-size: cover, cover;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .content-overlay {
            background: rgba(255, 255, 255, 0.9);
            min-height: 100vh;
            padding: 20px 0;
        }
        .navbar-brand {
            font-weight: bold;
            color: #ff5733 !important;
            transition: color 0.3s;
        }
        .navbar-brand:hover {
            color: #ff8c42 !important;
        }
        .nav-link {
            color: #ff5733;
            font-weight: 500;
            transition: color 0.3s;
        }
        .nav-link:hover {
            color: #ff8c42;
        }
        .container {
            flex: 1;
        }
        .card {
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #ffffff 0%, #fffaf0 100%);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 15px;
        }
        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .card-title {
            color: #ff5733;
            font-size: 1.25rem;
            font-weight: 600;
        }
        .card-text {
            color: #555;
        }
        .footer {
            background: linear-gradient(90deg, #ff5733, #ff8c42);
            color: white;
            padding: 15px 0;
            margin-top: auto;
            text-align: center;
        }
        @media (max-width: 768px) {
            .card-title { font-size: 1.1rem; }
        }
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
                        <c:if test="${sessionScope.userRole == 'ADMIN'}">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin">Admin</a></li>
                        </c:if>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/order/history">Order History</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: #ff5733;">Order History</h2>
            <c:choose>
                <c:when test="${empty orders}">
                    <p class="text-muted">No orders found.</p>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <c:forEach items="${orders}" var="order">
                            <div class="col-md-12 mb-3">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Order #${order.orderId}</h5>
                                        <p class="card-text">Restaurant: ${order.restaurant.name}</p>
                                        <p class="card-text">Date: ${order.orderDate}</p>
                                        <p class="card-text">Total Amount: $${order.totalAmount}</p>
                                        <p class="card-text">Status: ${order.status}</p>
                                        <h6>Items:</h6>
                                        <ul>
                                            <c:forEach items="${order.orderItems}" var="item">
                                                <li>${item.foodItem.name} x${item.quantity} - $${item.price * item.quantity}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer class="footer">
        <p class="text-center">© 2025 Sky Tasty. All rights reserved.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>