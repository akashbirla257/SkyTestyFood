package com.skytasty.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.skytasty.model.FoodItem;
import com.skytasty.model.Restaurant;

@Repository
public class RestaurantDao {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    @Transactional
    public void saveRestaurant(Restaurant restaurant) {
        hibernateTemplate.saveOrUpdate(restaurant);
        System.out.println("Saved/Updated restaurant: " + restaurant);
    }

    public Restaurant getRestaurantById(int id) {
        Restaurant restaurant = hibernateTemplate.get(Restaurant.class, id);
        if (restaurant != null) {
            System.out.println("Retrieved restaurant by ID " + id + ": " + restaurant);
        } else {
            System.out.println("No restaurant found for ID " + id);
        }
        return restaurant;
    }

    @Transactional(readOnly = true)
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = (List<Restaurant>) hibernateTemplate.find("FROM Restaurant");
        System.out.println("Retrieved all restaurants: " + restaurants);
        return restaurants;
    }

    @Transactional(readOnly = true)
    public List<Restaurant> searchRestaurantsByCuisine(String cuisine) {
        List<Restaurant> restaurants = (List<Restaurant>) hibernateTemplate.findByNamedParam(
            "FROM Restaurant WHERE cuisine LIKE :cuisine", "cuisine", "%" + cuisine + "%");
        System.out.println("Searched restaurants by cuisine '" + cuisine + "': " + restaurants);
        return restaurants;
    }

    @Transactional
    public void deleteRestaurant(int id) {
        Restaurant restaurant = getRestaurantById(id);
        if (restaurant != null) {
            try {
                hibernateTemplate.delete(restaurant);
                System.out.println("Deleted restaurant with ID " + id);
            } catch (Exception e) {
                System.err.println("Error deleting restaurant with ID " + id + ": " + e.getMessage());
                throw e;
            }
        } else {
            System.out.println("Restaurant with ID " + id + " not found, nothing to delete.");
        }
    }

    @Transactional(readOnly = true)
    public List<FoodItem> getFoodItemsByRestaurantId(int restaurantId) {
        List<FoodItem> foodItems = (List<FoodItem>) hibernateTemplate.findByNamedParam(
            "FROM FoodItem WHERE restaurant.restaurantId = :restaurantId", 
            "restaurantId", restaurantId
        );
        System.out.println("Fetched food items for restaurantId " + restaurantId + ": " + foodItems);
        return foodItems;
    }

    public FoodItem getFoodItemById(int foodId) {
        FoodItem foodItem = hibernateTemplate.get(FoodItem.class, foodId);
        if (foodItem != null) {
            System.out.println("Retrieved food item by ID " + foodId + ": " + foodItem);
        } else {
            System.out.println("No food item found for ID " + foodId);
        }
        return foodItem;
    }

    @Transactional
    public void deleteFoodItem(int foodId) {
        FoodItem foodItem = getFoodItemById(foodId);
        if (foodItem != null) {
            hibernateTemplate.delete(foodItem);
            System.out.println("Deleted food item with ID " + foodId);
        }
    }

    @Transactional
    public void saveFoodItem(FoodItem foodItem) {
        if (foodItem.getRestaurant() == null || foodItem.getRestaurant().getRestaurantId() <= 0) {
            throw new IllegalArgumentException("FoodItem must have a valid restaurant association.");
        }
        hibernateTemplate.saveOrUpdate(foodItem);
        System.out.println("Saved/Updated food item: " + foodItem);
    }
}