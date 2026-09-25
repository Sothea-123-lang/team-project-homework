package com.shop.service;

import com.shop.dao.ProductDao;
import com.shop.model.Product;
import java.util.List;

public class ProductService {
    private ProductDao productDao = new ProductDao();

    public List<Product> getAllProducts() {
        return productDao.findAll();
    }

    public Product getProductById(Long id) {
        return productDao.findById(id);
    }

    public void addProduct(Product product) {
        productDao.save(product);
    }

    public void deleteProduct(Long id) {
        productDao.delete(id);
    }

    // ✅ ១. បន្ថែម Method នេះដើម្បីបាត់បន្ទាត់ក្រហម searchProducts
    public List<Product> searchProducts(String keyword) {
        return productDao.searchByName(keyword);
    }

    // ✅ ២. បន្ថែម Method នេះដើម្បីបាត់បន្ទាត់ក្រហម getProductsByCategoryId
    public List<Product> getProductsByCategoryId(Long categoryId) {
        return productDao.findByCategoryId(categoryId);
    }
}