<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Cart - Sky Tasty</title>
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
        .container {
            flex: 1;
        }
        .table {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-warning, .btn-danger {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .footer {
            background: linear-gradient(90deg, #ff5733, #ff8c42);
            color: white;
            padding: 15px 0;
            margin-top: auto;
            text-align: center;
        }
        @media (max-width: 768px) {
            .table { font-size: 0.9rem; }
            .btn-warning, .btn-danger { width: 100%; margin-top: 0.5rem; }
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
            <h2 class="text-center mb-4" style="color: #ff5733;">Shopping Cart</h2>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:choose>
                <c:when test="${empty cartItems}">
                    <p class="text-muted">Your cart is empty!</p>
                </c:when>
                <c:otherwise>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartItems}" var="entry">
    <tr>
        <td>${entry.key.name}</td>
        <td>$${entry.key.price}</td>
        <td>${entry.value}</td>
        <td>$${entry.key.price * entry.value}</td>
        <td>
            <form action="${pageContext.request.contextPath}/order/cart/update" method="post" style="display:inline;">
    <input type="hidden" name="foodId" value="${entry.key.foodId}">
    <input type="number" name="quantity" value="${entry.value}" min="0" class="form-control" style="width: 60px; display: inline;">
    <button type="submit" class="btn btn-warning btn-sm">Update</button>
</form>
            <form action="${pageContext.request.contextPath}/order/cart/remove" method="post" style="display:inline;">
                <input type="hidden" name="foodId" value="${entry.key.foodId}">
                <button type="submit" class="btn btn-danger btn-sm">Remove</button>
            </form>
        </td>
    </tr>
</c:forEach>
                        </tbody>
                    </table>
                    <h4 class="text-end">Total: $${totalAmount}</h4>
                    <form action="${pageContext.request.contextPath}/order/cart/checkout" method="post" class="text-end mt-3">
                        <button type="submit" class="btn btn-primary">Checkout</button>
                    </form>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-secondary mt-3">Continue Shopping</a>
        </div>
    </div>

    <footer class="footer">
        <p class="text-center">© 2025 Sky Tasty. All rights reserved.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>