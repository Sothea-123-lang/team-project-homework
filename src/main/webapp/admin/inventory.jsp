<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Management</title>
    <style>
        :root {
            --bg-color: #f7f3e8;
            --text-dark: #3e2723;
            --primary-brown: #5d4037;
            --btn-tan: #cf8c59;
            --white: #ffffff;
            --border-light: #e0e0e0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            margin: 0;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 250px;
            background-color: var(--primary-brown);
            color: var(--white);
            padding: 20px 0;
            display: flex;
            flex-direction: column;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 22px;
        }

        .sidebar a {
            color: var(--white);
            text-decoration: none;
            padding: 15px 25px;
            display: block;
            border-left: 4px solid transparent;
            transition: all 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: rgba(255,255,255,0.1);
            border-left: 4px solid var(--btn-tan);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 40px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            margin: 0;
        }

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
            border-bottom: 1px solid var(--border-light);
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
        }

        .status-instock { background-color: #d4edda; color: #155724; }
        .status-lowstock { background-color: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/products">Manage Products</a>
        <a href="${pageContext.request.contextPath}/admin/inventory" class="active">Inventory</a>
        <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
        <a href="${pageContext.request.contextPath}/orders">View Orders</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Inventory Management</h1>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Stock Quantity</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${productsList}">
                        <tr>
                            <td>#${product.id}</td>
                            <td>${product.name}</td>
                            <td>${product.stockQty}</td>
                            <td>
                                <span class="status-badge ${product.stockQty > 5 ? 'status-instock' : 'status-lowstock'}">
                                    ${product.stockQty > 5 ? 'In Stock' : 'Low Stock'}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty productsList}">
                        <tr>
                            <td colspan="4" style="text-align: center;">No inventory records found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>