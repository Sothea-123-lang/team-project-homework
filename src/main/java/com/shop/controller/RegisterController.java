package com.shop.controller;

import com.shop.model.User;
import com.shop.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Ensure UTF-8 character encoding
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // 1. Check if email already exists in Database
        User existingUser = null;
        try {
            existingUser = userService.findByEmail(email);
        } catch (Exception e) {
            // Ignore if findByEmail method is not implemented, catch block below will handle exceptions
        }

        if (existingUser != null) {
            // Send user-friendly error message if email exists
            request.setAttribute("error", "The email '" + email + "' is already registered. Please use another email or login.");
            
            // Preserve form data except password
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 2. Build User object
        User user = new User();
        user.setName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setAddress(address);

        // 3. Set dynamic testing roles based on password
        if ("123@admin".equals(password)) {
            user.setRole("ADMIN");
        } else if ("123@customer".equals(password)) {
            user.setRole("CUSTOMER");
        } else {
            user.setRole("CUSTOMER"); // Default role
        }

        try {
            userService.register(user);
            // Redirect to login page on success
            response.sendRedirect(request.getContextPath() + "/login?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            
            // Handle duplicate database exceptions gracefully
            String errorMsg = "Registration failed. Please check your details and try again.";
            if (e.getMessage() != null && (e.getMessage().contains("EMAIL") || e.getMessage().contains("23505"))) {
                errorMsg = "The email '" + email + "' is already registered. Please use another email.";
            }

            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}