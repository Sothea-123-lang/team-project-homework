package com.shop.controller;

import com.shop.model.Category;
import com.shop.model.Product;
import com.shop.model.User;
import com.shop.service.CategoryService;
import com.shop.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    private ProductService productService = new ProductService();
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchQuery = request.getParameter("search");
        List<Product> products;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            products = productService.searchProducts(searchQuery.trim());
        } else {
            products = productService.getAllProducts();
        }

        List<Category> categories = categoryService.getAllCategories();

        // Pass data to request attributes
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        // Check session and role
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (loggedInUser != null && "ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
            // Forward to /admin/products.jsp (Removed /WEB-INF/ prefix)
            request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
        } else {
            // Forward to /customer/products.jsp (Removed /WEB-INF/ prefix)
            request.getRequestDispatcher("/customer/products.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        try {
            String name = request.getParameter("name");
            Long categoryId = Long.parseLong(request.getParameter("categoryId"));
            double price = Double.parseDouble(request.getParameter("price"));
            int stockQty = Integer.parseInt(request.getParameter("stockQty"));

            Product product = new Product();
            product.setName(name);
            product.setCategoryId(categoryId);
            product.setPrice(price);
            product.setStockQty(stockQty);

            productService.addProduct(product);

            response.sendRedirect(request.getContextPath() + "/products");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/products?error=failed");
        }
    }
}