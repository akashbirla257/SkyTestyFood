package com.skytasty.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.skytasty.model.FoodItem;
import com.skytasty.model.Restaurant;
import com.skytasty.service.RestaurantService;

@Controller
public class RestaurantController {
    @Autowired
    private RestaurantService restaurantService;

    @GetMapping("/restaurants")
    public String showRestaurants(Model model, @RequestParam(required = false) String cuisine) {
        List<Restaurant> restaurants = (cuisine != null) ?
                restaurantService.searchRestaurantsByCuisine(cuisine) :
                restaurantService.getAllRestaurants();
        model.addAttribute("restaurants", restaurants);
        return "restaurants";
    }

    @GetMapping("/restaurants/{id}/menu")
    public String getMenu(@PathVariable int id, Model model) {
        Restaurant restaurant = restaurantService.getRestaurantById(id);
        if (restaurant != null) {
            List<FoodItem> foodItems = restaurantService.getFoodItemsByRestaurantId(id);
            model.addAttribute("restaurant", restaurant);
            model.addAttribute("foodItems", foodItems);
        } else {
            model.addAttribute("error", "Restaurant not found!");
            return "error";
        }
        return "menu";
    }

    @GetMapping("/admin")
    @Transactional(readOnly = true)
    public String adminDashboard(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "adminLogin";
        }
        List<Restaurant> restaurants = restaurantService.getAllRestaurants();
        model.addAttribute("restaurants", restaurants);
        model.addAttribute("message", model.containsAttribute("message") ? model.asMap().get("message") : null);
        return "adminDashboard";
    }

    @PostMapping("/admin/login")
    public String adminLoginSubmit(@RequestParam String username, @RequestParam String password, Model model, HttpSession session) {
        if ("admin".equals(username) && "admin123".equals(password)) {
            session.setAttribute("userRole", "ADMIN");
            model.addAttribute("restaurants", restaurantService.getAllRestaurants());
            return "adminDashboard";
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "adminLogin";
        }
    }

    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin";
    }

    @GetMapping("/admin/addRestaurant")
    public String showAddRestaurantForm(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        return "addRestaurant";
    }

    @PostMapping("/admin/addRestaurant")
    @Transactional
    public String addRestaurant(@RequestParam String name, @RequestParam String address, @RequestParam String cuisine, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        Restaurant restaurant = new Restaurant();
        restaurant.setName(name);
        restaurant.setAddress(address);
        restaurant.setCuisine(cuisine);
        restaurantService.saveRestaurant(restaurant);
        model.addAttribute("message", "Restaurant added successfully!");
        return "redirect:/admin";
    }

    @GetMapping("/admin/updateRestaurant/{restaurantId}")
    public String showUpdateRestaurantForm(@PathVariable int restaurantId, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        if (restaurant == null) {
            model.addAttribute("message", "Restaurant not found!");
            return "redirect:/admin";
        }
        model.addAttribute("restaurant", restaurant);
        return "updateRestaurant";
    }

    @PostMapping("/admin/updateRestaurant")
    @Transactional
    public String updateRestaurant(@RequestParam int restaurantId, @RequestParam String name, @RequestParam String address, @RequestParam String cuisine, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        if (restaurant != null) {
            restaurant.setName(name);
            restaurant.setAddress(address);
            restaurant.setCuisine(cuisine);
            restaurantService.saveRestaurant(restaurant);
            model.addAttribute("message", "Restaurant updated successfully!");
        } else {
            model.addAttribute("message", "Restaurant not found!");
        }
        return "redirect:/admin";
    }

    @GetMapping("/admin/deleteRestaurant/{restaurantId}")
    @Transactional
    public String deleteRestaurant(@PathVariable int restaurantId, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/admin";
        }
        try {
            restaurantService.deleteRestaurant(restaurantId);
            model.addAttribute("message", "Restaurant deleted successfully!");
        } catch (IllegalArgumentException e) {
            model.addAttribute("message", e.getMessage());
        } catch (Exception e) {
            model.addAttribute("message", "Error deleting restaurant: " + e.getMessage());
        }
        return "redirect:/admin";
    }

    @GetMapping("/admin/addFoodItem")
    public String showAddFoodItemForm(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        model.addAttribute("restaurants", restaurantService.getAllRestaurants());
        return "addFoodItem";
    }

    @PostMapping("/admin/addFoodItem")
    @Transactional
    public String addFoodItem(@RequestParam int restaurantId, @RequestParam String name, @RequestParam double price,
                             @RequestParam String description, @RequestParam("image") MultipartFile image, Model model,
                             HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";

        if (!image.isEmpty()) {
            try {
                byte[] data = image.getBytes();
                String uploadDir = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images" + File.separator + "foods";
                String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
                File dest = new File(uploadDir, fileName);

                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }

                try (FileOutputStream fos = new FileOutputStream(dest)) {
                    fos.write(data);
                }

                FoodItem foodItem = new FoodItem();
                foodItem.setName(name);
                foodItem.setPrice(price);
                foodItem.setDescription(description);
                foodItem.setImagePath("/resources/images/foods/" + fileName);

                Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
                if (restaurant != null) {
                    foodItem.setRestaurant(restaurant);
                    restaurant.getFoodItems().add(foodItem);
                    restaurantService.saveRestaurant(restaurant);
                    model.addAttribute("message", "Food item added successfully!");
                } else {
                    model.addAttribute("message", "Restaurant not found!");
                }
            } catch (Exception e) {
                model.addAttribute("message", "Error uploading image: " + e.getMessage());
            }
        } else {
            model.addAttribute("message", "Please upload an image!");
        }
        return "redirect:/admin/manageRestaurant/" + restaurantId;
    }

    @GetMapping("/admin/editFoodItem/{foodId}")
    public String showEditFoodItemForm(@PathVariable int foodId, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        FoodItem foodItem = restaurantService.getFoodItemById(foodId);
        if (foodItem != null) {
            model.addAttribute("foodItem", foodItem);
            model.addAttribute("restaurants", restaurantService.getAllRestaurants());
        } else {
            model.addAttribute("message", "Food item not found!");
            return "redirect:/admin";
        }
        return "editFoodItem";
    }

    @GetMapping("/admin/deleteFoodItem/{foodId}")
    @Transactional
    public String deleteFoodItem(@PathVariable int foodId, Model model, HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        FoodItem foodItem = restaurantService.getFoodItemById(foodId);
        if (foodItem != null) {
            Restaurant restaurant = foodItem.getRestaurant();
            if (restaurant != null) {
                restaurant.getFoodItems().remove(foodItem);
                restaurantService.saveRestaurant(restaurant);
            }
            File imageFile = new File(request.getServletContext().getRealPath("/") + foodItem.getImagePath());
            if (imageFile.exists()) imageFile.delete();
            restaurantService.deleteFoodItem(foodId);
            model.addAttribute("message", "Food item deleted successfully!");
        } else {
            model.addAttribute("message", "Food item not found!");
        }
        return "redirect:/admin/manageRestaurant/" + (foodItem != null ? foodItem.getRestaurant().getRestaurantId() : 0);
    }

    @PostMapping("/admin/updateFoodItem")
    @Transactional
    public String updateFoodItem(@RequestParam int foodId, @RequestParam int restaurantId, @RequestParam String name,
                                @RequestParam double price, @RequestParam String description,
                                @RequestParam(value = "image", required = false) MultipartFile image, Model model,
                                HttpServletRequest request, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        FoodItem foodItem = restaurantService.getFoodItemById(foodId);
        if (foodItem != null) {
            foodItem.setName(name);
            foodItem.setPrice(price);
            foodItem.setDescription(description);
            if (image != null && !image.isEmpty()) {
                try {
                    byte[] data = image.getBytes();
                    String uploadDir = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images" + File.separator + "foods";
                    String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
                    File dest = new File(uploadDir, fileName);

                    if (!dest.getParentFile().exists()) {
                        dest.getParentFile().mkdirs();
                    }

                    try (FileOutputStream fos = new FileOutputStream(dest)) {
                        fos.write(data);
                    }

                    File oldImage = new File(request.getServletContext().getRealPath("/") + foodItem.getImagePath());
                    if (oldImage.exists()) oldImage.delete();
                    foodItem.setImagePath("/resources/images/foods/" + fileName);
                } catch (Exception e) {
                    model.addAttribute("message", "Error updating image: " + e.getMessage());
                }
            }
            foodItem.setRestaurant(restaurantService.getRestaurantById(restaurantId));
            restaurantService.saveFoodItem(foodItem);
            model.addAttribute("message", "Food item updated successfully!");
        } else {
            model.addAttribute("message", "Food item not found!");
        }
        return "redirect:/admin/manageRestaurant/" + restaurantId;
    }

    @GetMapping("/admin/searchRestaurant")
    @Transactional(readOnly = true)
    public String showSearchRestaurantForm(@RequestParam(required = false) String searchTerm, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        List<Restaurant> restaurants;
        if (searchTerm != null && !searchTerm.isEmpty()) {
            restaurants = restaurantService.searchRestaurantsByCuisine(searchTerm);
            if (restaurants.isEmpty()) {
                restaurants = restaurantService.getAllRestaurants();
                model.addAttribute("message", "No restaurants found for search term: " + searchTerm);
            }
        } else {
            restaurants = restaurantService.getAllRestaurants();
        }
        model.addAttribute("restaurants", restaurants);
        return "searchRestaurant";
    }

    @GetMapping("/admin/manageRestaurant/{restaurantId}")
    @Transactional(readOnly = true)
    public String manageRestaurant(@PathVariable int restaurantId, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin";
        Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
        if (restaurant != null) {
            List<FoodItem> foodItems = restaurantService.getFoodItemsByRestaurantId(restaurantId);
            model.addAttribute("restaurant", restaurant);
            model.addAttribute("foodItems", foodItems);
            model.addAttribute("restaurants", restaurantService.getAllRestaurants());
        } else {
            model.addAttribute("message", "Restaurant not found!");
            return "redirect:/admin";
        }
        return "manageRestaurant";
    }

    private boolean isAdmin(HttpSession session) {
        return session != null && "ADMIN".equals(session.getAttribute("userRole"));
    }
}