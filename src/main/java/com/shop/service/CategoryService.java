package com.shop.service;

import com.shop.dao.CategoryDao;
import com.shop.model.Category;
import java.util.List;

public class CategoryService {
    private CategoryDao categoryDao = new CategoryDao();

    // ទាញយក Category ទាំងអស់
    public List<Category> getAllCategories() {
        return categoryDao.findAll();
    }

    // ទាញយក Category តាម ID
    public Category getCategoryById(Long id) {
        return categoryDao.findById(id);
    }

    // បន្ថែម Category ថ្មីដោយប្រើ Object
    public void addCategory(Category category) {
        categoryDao.save(category);
    }

    // [បន្ថែមត្រង់នេះ] Overloaded Method៖ បន្ថែម Category ថ្មីដោយប្រើ String Name ដោយផ្ទាល់
    public void addCategory(String name) {
        Category category = new Category();
        category.setName(name);
        categoryDao.save(category);
    }
}