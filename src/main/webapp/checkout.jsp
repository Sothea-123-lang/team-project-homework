<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Success</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F5EFE6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .success-icon {
            background-color: #348E44;
            color: #FFFFFF;
            width: 72px;
            height: 72px;
            border-radius: 50%;
            font-size: 36px;
            display: inline-flex;
            justify-content: center;
            align-items: center;
        }
        .title-text {
            color: #3C2415;
            font-weight: 800;
            font-size: 1.8rem;
        }
        .subtitle-text {
            color: #8C827A;
            font-size: 1rem;
        }
        .receipt-card {
            background-color: #FFFFFF;
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
            padding: 24px 32px;
            width: 100%;
            max-width: 450px;
            font-size: 0.95rem;
            color: #333;
        }
        .btn-brown-custom {
            background-color: #C87D32;
            color: #FFFFFF;
            font-weight: 700;
            font-size: 1.05rem;
            border: none;
            border-radius: 8px;
            padding: 10px 24px;
            transition: background-color 0.2s ease;
        }
        .btn-brown-custom:hover {
            background-color: #B06C28;
            color: #FFFFFF;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100 text-center">

    <div class="container">
        <c:choose>
            <%-- Make sure an order actually exists in the session to display --%>
            <c:when test="${not empty sessionScope.lastOrder}">
                
                <!-- Success Icon -->
                <div class="success-icon mb-3 shadow-sm">&#10003;</div>

                <!-- Headers -->
                <h2 class="title-text mb-2">Order #${sessionScope.lastOrder.id} placed successfully!</h2>
                
                <!-- FIX: Use sessionScope.user.name or fallback to customer name safely -->
                <p class="subtitle-text mb-4">
                    Thank you for your purchase, 
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.name}">
                            ${sessionScope.user.name}
                        </c:when>
                        <c:otherwise>
                            Customer
                        </c:otherwise>
                    </c:choose>!
                </p>

                <!-- Receipt Card -->
                <div class="receipt-card mx-auto text-start mb-4">
                    <div class="mb-2">
                        <strong>Order ID:</strong> #${sessionScope.lastOrder.id}
                    </div>
                    <div class="mb-2 d-flex">
                        <strong class="me-2">Items:</strong>
                        <div>
                            <c:forEach items="${sessionScope.lastOrder.items}" var="item" varStatus="loop">
                                ${item.product.name} &times;${item.quantity}<c:if test="${!loop.last}">,<br></c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="mb-2">
                        <strong>Total:</strong> 
                        <fmt:formatNumber value="${sessionScope.lastOrder.totalAmount}" type="currency" currencySymbol="$" />
                    </div>
                    <div>
                        <strong>Status:</strong> ${not empty sessionScope.lastOrder.status ? sessionScope.lastOrder.status : 'COMPLETED'}
                    </div>
                </div>

                <!-- Button -->
                <a href="${pageContext.request.contextPath}/products" class="btn btn-brown-custom text-decoration-none">
                    Continue Shopping
                </a>

                <%-- Clear the receipt from session so refreshing doesn't re-trigger it --%>
                <c:remove var="lastOrder" scope="session"/>

            </c:when>
            
            <%-- Fallback if they visit the page directly without checking out --%>
            <c:otherwise>
                <h2 class="title-text mb-4">No recent orders found.</h2>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-brown-custom text-decoration-none">
                    Go to Products
                </a>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>