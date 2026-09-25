package com.shop.model;

import java.math.BigDecimal;

public class AddToCart {
    
    private Product product;
    private int quantity;

    public AddToCart() {
    }

    public AddToCart(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    /**
     * Calculates the subtotal for this cart line item 
     * (Price * Qty) as seen in the shopping cart mockup.
     */
    public BigDecimal getSubtotal() {
        if (product != null && product.getPrice() != null) {
            return product.getPrice().multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}