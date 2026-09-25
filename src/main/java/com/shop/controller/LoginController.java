package com.shop.controller;

import com.shop.model.User;
import com.shop.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User loggedInUser = (User) session.getAttribute("user");
            redirectToRoleFolder(loggedInUser, request, response);
            return;
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User existingUser = userService.findByEmail(email);

        if (existingUser == null) {
            request.setAttribute("errorMessage", "This email is not registered. Please register first.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userService.login(email, password);

        if (user != null) {
            // 🔥 Override Role តាម Password សម្រាប់ Dev Testing ដូចមុន
            if ("123@admin".equals(password)) {
                user.setRole("ADMIN");
            } else if ("123@customer".equals(password)) {
                user.setRole("CUSTOMER");
            } else {
                // ប្រសិនបើ Login តាម Password ធម្មតា ឱ្យយក Role ចេញពី Database (បើ null ឱ្យ default ទៅ CUSTOMER)
                if (user.getRole() == null || user.getRole().trim().isEmpty()) {
                    user.setRole("CUSTOMER");
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            redirectToRoleFolder(user, request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid password. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    // Helper method សម្រាប់ដេញ Route តាម Role ឱ្យត្រឹមត្រូវ
    private void redirectToRoleFolder(User user, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String role = (user.getRole() != null) ? user.getRole().trim() : "";
        
        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            // រាល់ Non-Admin Users (CUSTOMER) ទាំងអស់ ឱ្យរត់ទៅកាន់ /products
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}