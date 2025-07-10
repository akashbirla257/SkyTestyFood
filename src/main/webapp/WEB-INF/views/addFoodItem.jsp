<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Food Item - Sky Tasty</title>
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
            max-width: 500px;
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
        .form-label {
            font-weight: 500;
            color: #333;
        }
        .form-control {
            border-radius: 10px;
            border: 1px solid #ddd;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #ff5733;
            box-shadow: 0 0 5px rgba(255, 87, 51, 0.5);
            outline: none;
        }
        .btn-primary {
            background: #ff5733;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: #ff8c42;
            transform: scale(1.05);
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background: #5a6268;
            transform: scale(1.05);
        }
        .footer {
            background: #ff5733;
            color: white;
            padding: 10px 0;
            margin-top: auto;
            text-align: center;
        }
        .alert {
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .card { max-width: 100%; margin: 10px; }
            .card-header { font-size: 1.2rem; }
            .btn { font-size: 0.9rem; padding: 8px 15px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">Add Food Item</div>
            <div class="card-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/addFoodItem" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="restaurantId" class="form-label">Restaurant</label>
                        <select id="restaurantId" name="restaurantId" class="form-control" required>
                            <c:forEach var="restaurant" items="${restaurants}">
                                <option value="${restaurant.restaurantId}">${restaurant.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" id="price" step="0.01" name="price" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" id="description" name="description" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="image" class="form-label">Image</label>
                        <input type="file" id="image" name="image" class="form-control" accept="image/*" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Save Food Item</button>
                    <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">Back</a>
                </form>
            </div>
        </div>
    </div>
    <footer class="footer">
        <p class="text-center">© 2025 Sky Tasty. All rights reserved.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>