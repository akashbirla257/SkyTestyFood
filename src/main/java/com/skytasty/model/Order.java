package com.skytasty.model;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = true)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "restaurant_id")
    private Restaurant restaurant;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @Fetch(FetchMode.SELECT)
    private Set<OrderItem> orderItems = new HashSet<>();

    private double totalAmount;
    private String status; // e.g., "pending", "confirmed", "delivered"
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderDate;

    // Default constructor required by JPA
    public Order() {}

    // Parameterized constructor (optional)
    public Order(User user, Restaurant restaurant, Set<OrderItem> orderItems, double totalAmount, String status) {
        this.user = user;
        this.restaurant = restaurant;
        this.orderItems = orderItems;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderDate = new Date();
    }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Restaurant getRestaurant() { return restaurant; }
    public void setRestaurant(Restaurant restaurant) { this.restaurant = restaurant; }
    public Set<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItemsList) { 
        this.orderItems.clear(); 
        if (orderItemsList != null) {
            this.orderItems.addAll(new HashSet<>(orderItemsList)); // Convert List to Set
        }
    }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
}