<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Order - Sky Tasty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Update Order #${order.orderId}</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/order/admin/updateOrder" method="post">
            <input type="hidden" name="orderId" value="${order.orderId}">
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-control" required>
                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="confirmed" ${order.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                    <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Delivered</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update Status</button>
            <a href="${pageContext.request.contextPath}/order/admin/orders" class="btn btn-secondary">Back</a>
        </form>
    </div>
</body>
</html>