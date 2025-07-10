<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffebcd 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
        }
        .navbar-brand {
            font-weight: bold;
            color: #ff5733 !important;
            transition: color 0.3s;
            display: flex;
            align-items: center;
        }
        .navbar-brand:hover {
            color: #ff8c42 !important;
        }
        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            width: 100%;
            max-width: 450px;
            margin: 20px;
            padding: 20px;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            background: linear-gradient(135deg, #ffffff 0%, #fff3e6 100%);
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
            font-size: 1.1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            width: 100%;
        }
        .btn-primary:hover {
            background: #ff8c42;
            transform: scale(1.05);
        }
        .text-danger {
            text-align: center;
            margin-top: 10px;
            font-weight: 500;
        }
        .footer {
            background: #ff5733;
            color: white;
            padding: 10px 0;
            margin-top: auto;
        }
        @media (max-width: 768px) {
            .card {
                max-width: 100%;
                margin: 10px;
            }
            .card-header {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">Sky Tasty</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header">Register with Sky Tasty</div>
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/register">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username:</label>
                        <input type="text" id="username" name="username" class="form-control" value="${user.username}" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password:</label>
                        <input type="password" id="password" name="password" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" id="email" name="email" class="form-control" value="${user.email}" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                    <c:if test="${not empty error}">
                        <p class="text-danger">${error}</p>
                    </c:if>
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