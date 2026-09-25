package com.shop.dao;

import java.util.List;

import com.shop.model.Order;

import jakarta.persistence.EntityManager;

public class OrderDao {

    public void save(Order order) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(order);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Order findById(Long id) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Order.class, id);
        } finally {
            em.close();
        }
    }

    public List<Order> findByUserId(Long userId) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            // LEFT JOIN FETCH o.items eagerly loads the order items before closing the EntityManager session
            return em.createQuery("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.items WHERE o.user.id = :userId ORDER BY o.id DESC", Order.class)
                     .setParameter("userId", userId)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order> findAll() {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            // LEFT JOIN FETCH o.items eagerly loads the order items for the admin order view
            return em.createQuery("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.items ORDER BY o.id DESC", Order.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}