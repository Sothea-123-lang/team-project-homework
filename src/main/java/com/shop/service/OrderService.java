package com.shop.service;

import com.shop.dao.OrderDao;
import com.shop.dao.ProductDao;
import com.shop.model.Cart;
import com.shop.model.CartItem;
import com.shop.model.Order;
import com.shop.model.OrderItem;
import com.shop.model.Product;
import com.shop.model.User;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

public class OrderService {
    private OrderDao orderDao = new OrderDao();
    private ProductDao productDao = new ProductDao();

    public Order processCheckout(User user, Cart cart) throws Exception {
        if (cart == null || cart.getItems().isEmpty()) {
            throw new Exception("Cart is empty");
        }

        Order order = new Order();
        order.setUser(user);
        
        // កែប្រែ៖ ប្រើ user.getName() ដែលជា method មានស្រាប់ក្នុង User.java
        String name = user.getName();
        order.setCustomerName(name != null ? name : "Customer #" + user.getId());

        order.setStatus("PAID");
        BigDecimal totalAmount = BigDecimal.ZERO;
        // Loop through the cart to create order items and deduct stock
        for (CartItem cartItem : cart.getItems()) {
            Product product = productDao.findById(cartItem.getProduct().getId());
            
            if (product.getStockQty() < cartItem.getQuantity()) {
                throw new Exception("Insufficient stock for product: " + product.getName());
            }

            // Deduct inventory stock
            product.setStockQty(product.getStockQty() - cartItem.getQuantity());
            productDao.update(product);

            // Create the finalized OrderItem
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(product);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPriceAtPurchase(product.getPrice());

            order.addItem(orderItem);
            
            // Add to total
            BigDecimal itemTotal = product.getPrice().multiply(new BigDecimal(cartItem.getQuantity()));
            totalAmount = totalAmount.add(itemTotal);
        }

        order.setTotalAmount(totalAmount);
        
        // Save the completed transaction to the database
        orderDao.save(order);

        return order;
    }

    // Fetch order history for a specific customer
    public List<Order> getOrdersByUserId(Object userId) {
        if (userId == null) {
            return Collections.emptyList();
        }
        
        try {
            // Convert to Long dynamically in case user.getId() returns Integer or Long
            Long parsedId = Long.parseLong(userId.toString());
            return orderDao.findByUserId(parsedId);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    // Fetch all orders for admin view
    public List<Order> getAllOrders() {
        try {
            return orderDao.findAll();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}