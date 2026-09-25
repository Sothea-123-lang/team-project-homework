package com.shop.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private BigDecimal price;
    private int stockQty;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    public Product() {}

    // ==========================================
    // Primary Getters & Setters
    // ==========================================
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public int getStockQty() { return stockQty; }
    public void setStockQty(int stockQty) { this.stockQty = stockQty; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    // ==========================================
    // Compatibility Methods (ដោះស្រាយ Error គ្រប់ File)
    // ==========================================

    // 1. សម្រាប់ដោះស្រាយ Error setPrice(double) និង getPrice() ជា double
    public void setPrice(double price) {
        this.price = BigDecimal.valueOf(price);
    }

    public double getPriceAsDouble() {
        return price != null ? price.doubleValue() : 0.0;
    }

    // 2. សម្រាប់ដោះស្រាយ Error setCategoryId(int/Long) និង getCategoryId()
    public void setCategoryId(Long categoryId) {
        if (this.category == null) {
            this.category = new Category();
        }
        this.category.setId(categoryId);
    }

    public void setCategoryId(int categoryId) {
        setCategoryId((long) categoryId);
    }

    public Long getCategoryId() {
        return (this.category != null) ? this.category.getId() : null;
    }
}