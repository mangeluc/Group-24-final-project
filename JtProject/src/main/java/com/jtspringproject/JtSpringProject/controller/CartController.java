package com.jtspringproject.JtSpringProject.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



@Controller
public class CartController {
	public static final String databaseURL = UserController.databaseURL;
	public static final String databaseUser = UserController.databaseUser;
	public static final String databasePassword = UserController.databasePassword;
    
    @PostMapping("/add-to-cart")
    @ResponseBody
    public ResponseEntity<String> addToCart(@RequestParam("productId") Long productId, HttpSession session) {
      try {
        // Get the current user's ID from the session
        int userId = (int) session.getAttribute("userId");
        System.out.println(111);

        // Establish a database connection
        Connection conn = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);

        // Prepare the SQL query to add the product to the cart
        String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, 1)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.setLong(2, productId);

        // Execute the SQL query
        statement.executeUpdate();

        // Close the statement and database connection
        statement.close();
        conn.close();

        return new ResponseEntity<>("Product added to cart", HttpStatus.OK);
      } catch (Exception e) {
        return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
      }
    }
}