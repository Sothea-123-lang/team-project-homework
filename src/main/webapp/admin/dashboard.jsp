<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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

        /* Main Content Area */
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

        .btn-logout {
            background-color: var(--btn-tan);
            color: var(--white);
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        /* Dashboard Cards */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background-color: var(--white);
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            text-align: center;
        }

        .stat-card h3 {
            margin: 0 0 10px 0;
            color: var(--primary-brown);
            font-size: 16px;
        }

        .stat-card .value {
            font-size: 32px;
            font-weight: bold;
            color: var(--btn-tan);
            margin: 0;
        }

        .alert-text {
            color: var(--btn-red);
        }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <%-- Route Links ទាំងអស់រត់ទៅកាន់ Servlet Controllers --%>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a>
        <a href="${pageContext.request.contextPath}/products">Manage Products</a>
        <a href="${pageContext.request.contextPath}/admin/inventory">Inventory</a>
        <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
        <a href="${pageContext.request.contextPath}/orders">View Orders</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Dashboard Overview</h1>
            <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                <button type="submit" class="btn-logout">Logout</button>
            </form>
        </div>

        <!-- Key Metrics -->
        <div class="dashboard-grid">
            <div class="stat-card">
                <h3>Total Products</h3>
                <p class="value">${not empty totalProducts ? totalProducts : 0}</p>
            </div>
            
            <div class="stat-card">
                <h3>Low Stock Items</h3>
                <p class="value alert-text">${not empty lowStockCount ? lowStockCount : 0}</p>
            </div>

            <div class="stat-card">
                <h3>Pending Orders</h3>
                <p class="value">${not empty pendingOrders ? pendingOrders : 0}</p>
            </div>

            <div class="stat-card">
                <h3>Total Revenue</h3>
                <p class="value">
                    $<fmt:formatNumber value="${not empty totalRevenue ? totalRevenue : 0}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                </p>
            </div>
        </div>
    </div>

</body>
</html>