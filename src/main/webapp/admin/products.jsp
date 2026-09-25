<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Products - Admin</title>
    <style>
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

        /* Header Navigation */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
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

        .action-btns {
            display: flex;
            gap: 10px;
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
        <div class="header-left">
            <%-- កែតម្រូវត្រង់នេះ៖ ប្តូរពី /admin/dashboard.jsp មក /admin/dashboard --%>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline">⬅ Back to Dashboard</a>
            <h1>Product Catalog (Admin)</h1>
        </div>

        <div class="header-actions">
            <span style="font-weight: bold; color: var(--primary-brown);">Admin: ${sessionScope.user.name}</span>
            <form action="${pageContext.request.contextPath}/logout" method="post">
                <button type="submit" class="btn btn-tan">Logout</button>
            </form>
        </div>
    </div>

    <!-- Search Bar -->
    <form action="${pageContext.request.contextPath}/products" method="get" class="search-container">
        <input type="text" name="search" class="search-input" placeholder="Search products...">
        <button type="submit" class="btn btn-search">Search</button>
    </form>

    <!-- Admin Add Product Panel -->
    <div class="admin-panel">
        <h3>+ Add New Product</h3>
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
                            <form action="${pageContext.request.contextPath}/deleteProduct" method="post">
                                <input type="hidden" name="productId" value="${product.id}">
                                <button type="submit" class="btn btn-delete" onclick="return confirm('Do you want to delete this product?');">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
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