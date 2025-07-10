package com.skytasty.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skytasty.model.User;
import com.skytasty.service.UserService;

@Controller
public class UserController {  
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public ModelAndView showRegisterForm() {
        return new ModelAndView("register", "user", new User());
    }

    @PostMapping("/register")
    public ModelAndView registerUser(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("email") String email) {
        try {
            userService.registerUser(username, password, email);
            return new ModelAndView("redirect:/login");
        } catch (Exception e) {
            ModelAndView modelAndView = new ModelAndView("register");
            modelAndView.addObject("error", "Registration failed: " + e.getMessage());
            modelAndView.addObject("user", new User());
            return modelAndView;
        }
    } 

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String username, @RequestParam String password, Model model, HttpSession session) {
        User user = userService.loginUser(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole().getName());
            return "redirect:/restaurants";
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}