package com.shop.controller;

import com.shop.model.Cart;
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

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // redirect Direct ទៅ /orders វិញ ការពារ 404 Error លើ JSP
        response.sendRedirect(request.getContextPath() + "/orders");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        Cart cart = (session != null) ? (Cart) session.getAttribute("cart") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            // Process transaction & save to DB
            Order completedOrder = orderService.processCheckout(user, cart);
            
            // Clear cart & cart count from session
            session.removeAttribute("cart");
            session.removeAttribute("cartCount");
            
            // Redirect ទៅកាន់ Order History (/orders) ភ្លាមៗ គ្មានទាក់ 404
            response.sendRedirect(request.getContextPath() + "/orders");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Checkout failed: " + e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
}