package com.shop.controller;

import com.shop.model.Product;
import com.shop.model.User;
import com.shop.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/inventory")
public class InventoryController extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security Check
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. ទាញយក Products/Stock ពី Database
        List<Product> products = productService.getAllProducts();
        
        // កែប្រែឈ្មោះ Attribute ទៅជា "productsList" ឱ្យត្រូវគ្នាជាមួយ JSP
        request.setAttribute("productsList", products);

        // 3. Forward ទៅកាន់ /admin/inventory.jsp
        request.getRequestDispatcher("/admin/inventory.jsp").forward(request, response);
    }
}