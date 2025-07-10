<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('https://source.unsplash.com/1920x1080/?restaurant') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.1);
        }
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem 3rem;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-container h2 {
            color: #ff5733;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .form-label {
            font-weight: 500;
            color: #333;
        }
        .form-control {
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 0.75rem;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            border-color: #ff5733;
            box-shadow: 0 0 5px rgba(255, 87, 51, 0.3);
            outline: none;
        }
        .btn-primary {
            background: linear-gradient(90deg, #ff5733, #ff8c42);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(255, 87, 51, 0.4);
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-secondary:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.4);
        }
        .alert-danger {
            border-radius: 10px;
            margin-bottom: 1rem;
            font-weight: 500;
        }
        @media (max-width: 480px) {
            .login-container {
                padding: 1.5rem 2rem;
                margin: 1rem;
            }
            .btn-primary, .btn-secondary {
                width: 100%;
                margin-top: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2> Sky Tasty Admin</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
            <a href="${pageContext.request.contextPath}" class="btn btn-secondary">Back to Home</a>
        </form>
    </div>
</body>
</html>