<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Restaurants - Sky Tasty</title>
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
        .navbar-brand { font-weight: bold; color: #ff5733 !important; transition: color 0.3s; }
        .navbar-brand:hover { color: #ff8c42 !important; }
        .nav-link { color: #ff5733; font-weight: 500; transition: color 0.3s; }
        .nav-link:hover { color: #ff8c42; }
        .container { flex: 1; }
        .search-bar { margin-bottom: 20px; max-width: 600px; margin-left: auto; margin-right: auto; }
        .search-bar .input-group { border-radius: 25px; overflow: hidden; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        .search-bar input { border: none; padding: 12px 20px; background: rgba(255, 255, 255, 0.9); }
        .search-bar input:focus { outline: none; box-shadow: none; }
        .search-bar button { background: #ff5733; border: none; padding: 12px 25px; color: white; transition: background-color 0.3s; }
        .search-bar button:hover { background: #ff8c42; }
        .card { border: none; border-radius: 12px; background: linear-gradient(135deg, #ffffff 0%, #fffaf0 100%); box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); transition: transform 0.3s, box-shadow 0.3s; height: 100%; }
        .card:hover { transform: scale(1.02); box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15); }
        .card-title { color: #ff5733; font-size: 1.25rem; font-weight: 600; }
        .card-text { color: #555; }
        .card-body { display: flex; flex-direction: column; justify-content: space-between; height: 100%; }
        .btn-primary { background: #ff5733; border: none; padding: 8px 15px; border-radius: 10px; transition: all 0.3s ease; }
        .btn-primary:hover { background: #ff8c42; transform: scale(1.05); }
        .btn-danger { background: #dc3545; border: none; padding: 5px 10px; border-radius: 10px; transition: all 0.3s ease; }
        .btn-danger:hover { background: #c82333; transform: scale(1.05); }
        .text-muted { text-align: center; font-style: italic; color: #888; }
        .footer { background: linear-gradient(90deg, #ff5733, #ff8c42); color: white; padding: 15px 0; margin-top: auto; text-align: center; }
        @media (max-width: 768px) { .search-bar { max-width: 100%; } .card { margin-bottom: 15px; } .card-title { font-size: 1.1rem; } .btn-primary, .btn-danger { font-size: 0.9rem; padding: 6px 12px; } }
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
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/order/history">Order History</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: #ff5733;">Restaurants</h2>
            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/restaurants" method="get">
                    <div class="input-group">
                        <input type="text" name="cuisine" class="form-control" placeholder="Search by cuisine (e.g., Indian, Italian)" value="${cuisine}">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </div>
                </form>
            </div>
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session" />
            </c:if>
            <c:choose>
                <c:when test="${empty restaurants}">
                    <p class="text-muted">No restaurants found. Try a different cuisine!</p>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <c:forEach items="${restaurants}" var="restaurant">
                            <div class="col-md-4 mb-4">
                                <div class="card h-100">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${restaurant.name}</h5>
                                        <p class="card-text">Cuisine: ${restaurant.cuisine}</p>
                                        <p class="card-text">Address: ${restaurant.address}</p>
                                        <p class="card-text">Items: ${restaurant.foodItems != null ? restaurant.foodItems.size() : 0}</p>
                                        <div class="mt-auto">
                                            <a href="${pageContext.request.contextPath}/restaurants/${restaurant.restaurantId}/menu" class="btn btn-primary">View Menu</a>
                                            <c:if test="${sessionScope.userRole == 'ADMIN'}">
                                                <a href="${pageContext.request.contextPath}/admin/deleteRestaurant/${restaurant.restaurantId}" class="btn btn-danger ms-2" onclick="return confirm('Are you sure you want to delete ${restaurant.name}?')">Delete</a>
                                            </c:if>
                                        </div>
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