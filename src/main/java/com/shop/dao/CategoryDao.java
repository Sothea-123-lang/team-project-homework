package com.shop.dao;

import java.util.List;

import com.shop.model.Category;

import jakarta.persistence.EntityManager;

public class CategoryDao {
    
    public List<Category> findAll() {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Category findById(Long id) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

	public void save(Category category) {
		// TODO Auto-generated method stub
		
	}
}