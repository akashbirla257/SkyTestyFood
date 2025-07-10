<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Orders - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Manage Orders</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:choose>
            <c:when test="${empty orders}">
                <p class="text-muted">No orders found.</p>
            </c:when>
            <c:otherwise> 
                <table class="table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Restaurant</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.restaurant.name}</td>
                                <td>$${order.totalAmount}</td>
                                <td>${order.status}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order/admin/updateOrder/${order.orderId}" class="btn btn-primary btn-sm">Update</a>
                                    <form action="${pageContext.request.contextPath}/order/admin/deleteOrder/${order.orderId}" method="post" style="display:inline;">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>