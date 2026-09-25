package com.shop.controller;

import com.shop.model.Category;
import com.shop.model.User;
import com.shop.service.CategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class CategoryController extends HttpServlet {
    
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security Check: អនុញ្ញាតតែ ADMIN ប៉ុណ្ណោះ
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. ទាញយកបញ្ជី Categories ទាំងអស់ពី Database
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);

        // 3. Forward ទៅកាន់ categories.jsp
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // សម្រាប់ទទួល Form បន្ថែម Category ថ្មី (Add Category)
        request.setCharacterEncoding("UTF-8");
        String categoryName = request.getParameter("name");

        if (categoryName != null && !categoryName.trim().isEmpty()) {
            categoryService.addCategory(categoryName.trim());
        }

        // Redirect មកកាន់ /admin/categories វិញដើម្បី Refresh
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}