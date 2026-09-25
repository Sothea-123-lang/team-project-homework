package com.shop.controller;

import com.shop.model.Order;
import com.shop.model.User;
import com.shop.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrderController extends HttpServlet {
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Redirect to login if user is not logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Order> orders = new ArrayList<>();

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            orders = orderService.getAllOrders();
            request.setAttribute("orders", orders);
            request.setAttribute("ordersList", orders);
            request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
        } else {
            // 🔥 ប្រើប្រាស់ method មានស្រាប់ getOrdersByUserId(...) តែមួយគត់
            if (user.getId() != null && user.getId() > 0) {
                orders = orderService.getOrdersByUserId(user.getId());
            }

            // Set ទាំង "orders" និង "ordersList" ដើម្បីធានាថា customer/orders.jsp ទាញបាន
            request.setAttribute("orders", orders);
            request.setAttribute("ordersList", orders);

            request.getRequestDispatcher("/customer/orders.jsp").forward(request, response);
        }
    }
}