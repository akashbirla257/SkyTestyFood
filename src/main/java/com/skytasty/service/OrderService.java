package com.skytasty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.skytasty.dao.OrderDao;
import com.skytasty.model.Order;

@Service
@Transactional
public class OrderService {
	@Autowired
private OrderDao orderDao;
	
	public List<Order> getAllOrders(){
		return orderDao.getAllOrders();
	}
	public Order getOrderById(int orderId) {
		return orderDao.getOrderById(orderId);
	}
	public void saveOrder(Order order) {
		orderDao.saveOrder(order);
	}
	public void deleteOrder(int orderId) {
		orderDao.deleteOrder(orderId);
	}
	public List<Order> getOrdersByStatus(String status) {
        return orderDao.getOrdersByStatus(status);
    }
	public List<Order>getOrdersByUserId(int userId){
		return orderDao.getOrdersByUserId(userId);
	}
   
  
}
