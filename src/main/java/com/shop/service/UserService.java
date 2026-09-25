package com.shop.service;

import com.shop.dao.UserDao;
import com.shop.model.User;

public class UserService {
    private UserDao userDao = new UserDao();

    // Fetch user details by email
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    // Authenticate user login credentials
    public User login(String email, String password) {
        User user = userDao.findByEmail(email);
        
        if (user == null) {
            System.out.println("DEBUG: User not found in DB for email: " + email);
            return null;
        }
        
        if (!user.getPassword().equals(password)) {
            System.out.println("DEBUG: Password mismatch! DB Pass: " + user.getPassword() + " | Input Pass: " + password);
            return null;
        }

        System.out.println("DEBUG: Login successful for: " + user.getEmail());
        return user;
    }

    // Save a new user to the database
    public void register(User user) {
        userDao.save(user);
    }
}