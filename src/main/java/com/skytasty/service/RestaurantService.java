package com.skytasty.service;

import java.util.List;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.skytasty.dao.RestaurantDao;
import com.skytasty.model.FoodItem;
import com.skytasty.model.Restaurant;

@Service
public class RestaurantService {
    @Autowired
    private RestaurantDao restaurantDao;

    @Transactional(readOnly = true)
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = restaurantDao.getAllRestaurants();
        for (Restaurant restaurant : restaurants) {
            Hibernate.initialize(restaurant.getFoodItems());
        }
        System.out.println("Service returned all restaurants with initialized food items: " + restaurants);
        return restaurants;
    }

    @Transactional(readOnly = true)
    public List<Restaurant> searchRestaurantsByCuisine(String cuisine) {
        List<Restaurant> restaurants = restaurantDao.searchRestaurantsByCuisine(cuisine);
        System.out.println("Service returned searched restaurants by cuisine '" + cuisine + "': " + restaurants);
        return restaurants;
    }

    @Transactional
    public void saveRestaurant(Restaurant restaurant) {
        if (restaurant.getRestaurantId() == 0) {
            restaurantDao.saveRestaurant(restaurant);
        } else {
            Restaurant existing = restaurantDao.getRestaurantById(restaurant.getRestaurantId());
            if (existing != null) {
                restaurantDao.saveRestaurant(restaurant);
            } else {
                throw new IllegalArgumentException("Restaurant with ID " + restaurant.getRestaurantId() + " not found for update.");
            }
        }
        System.out.println("Service saved/updated restaurant: " + restaurant);
    }

    @Transactional
    public void deleteRestaurant(int restaurantId) {
        Restaurant restaurant = getRestaurantById(restaurantId);
        if (restaurant != null) {
            restaurantDao.deleteRestaurant(restaurantId);
            System.out.println("Service deleted restaurant with ID " + restaurantId);
        } else {
            throw new IllegalArgumentException("Restaurant with ID " + restaurantId + " not found.");
        }
    }

    @Transactional(readOnly = true)
    public List<FoodItem> getFoodItemsByRestaurantId(int restaurantId) {
        List<FoodItem> foodItems = restaurantDao.getFoodItemsByRestaurantId(restaurantId);
        System.out.println("Service returned food items for restaurantId " + restaurantId + ": " + foodItems);
        return foodItems;
    }

    @Transactional(readOnly = true)
    public Restaurant getRestaurantById(int restaurantId) {
        Restaurant restaurant = restaurantDao.getRestaurantById(restaurantId);
        if (restaurant != null) {
            Hibernate.initialize(restaurant.getFoodItems());
            System.out.println("Service retrieved restaurant by ID " + restaurantId + " with initialized food items: " + restaurant);
        } else {
            System.out.println("Service found no restaurant for ID " + restaurantId);
        }
        return restaurant;
    }

    @Transactional(readOnly = true)
    public FoodItem getFoodItemById(int foodId) {
        FoodItem foodItem = restaurantDao.getFoodItemById(foodId);
        if (foodItem != null) {
            System.out.println("Service retrieved food item by ID " + foodId + ": " + foodItem);
        }
        return foodItem;
    }

    @Transactional
    public void deleteFoodItem(int foodId) {
        FoodItem foodItem = getFoodItemById(foodId);
        if (foodItem != null) {
            Restaurant restaurant = foodItem.getRestaurant();
            if (restaurant != null) {
                restaurant.getFoodItems().remove(foodItem);
                restaurantDao.saveRestaurant(restaurant);
                System.out.println("Service removed food item from restaurant and saved: " + restaurant);
            }
            restaurantDao.deleteFoodItem(foodId);
            System.out.println("Service deleted food item with ID " + foodId);
        }
    }

    @Transactional
    public void saveFoodItem(FoodItem foodItem) {
        if (foodItem.getRestaurant() == null || foodItem.getRestaurant().getRestaurantId() <= 0) {
            throw new IllegalArgumentException("FoodItem must have a valid restaurant association.");
        }
        foodItem.setImagePath(foodItem.getImagePath() != null && !foodItem.getImagePath().isEmpty() 
            ? foodItem.getImagePath() : "/resources/images/foods/default.jpg");
        Restaurant restaurant = restaurantDao.getRestaurantById(foodItem.getRestaurant().getRestaurantId());
        if (restaurant != null) {
            restaurant.addFoodItem(foodItem); // Maintains bidirectional relationship
            restaurantDao.saveRestaurant(restaurant); // Cascades to FoodItem
        } else {
            throw new IllegalArgumentException("Restaurant not found for ID " + foodItem.getRestaurant().getRestaurantId());
        }
        System.out.println("Service saved food item: " + foodItem);
    }
  
}