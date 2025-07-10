<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sky Tasty - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 0;
            background: url('<c:url value="/resources/image/bg.jpg" />') no-repeat center center fixed;
            background-size: cover;
            background-color: #f8f9fa;
        }
        .content-overlay {
            background: rgba(248, 249, 250, 0.9);
            min-height: 100vh;
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
        .navbar-logo {
            max-width: 50px;
            height: auto;
            margin-left: 10px;
            transition: transform 0.3s;
        }
        .navbar-logo:hover {
            transform: scale(1.1);
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://source.unsplash.com/1600x900/?food-table') no-repeat center;
            background-size: cover;
            height: 500px;
            color: white;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            animation: fadeIn 2s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .hero-content {
            text-align: center;
            animation: slideUp 1.5s ease-out;
        }
        @keyframes slideUp {
            from { transform: translateY(20%); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            animation: bounceIn 2s infinite;
        }
        @keyframes bounceIn {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
        .btn-primary {
            background-color: #ff5733;
            border: none;
            padding: 12px 30px;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #ff8c42;
            transform: scale(1.05);
        }
        .search-bar {
            margin-top: 20px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        .search-bar input {
            border-radius: 20px 0 0 20px;
            border: none;
            padding: 10px 20px;
        }
        .search-bar button {
            border-radius: 0 20px 20px 0;
            background-color: #ff5733;
            border: none;
            padding: 10px 20px;
            color: white;
            transition: background-color 0.3s;
        }
        .search-bar button:hover {
            background-color: #ff8c42;
        }
        .section {
            padding: 50px 0;
            background-color: rgba(255, 255, 255, 0.95);
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .carousel-item {
            height: 450px; /* Increased to accommodate larger images */
        }
        .carousel-inner .feature-card {
            background-color: #f1f1f1;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            transition: transform 0.3s;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .carousel-inner .feature-card:hover {
            transform: translateY(-10px);
        }
        .carousel-inner .feature-card img {
            width: 100%;
            height: 300px; /* Increased from 200px to 300px for larger vertical size */
            object-fit: cover;
            border-radius: 8px 8px 0 0;
            margin-bottom: 15px;
        }
        .footer {
            background: linear-gradient(90deg, #ff5733, #ff8c42);
            color: white;
            padding: 20px 0;
        }
        @media (max-width: 768px) {
            .hero h1 { font-size: 2rem; }
            .hero { height: 300px; }
            .btn-primary { font-size: 1rem; padding: 10px 20px; }
            .navbar-logo { max-width: 40px; }
            .carousel-item { height: 350px; } /* Adjusted for smaller screens */
            .carousel-inner .feature-card img { height: 200px; } /* Reduced for smaller screens */
            .search-bar { max-width: 100%; }
            .search-bar input, .search-bar button { border-radius: 10px; }
        }
    </style>
</head>
<body>
    <div class="content-overlay">
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    Sky Tasty
                    <img src="<c:url value="/resources/image/Logo.jpg" />" alt="Sky Tasty Logo" class="navbar-logo">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin">Admin</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="hero">
            <div class="hero-content">
                <h1>Welcome to Sky Tasty</h1>
                <p class="lead">Discover delicious food from top restaurants!</p>
                <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg">Explore Now</a>
                <div class="search-bar mt-4">
                    <form action="${pageContext.request.contextPath}/restaurants" method="get">
                        <div class="input-group">
                            <input type="text" name="cuisine" class="form-control" placeholder="Search by cuisine (e.g., Indian, Italian)" aria-label="Search">
                            <button class="btn" type="submit">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="container mt-5">
            <div class="section">
                <h2 class="text-center mb-4">Why Choose Sky Tasty?</h2>
                <div id="featureCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="feature-card">
                                <img alt="Variety of Cuisines" src="<c:url value="/resources/image/food2.jpg" />" width="300px" height="300px">
                                <h4>Variety of Cuisines</h4>
                                <p>Enjoy dishes from Indian, Italian, and more!</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="feature-card">
                                <img alt="Fast Delivery" src="<c:url value="/resources/image/food3.jpg" />" width="300px" height="300px">
                                <h4>Fast Delivery</h4>
                                <p>Get your food delivered in no time!</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="feature-card">
                                <img alt="Easy Ordering" src="<c:url value="/resources/image/food4.png" />" width="300px" height="300px">
                                <h4>Easy Ordering</h4>
                                <p>Order with a few clicks and savor the taste!</p>
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#featureCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#featureCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>

        <footer class="footer">
            <p class="text-center">© 2025 Sky Tasty. All rights reserved.</p>
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>