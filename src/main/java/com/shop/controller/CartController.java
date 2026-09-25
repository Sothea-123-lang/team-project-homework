package com.shop.controller;

import com.shop.model.Cart;
import com.shop.model.CartItem;
import com.shop.model.Product;
import com.shop.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/cart", "/addToCart"})
public class CartController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                Long productId = Long.parseLong(productIdStr);

                // Default to "add" if action parameter is omitted (like in your JSP)
                if (action == null || "add".equalsIgnoreCase(action)) {
                    Product product = productService.getProductById(productId);
                    if (product != null) {
                        CartItem item = new CartItem();
                        item.setProduct(product);
                        item.setQuantity(1);
                        cart.addItem(item);
                    }
                    
                    // Update total count for header badge
                    session.setAttribute("cartCount", cart.getTotalQuantity());
                    response.sendRedirect(request.getContextPath() + "/products");
                    return;

                } else if ("remove".equalsIgnoreCase(action)) {
                    cart.getItems().removeIf(item -> item.getProduct().getId().equals(productId));
                    
                    // Update total count after removal
                    session.setAttribute("cartCount", cart.getTotalQuantity());
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/products");
    }
}