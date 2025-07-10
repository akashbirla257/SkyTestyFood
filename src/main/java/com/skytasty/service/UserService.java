package com.skytasty.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.skytasty.dao.UserDao;
import com.skytasty.model.User;
import com.skytasty.model.Role;

import java.util.List;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserDao userDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Transactional
    public void ensureDefaultRole() {
        Role role = userDao.getRoleByName("USER");
        if (role == null) {
            role = new Role("USER");
            userDao.saveRole(role);
        }
    }

    @Transactional
    public void registerUser(String username, String password, String email) {
        ensureDefaultRole(); // Ensure 'USER' role exists
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password)); // Encode password
        user.setEmail(email);

        Role role = userDao.getRoleByName("USER");
        if (role == null) {
            throw new RuntimeException("Role 'USER' not found after ensuring default");
        }
        user.setRole(role);

        userDao.saveUser(user);
    }

    public User loginUser(String username, String password) {
        User user = userDao.getUserByUsername(username);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    @Transactional
    public void deleteUser(int id) {
        userDao.deleteUser(id);
    }

    @Transactional
    public void updateUser(User user) {
        userDao.saveUser(user);
    }
}