<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Restaurants - Sky Tasty Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #f8f9fa 0%, #ffebcd 100%); min-height: 100vh; }
        .container { padding: 20px; }
        .table { background: #fff; border-radius: 10px; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Search Restaurants</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
            <c:remove var="message" scope="session" />
        </c:if>
        <form action="${pageContext.request.contextPath}/admin/searchRestaurant" method="get" class="mb-4">
            <div class="input-group">
                <input type="text" name="searchTerm" class="form-control" placeholder="Enter cuisine or name" value="${param.searchTerm}">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Cuisine</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="restaurant" items="${restaurants}">
                    <tr>
                        <td>${restaurant.restaurantId}</td>
                        <td>${restaurant.name}</td>
                        <td>${restaurant.address}</td>
                        <td>${restaurant.cuisine}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/manageRestaurant/${restaurant.restaurantId}" class="btn btn-info btn-sm">Manage</a>
                            <a href="${pageContext.request.contextPath}/admin/updateRestaurant/${restaurant.restaurantId}" class="btn btn-warning btn-sm">Update</a>
                            <a href="${pageContext.request.contextPath}/admin/deleteRestaurant/${restaurant.restaurantId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>