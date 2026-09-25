<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - E-Commerce & Inventory Management</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom Styles -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/products">
                <i class="bi bi-shop me-2"></i>E-Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- Search Form -->
                <form class="d-flex mx-auto my-2 my-lg-0 w-50" action="${pageContext.request.contextPath}/products" method="get">
                    <div class="input-group">
                        <input class="form-control" type="search" name="search" value="${param.search}" placeholder="Search products..." aria-label="Search">
                        <button class="btn btn-primary" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>

                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="bi bi-cart3 me-1"></i>Cart
                        </a>
                    </li>
                    <c:choose>
                        <%-- ✅ 1. កែប្រែមកប្រើ loggedInUser ឱ្យត្រូវជាមួយ LoginController --%>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <li class="nav-item dropdown ms-2">
                                <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle me-1"></i>${sessionScope.loggedInUser.email}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                                        <li>
                                            <a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
                                                <i class="bi bi-speedometer2 me-2"></i>Admin Dashboard
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                            <i class="bi bi-bag-check me-2"></i>Order History
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item text-muted" href="${pageContext.request.contextPath}/logout">
                                            <i class="bi bi-box-arrow-right me-2"></i>Logout
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:when>
                        <%-- Guest User --%>
                        <c:otherwise>
                            <li class="nav-item ms-2">
                                <%-- ✅ 2. ចុចទៅ Servlet /login ជំនួសឱ្យ /login.jsp --%>
                                <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/login">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/register">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Header Hero Banner -->
    <div class="bg-primary text-white py-5 mb-4 text-center shadow-sm">
        <div class="container">
            <h1 class="display-5 fw-bold">Welcome to Our Online Store</h1>
            <p class="lead mb-0">Discover quality products at affordable prices</p>
        </div>
    </div>

    <!-- Main Content Container -->
    <div class="container mb-5">
        <div class="row">
            
            <!-- Category Sidebar Filter -->
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white fw-bold py-3">
                        <i class="bi bi-list-ul me-2"></i>Categories
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/products" 
                           class="list-group-item list-group-item-action ${empty param.categoryId ? 'active fw-bold' : ''}">
                            All Products
                        </a>
                        <c:forEach var="cat" items="${categories}">
                            <a href="${pageContext.request.contextPath}/products?categoryId=${cat.id}" 
                               class="list-group-item list-group-item-action ${param.categoryId == cat.id ? 'active fw-bold' : ''}">
                                ${cat.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Product Grid -->
            <div class="col-md-9">
                <%-- Global Notification Banner --%>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <c:forEach var="prod" items="${products}">
                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 hover-shadow transition">
                                <img src="${not empty prod.imageUrl ? prod.imageUrl : 'https://via.placeholder.com/300x200?text=No+Image'}" 
                                     class="card-img-top" alt="${prod.name}" style="height: 180px; object-fit: cover;">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title text-truncate fw-bold">${prod.name}</h5>
                                    <p class="card-text text-muted small flex-grow-1">${not empty prod.description ? prod.description : 'No description available.'}</p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="h5 text-primary mb-0 fw-bold">
                                            <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="$"/>
                                        </span>
                                        <%-- ✅ 3. កែប្រែមកប្រើ prod.stockQty ឱ្យត្រូវជាមួយ Entity Product --%>
                                        <c:choose>
                                            <c:when test="${prod.stockQty > 0}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle">
                                                    In Stock (${prod.stockQty})
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Out of Stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="card-footer bg-white border-0 pt-0 pb-3">
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${prod.id}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-outline-primary w-100 fw-semibold" 
                                                ${prod.stockQty <= 0 ? 'disabled' : ''}>
                                            <i class="bi bi-cart-plus me-1"></i>Add to Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <%-- Empty State --%>
                    <c:if test="${empty products}">
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-box-seam display-1 text-muted"></i>
                            <p class="mt-3 text-muted fs-5">No products found.</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-primary">View All Products</a>
                        </div>
                    </c:if>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>