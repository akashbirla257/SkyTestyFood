<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Food Item - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Edit Food Item</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/admin/updateFoodItem" method="post" enctype="multipart/form-data">
            <input type="hidden" name="foodId" value="${foodItem.foodId}">
            <div class="mb-3">
                <label class="form-label">Restaurant</label>
                <select name="restaurantId" class="form-select" required>
                    <c:forEach var="restaurant" items="${restaurants}">
                        <option value="${restaurant.restaurantId}" ${restaurant.restaurantId == foodItem.restaurant.restaurantId ? 'selected' : ''}>
                            ${restaurant.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" value="${foodItem.name}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="number" name="price" class="form-control" value="${foodItem.price}" step="0.01" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" required>${foodItem.description}</textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Image</label>
                <input type="file" name="image" class="form-control">
                <c:if test="${not empty foodItem.imagePath}">
                    <img src="${pageContext.request.contextPath}${foodItem.imagePath}" width="100" class="mt-2">
                </c:if>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
            <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">Back</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>