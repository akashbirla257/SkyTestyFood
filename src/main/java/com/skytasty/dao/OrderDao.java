package com.skytasty.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.skytasty.model.Order;
import com.skytasty.model.OrderItem;

@Repository
public class OrderDao {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    @Transactional
    public void saveOrder(Order order) {
        this.hibernateTemplate.saveOrUpdate(order); // Cascade will handle OrderItems
    }

    @Transactional
    public void deleteOrder(int orderId) {
        Order order = this.hibernateTemplate.get(Order.class, orderId);
        if (order != null) {
            this.hibernateTemplate.delete(order);
        }
    }

    @Transactional
    public Order getOrderById(int orderId) {
        return this.hibernateTemplate.get(Order.class, orderId);
    }

    @SuppressWarnings("unchecked")
    @Transactional
    public List<Order> getAllOrders() {
        return (List<Order>) this.hibernateTemplate.find("from Order");
    }

    @SuppressWarnings("unchecked")
    @Transactional
    public List<Order> getOrdersByStatus(String status) {
        return (List<Order>) hibernateTemplate.find("from Order where status = ?", status);
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByUserId(int userId) {
        String hql = "FROM Order o JOIN FETCH o.orderItems JOIN FETCH o.restaurant WHERE o.user.userId = :userId ORDER BY o.orderDate DESC";
        return (List<Order>) hibernateTemplate.findByNamedParam(hql, "userId", userId);
    }
}