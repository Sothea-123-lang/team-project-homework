package com.shop.controller;

import com.shop.model.Order;
import com.shop.model.Product;
import com.shop.model.User;
import com.shop.service.OrderService;
import com.shop.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {

    private ProductService productService = new ProductService();
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Security check: Only allow ADMIN users
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1. Total Products
        List<Product> products = productService.getAllProducts();
        int totalProducts = (products != null) ? products.size() : 0;

        // 2. Low Stock Items (Threshold: stockQty < 5)
        long lowStockCount = 0;
        if (products != null) {
            lowStockCount = products.stream()
                    .filter(p -> p.getStockQty() < 5)
                    .count();
        }

        // Fetch all orders
        List<Order> orders = orderService.getAllOrders();

        long pendingOrdersCount = 0;
        BigDecimal totalRevenue = BigDecimal.ZERO;

        if (orders != null) {
            // 3. Pending Orders Count (ត្រួតពិនិត្យទាំង "PENDING" និង "PENDING_PAYMENT")
            pendingOrdersCount = orders.stream()
                    .filter(o -> o.getStatus() != null && 
                           ("PENDING".equalsIgnoreCase(o.getStatus()) || "PENDING_PAYMENT".equalsIgnoreCase(o.getStatus())))
                    .count();

            // 4. Total Revenue (Sum of totalAmount for PAID or COMPLETED orders)
            totalRevenue = orders.stream()
                    .filter(o -> o.getStatus() != null && 
                           ("PAID".equalsIgnoreCase(o.getStatus()) || "COMPLETED".equalsIgnoreCase(o.getStatus())))
                    .map(Order::getTotalAmount)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
        }

        // Pass calculated metrics to JSP (កែប្រែ lowStockItems មក lowStockCount ឱ្យត្រូវ JSP)
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("pendingOrders", pendingOrdersCount);
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}