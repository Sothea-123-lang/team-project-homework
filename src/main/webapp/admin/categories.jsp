<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Categories Management</title>
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

        .sidebar h2 { text-align: center; margin-bottom: 30px; font-size: 22px; }
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
        .main-content { flex: 1; padding: 40px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .header h1 { margin: 0; }

        .add-form {
            background-color: var(--white);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            gap: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .add-form input[type="text"] {
            flex: 1;
            padding: 10px;
            border: 1px solid var(--border-light);
            border-radius: 4px;
            font-size: 15px;
        }
        .add-form button {
            background-color: var(--btn-tan);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .table-container {
            background-color: var(--white);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        table { width: 100%; border-collapse: collapse; }
        thead { background-color: var(--primary-brown); color: var(--white); }
        th, td { padding: 16px; text-align: left; border-bottom: 1px solid var(--border-light); }
        tr:last-child td { border-bottom: none; }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/products">Manage Products</a>
        <a href="${pageContext.request.contextPath}/admin/inventory">Inventory</a>
        <a href="${pageContext.request.contextPath}/admin/categories" class="active">Categories</a>
        <a href="${pageContext.request.contextPath}/orders">View Orders</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Categories Management</h1>
        </div>

        <!-- Add Category Form -->
        <form action="${pageContext.request.contextPath}/admin/categories" method="POST" class="add-form">
            <input type="text" name="name" placeholder="Enter new category name..." required />
            <button type="submit">Add Category</button>
        </form>

        <!-- Categories Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Category ID</th>
                        <th>Category Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cat" items="${categories}">
                        <tr>
                            <td>#${cat.id}</td>
                            <td>${cat.name}</td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty categories}">
                        <tr>
                            <td colspan="2" style="text-align: center;">No categories found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>