package com.shop.controller;

import com.shop.model.Product;
import com.shop.service.ProductService; // ឬ ProductDAO របស់អ្នក

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductController extends HttpServlet {
    
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. ទាញយក Products ទាំងអស់ពី Database
        List<Product> products = productService.getAllProducts();
        
        // 2. ផ្ញើ List Products ទៅកាន់ JSP ក្រោមឈ្មោះ Variable "productsList"
        request.setAttribute("productsList", products);
        
        // 3. Forward ទៅកាន់ products.jsp ក្នុង Folder admin/
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
}