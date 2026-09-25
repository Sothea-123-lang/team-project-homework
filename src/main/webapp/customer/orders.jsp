<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Order History</title>
    <style>
        :root {
            --bg-color: #f7f3e8;
            --text-dark: #3e2723;
            --primary-brown: #5d4037;
            --btn-tan: #cf8c59;
            --btn-hover: #b87543;
            --white: #ffffff;
            --border-light: #e0e0e0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            margin: 0;
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        .btn-back {
            background-color: var(--btn-tan);
            color: var(--white);
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 5px;
            font-weight: 600;
            transition: background 0.2s;
        }

        .btn-back:hover {
            background-color: var(--btn-hover);
        }

        .order-card {
            background-color: var(--white);
            border-radius: 8px;
            padding: 24px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            border: 1px solid var(--border-light);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-light);
            padding-bottom: 12px;
            margin-bottom: 16px;
        }

        .order-id {
            font-size: 18px;
            font-weight: bold;
            color: var(--primary-brown);
        }

        .status-badge {
            background-color: #d4edda;
            color: #155724;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .order-items {
            list-style: none;
            padding: 0;
            margin: 0 0 16px 0;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #f0f0f0;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            color: var(--primary-brown);
            border-top: 1px solid var(--border-light);
            padding-top: 12px;
        }

        .empty-orders {
            background-color: var(--white);
            padding: 40px;
            text-align: center;
            border-radius: 8px;
            color: #777;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>My Order History</h1>
        <a href="${pageContext.request.contextPath}/products" class="btn-back">&larr; Back to Shop</a>
    </div>

    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="order-header">
                        <span class="order-id">Order #${order.id}</span>
                        <span class="status-badge">${order.status}</span>
                    </div>

                    <ul class="order-items">
                        <c:forEach var="item" items="${order.items}">
                            <li class="order-item">
                                <span>${item.product.name} <strong>&times; ${item.quantity}</strong></span>
                                <span>$<fmt:formatNumber value="${item.priceAtPurchase * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </li>
                        </c:forEach>
                    </ul>

                    <div class="order-total">
                        Total Amount: $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-orders">
                <h3>No order history found.</h3>
                <p>You haven't placed any orders yet.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>