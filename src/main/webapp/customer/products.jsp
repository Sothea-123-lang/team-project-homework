<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Catalog</title>
    <style>
        /* Earthy color palette matching the UI mockup */
        :root {
            --bg-color: #f7f3e8;
            --text-dark: #3e2723;
            --primary-brown: #5d4037;
            --btn-tan: #cf8c59;
            --btn-red: #a1001a;
            --white: #ffffff;
            --border-light: #e0e0e0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Top Navigation/Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            color: var(--text-dark);
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            display: inline-block;
        }

        .btn-outline {
            background-color: var(--white);
            color: var(--btn-tan);
            border: 2px solid var(--btn-tan);
        }

        .btn-tan {
            background-color: var(--btn-tan);
            color: var(--white);
        }

        /* Search Bar */
        .search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
        }

        .search-input {
            flex: 1;
            padding: 12px;
            border: 1px solid var(--border-light);
            border-radius: 6px;
            font-size: 16px;
            background-color: var(--white);
        }

        .btn-search {
            background-color: var(--primary-brown);
            color: var(--white);
            padding: 0 30px;
        }

        /* Admin Add Product Panel */
        .admin-panel {
            background-color: var(--white);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .admin-panel h3 {
            margin-top: 0;
            color: var(--primary-brown);
            font-size: 16px;
        }

        .add-form {
            display: flex;
            gap: 15px;
        }

        .add-form input, .add-form select {
            padding: 10px;
            border: 1px solid var(--border-light);
            border-radius: 6px;
            flex: 1;
            font-size: 14px;
            background-color: var(--white);
        }

        /* Data Table */
        .table-container {
            background-color: var(--white);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: var(--primary-brown);
            color: var(--white);
        }

        th, td {
            padding: 16px;
            text-align: left;
        }

        tr {
            border-bottom: 1px solid var(--border-light);
        }

        tr:last-child {
            border-bottom: none;
        }

        .low-stock {
            color: var(--btn-red);
            font-weight: bold;
        }

        /* Table Action Buttons */
        .action-btns {
            display: flex;
            gap: 10px;
        }

        .btn-add-cart {
            background-color: var(--btn-tan);
            color: var(--white);
            padding: 8px 12px;
        }

        .btn-delete {
            background-color: var(--btn-red);
            color: var(--white);
            padding: 8px 12px;
        }
        
        form { margin: 0; }
    </style>
</head>
<body>

<div class="container">
    <!-- Header Navigation -->
    <div class="header">
        <h1>Product Catalog</h1>
        <div class="header-actions">
            <c:choose>
                <%-- 1. សម្រាប់ GUEST (មិនទាន់ Login) --%>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-tan">Login</a>
                </c:when>

                <%-- 2. សម្រាប់ CUSTOMER --%>
                <c:when test="${sessionScope.user.role == 'CUSTOMER'}">
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline">
                        🛒 View Cart (${not empty sessionScope.cartCount ? sessionScope.cartCount : '0'})
                    </a>
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline">Order History</a>
                    <form action="${pageContext.request.contextPath}/logout" method="post">
                        <button type="submit" class="btn btn-tan">Logout</button>
                    </form>
                </c:when>

                <%-- 3. សម្រាប់ ADMIN --%>
                <c:when test="${sessionScope.user.role == 'ADMIN'}">
                    <span style="font-weight: bold; color: var(--primary-brown);">Admin: ${sessionScope.user.username}</span>
                    <form action="${pageContext.request.contextPath}/logout" method="post">
                        <button type="submit" class="btn btn-tan">Logout</button>
                    </form>
                </c:when>
            </c:choose>
        </div>
    </div>

    <!-- Search Bar -->
    <form action="${pageContext.request.contextPath}/products" method="get" class="search-container">
        <input type="text" name="search" class="search-input" placeholder="Search products...">
        <button type="submit" class="btn btn-search">Search</button>
    </form>

    <!-- Admin Panel (បង្ហាញតែចំពោះ ADMIN ប៉ុណ្ណោះ) -->
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
        <div class="admin-panel">
            <h3>+ Add New Product (Admin)</h3>
            <form action="${pageContext.request.contextPath}/products" method="post" class="add-form">
                <input type="text" name="name" placeholder="Name" required>
                
                <select name="categoryId" required>
                    <option value="">-- Select Category --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                </select>
                
                <input type="number" step="0.01" name="price" placeholder="Price" required>
                <input type="number" name="stockQty" placeholder="Stock Qty" required>
                
                <button type="submit" class="btn btn-tan">Add Product</button>
            </form>
        </div>
    </c:if>

    <!-- Products Table -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.name}</td>
                        <td>${not empty product.category ? product.category.name : 'Uncategorized'}</td>
                        <td>$${product.price}</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.stockQty <= 5}">
                                    <span class="low-stock">${product.stockQty} (Low!)</span>
                                </c:when>
                                <c:otherwise>
                                    ${product.stockQty}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="action-btns">
                            <%-- GUEST ឬ CUSTOMER អាចឃើញ Button Add to Cart --%>
                            <c:if test="${empty sessionScope.user || sessionScope.user.role == 'CUSTOMER'}">
                                <form action="${pageContext.request.contextPath}/addToCart" method="post">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn btn-add-cart">Add to Cart</button>
                                </form>
                            </c:if>

                            <%-- ADMIN អាចឃើញ Button Delete --%>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <form action="${pageContext.request.contextPath}/deleteProduct" method="post">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn btn-delete" onclick="return confirm('Do you want to delete this product?');">Delete</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                
                <!-- Fallback if product list is empty -->
                <c:if test="${empty products}">
                    <tr>
                        <td colspan="5" style="text-align: center;">No products found in the catalog.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>