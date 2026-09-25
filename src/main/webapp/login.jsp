<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Back - Login</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F5EFE6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            background-color: #FFFFFF;
            border-radius: 16px;
            border: none;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            padding: 40px 32px;
            width: 100%;
            max-width: 400px;
        }
        .title-text {
            color: #3C2415;
            font-weight: 800;
            font-size: 1.8rem;
        }
        .subtitle-text {
            color: #8C827A;
            font-size: 0.95rem;
        }
        .alert-success-custom {
            background-color: #E8F5E9;
            color: #2E7D32;
            border-radius: 8px;
            border: none;
            font-size: 0.9rem;
            padding: 10px 14px;
        }
        .form-label-custom {
            color: #5C4033;
            font-weight: 700;
            font-size: 0.9rem;
            margin-bottom: 6px;
        }
        .form-control-custom {
            border: 1px solid #D1C7BD;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 0.95rem;
            color: #333;
        }
        .form-control-custom:focus {
            border-color: #C87D32;
            box-shadow: 0 0 0 0.2rem rgba(200, 125, 50, 0.25);
        }
        .btn-brown-custom {
            background-color: #C87D32;
            color: #FFFFFF;
            font-weight: 700;
            font-size: 1.05rem;
            border: none;
            border-radius: 8px;
            padding: 12px;
            transition: background-color 0.2s ease;
        }
        .btn-brown-custom:hover {
            background-color: #B06C28;
            color: #FFFFFF;
        }
        .footer-text {
            color: #6C757D;
            font-size: 0.9rem;
        }
        .footer-link {
            color: #5C4033;
            font-weight: 700;
            text-decoration: none;
        }
        .footer-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100">

<div class="login-card text-center">
    <!-- Header -->
    <h2 class="title-text mb-1">Welcome Back</h2>
    <p class="subtitle-text mb-4">Login to E-Commerce & Inventory System</p>

    <!-- Success Message -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success-custom text-start mb-4">
            ✓ Registration successful! Please log in.
        </div>
    </c:if>

    <!-- Error Message (Supports both errorMessage and error) -->
    <c:set var="displayError" value="${not empty errorMessage ? errorMessage : error}" />
    <c:if test="${not empty displayError}">
        <div class="alert alert-danger py-2 small text-start mb-4">
            ${displayError}
        </div>
    </c:if>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/login" method="post" class="text-start">
        <div class="mb-3">
            <label class="form-label form-label-custom">Email</label>
            <input type="email" name="email" class="form-control form-control-custom" placeholder="dara@example.com" required>
        </div>

        <div class="mb-4">
            <label class="form-label form-label-custom">Password</label>
            <input type="password" name="password" class="form-control form-control-custom" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn btn-brown-custom w-100 mb-4">Login</button>
    </form>

    <!-- Footer -->
    <div class="footer-text">
        No account? <a href="${pageContext.request.contextPath}/register" class="footer-link">Register here</a>
    </div>
</div>

</body>
</html>