<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart</title>
    <style>
        body {
            background-color: #f6efe6; /* Light beige background */
            font-family: Arial, sans-serif;
            color: #3e2723;
            margin: 0;
            padding: 40px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        .btn-back {
            display: inline-block;
            background-color: #c98845; /* Orange-brown */
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            margin-bottom: 20px;
        }
        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #3b2a20;
        }
        .table-container {
            background-color: white;
            border-radius: 8px;
            overflow: hidden; /* Ensures table corners are rounded */
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background-color: #72533b; /* Dark brown header */
            color: white;
            text-align: left;
            padding: 12px 20px;
            font-weight: normal;
        }
        td {
            padding: 15px 20px;
            border-bottom: 1px solid #f0f0f0;
        }
        tr:last-child td {
            border-bottom: none;
        }
        .btn-remove {
            background-color: #a30026; /* Crimson red */
            color: white;
            border: none;
            padding: 6px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
        }
        .summary-section {
            text-align: right;
            padding-top: 10px;
        }
        .total-text {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #3b2a20;
        }
        .btn-checkout {
            background-color: #2c1b12; /* Very dark brown */
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Display Error Message if Checkout Fails -->
    <c:if test="${not empty requestScope.errorMessage}">
        <div class="alert-error">${requestScope.errorMessage}</div>
    </c:if>

    <!-- Back Button to Products Page -->
    <a href="${pageContext.request.contextPath}/products" class="btn-back">&larr; Back to Products</a>

    <!-- Page Title -->
    <h2>Your Shopping Cart</h2>

    <!-- Cart Table -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Subtotal</th>
                    <th></th> <!-- Empty header for remove button -->
                </tr>
            </thead>
            <tbody>
                <!-- Loop through cart items -->
                <c:forEach var="item" items="${sessionScope.cart.items}">
                    <tr>
                        <td>${item.product.name}</td>
                        <td>$<fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td>${item.quantity}</td>
                        <td>$<fmt:formatNumber value="${item.product.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: right;">
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="margin: 0;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="productId" value="${item.product.id}">
                                <button type="submit" class="btn-remove">Remove</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
                <!-- Fallback if cart has no items -->
                <c:if test="${empty sessionScope.cart.items}">
                    <tr>
                        <td colspan="5" style="text-align: center; color: #888;">Your cart is empty.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Summary Section -->
    <c:if test="${not empty sessionScope.cart.items}">
        <div class="summary-section">
            <c:set var="cartTotal" value="0" />
            <c:forEach var="item" items="${sessionScope.cart.items}">
                <c:set var="cartTotal" value="${cartTotal + (item.product.price * item.quantity)}" />
            </c:forEach>
            
            <div class="total-text">
                Total: $<fmt:formatNumber value="${cartTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
            </div>

            <!-- Submit form via POST to CheckoutController -->
            <form action="${pageContext.request.contextPath}/checkout" method="post">
                <button type="submit" class="btn-checkout">Checkout &rarr;</button>
            </form>
        </div>
    </c:if>

</div>

</body>
</html>