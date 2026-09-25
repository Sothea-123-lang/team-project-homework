package com.shop.dao;

import java.util.List;
import com.shop.model.Product;
import jakarta.persistence.EntityManager;

public class ProductDao {

    public void save(Product product) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(product);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void update(Product product) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(product);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            Product product = em.find(Product.class, id);
            if (product != null) {
                em.remove(product);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Product findById(Long id) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    public List<Product> findAll() {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p JOIN FETCH p.category", Product.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> searchByName(String keyword) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p JOIN FETCH p.category WHERE LOWER(p.name) LIKE LOWER(:keyword)", Product.class)
                     .setParameter("keyword", "%" + keyword + "%")
                     .getResultList();
        } finally {
            em.close();
        }
    }

    // ✅ បន្ថែម Method នេះដើម្បី Filter ទំនិញតាម Category ID
    public List<Product> findByCategoryId(Long categoryId) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p JOIN FETCH p.category WHERE p.category.id = :categoryId", Product.class)
                     .setParameter("categoryId", categoryId)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}