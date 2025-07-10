package com.skytasty.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skytasty.model.FoodItem;
import com.skytasty.model.Order;
import com.skytasty.model.OrderItem;
import com.skytasty.model.Restaurant;
import com.skytasty.model.User;
import com.skytasty.service.OrderService;
import com.skytasty.service.RestaurantService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/order")
public class OrderController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;
    @Autowired
    private RestaurantService restaurantService;

    @GetMapping("/cart")
    public String showCart(Model model, HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<FoodItem, Integer> cartItems = (Map<FoodItem, Integer>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new HashMap<>();
            session.setAttribute("cart", cartItems);
        }
        double totalAmount = cartItems.entrySet().stream()
                .mapToDouble(entry -> entry.getKey().getPrice() * entry.getValue())
                .sum();
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        return "cart";
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam int foodId, @RequestParam int quantity, Model model, HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("message", "Please log in to add items to cart!");
            return "redirect:/login";
        }
        FoodItem foodItem = restaurantService.getFoodItemById(foodId);
        if (foodItem == null) {
            redirectAttributes.addFlashAttribute("message", "Item not found!");
            logger.warn("FoodItem with foodId {} not found", foodId);
            return "redirect:/order/cart";
        }
        if (quantity < 0) quantity = 0;
        @SuppressWarnings("unchecked")
        Map<FoodItem, Integer> cartItems = (Map<FoodItem, Integer>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new HashMap<>();
            session.setAttribute("cart", cartItems);
        }
        cartItems.put(foodItem, cartItems.getOrDefault(foodItem, 0) + quantity);
        session.setAttribute("cart", cartItems);
        logger.info("Added to cart: {} x{}", foodItem.getName(), quantity);
        redirectAttributes.addFlashAttribute("message", "Item added to cart!");
        return "redirect:/order/cart";
    }

    @PostMapping("/cart/remove")
    public String removeFromCart(@RequestParam int foodId, Model model, HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        FoodItem foodItem = restaurantService.getFoodItemById(foodId);
        if (foodItem != null) {
            @SuppressWarnings("unchecked")
            Map<FoodItem, Integer> cartItems = (Map<FoodItem, Integer>) session.getAttribute("cart");
            if (cartItems != null) {
                cartItems.entrySet().removeIf(entry -> entry.getKey().getFoodId() == foodId);
                logger.info("Removed from cart: {}", foodItem.getName());
                session.setAttribute("cart", cartItems);
            }
        } else {
            logger.warn("FoodItem with foodId {} not found", foodId);
        }
        return "redirect:/order/cart";
    }

    @PostMapping("/cart/update")
    public String updateCart(@RequestParam int foodId, @RequestParam int quantity, Model model, HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("message", "Please log in to update cart!");
            return "redirect:/login";
        }
        logger.info("Received update request: foodId={}, quantity={}", foodId, quantity);
        @SuppressWarnings("unchecked")
        Map<FoodItem, Integer> cartItems = (Map<FoodItem, Integer>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new HashMap<>();
            session.setAttribute("cart", cartItems);
        }
        if (quantity >= 0) {
            FoodItem foodItem = restaurantService.getFoodItemById(foodId);
            if (foodItem != null) {
                cartItems.entrySet().removeIf(entry -> entry.getKey().getFoodId() == foodId);
                if (quantity > 0) {
                    cartItems.put(foodItem, quantity);
                    logger.info("Updated cart: {} x{}", foodItem.getName(), quantity);
                    redirectAttributes.addFlashAttribute("message", "Cart updated successfully!");
                } else {
                    logger.info("Removed from cart: {}", foodItem.getName());
                    redirectAttributes.addFlashAttribute("message", "Item removed from cart!");
                }
                session.setAttribute("cart", cartItems);
            } else {
                logger.warn("FoodItem with foodId {} not found", foodId);
                redirectAttributes.addFlashAttribute("message", "Item not found!");
            }
        }
        return "redirect:/order/cart";
    }

    @PostMapping("/cart/checkout")
    public String checkout(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        logger.info("Checkout initiated. Session user: {}", session.getAttribute("user"));
        @SuppressWarnings("unchecked")
        Map<FoodItem, Integer> cartItems = (Map<FoodItem, Integer>) session.getAttribute("cart");
        if (cartItems == null || cartItems.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Cart is empty! Add items before checking out.");
            return "redirect:/order/cart";
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("message", "Please log in to place an order!");
            return "redirect:/login";
        }

        Order order = new Order();
        order.setOrderDate(new Date());
        order.setStatus("pending");
        order.setUser(user);

        Integer restaurantId = null;
        for (FoodItem item : cartItems.keySet()) {
            if (restaurantId == null) {
                restaurantId = item.getRestaurant().getRestaurantId();
            } else if (!restaurantId.equals(item.getRestaurant().getRestaurantId())) {
                redirectAttributes.addFlashAttribute("message", "Items from multiple restaurants cannot be ordered together!");
                return "redirect:/order/cart";
            }
        }
        if (restaurantId == null) {
            redirectAttributes.addFlashAttribute("message", "No valid items in cart!");
            return "redirect:/order/cart";
        }
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        if (restaurant == null) {
            redirectAttributes.addFlashAttribute("message", "Restaurant not found!");
            return "redirect:/order/cart";
        }
        order.setRestaurant(restaurant);

        double total = cartItems.entrySet().stream()
                .mapToDouble(entry -> entry.getKey().getPrice() * entry.getValue())
                .sum();
        order.setTotalAmount(total);

        List<OrderItem> orderItems = new ArrayList<>();
        for (Map.Entry<FoodItem, Integer> entry : cartItems.entrySet()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order); // Set back reference
            orderItem.setFoodItem(entry.getKey());
            orderItem.setQuantity(entry.getValue());
            orderItem.setPrice(entry.getKey().getPrice() * entry.getValue());
            orderItems.add(orderItem);
        }
        order.setOrderItems(orderItems); // Safe conversion handled by Order entity

        try {
            orderService.saveOrder(order);
            logger.info("Order saved successfully. Order ID: {}", order.getOrderId());
            session.removeAttribute("cart");
            redirectAttributes.addFlashAttribute("message", "Order placed successfully! Order ID: " + order.getOrderId());
        } catch (Exception e) {
            logger.error("Error during checkout: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("message", "Failed to place order. Please try again!");
            return "redirect:/order/cart";
        }
        return "redirect:/restaurants";
    }

    @GetMapping("/admin/orders")
    public String showOrders(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "adminOrders";
    }

    @GetMapping("/admin/updateOrder/{orderId}")
    public String showUpdateOrderForm(@PathVariable int orderId, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            model.addAttribute("message", "Order not found!");
            return "redirect:/order/admin/orders";
        }
        model.addAttribute("order", order);
        return "updateOrder";
    }

    @PostMapping("/admin/updateOrder")
    public String updateOrder(@RequestParam int orderId, @RequestParam String status, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        Order order = orderService.getOrderById(orderId);
        if (order != null) {
            order.setStatus(status);
            orderService.saveOrder(order);
            model.addAttribute("message", "Order status updated to " + status + "!");
        } else {
            model.addAttribute("message", "Order not found!");
        }
        return "redirect:/order/admin/orders";
    }

    @PostMapping("/admin/deleteOrder/{orderId}")
    public String deleteOrder(@PathVariable int orderId, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        orderService.deleteOrder(orderId);
        model.addAttribute("message", "Order deleted successfully!");
        return "redirect:/order/admin/orders";
    }

    @GetMapping("/history")
    public String showOrderHistory(Model model, HttpSession session) {
        logger.debug("Processing GET /order/history request");
        User user = (User) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("error", "Please log in to view your order history.");
            return "login";
        }
        List<Order> orders = orderService.getOrdersByUserId(user.getUserId());
        model.addAttribute("orders", orders);
        return "orderHistory";
    }
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        String userRole = (String) session.getAttribute("userRole");
        return "ADMIN".equals(userRole);
    }
}