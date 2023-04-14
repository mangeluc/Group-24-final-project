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



@RestController
public class CartController {

    public static final String databaseURL = UserController.databaseURL;
    public static final String databaseUser = UserController.databaseUser;
    public static final String databasePassword = UserController.databasePassword;

    @PostMapping("/cart/update")
    @ResponseBody
    public ResponseEntity<String> addToCart(@RequestParam("productId") int productId, HttpSession session) {
        try {
            // Get the current user's ID from the session
            int userId = (int) session.getAttribute("userId");
            System.out.println(111);

            // Establish a database connection
            Connection conn = DriverManager.getConnection(databaseURL, databaseUser, databasePassword);

            // Check if the product already exists in the cart
            String checkSql = "SELECT * FROM cart WHERE user_id = ? AND product_id = ?";
            PreparedStatement checkStatement = conn.prepareStatement(checkSql);
            checkStatement.setInt(1, userId);
            checkStatement.setLong(2, productId);
            ResultSet resultSet = checkStatement.executeQuery();

            if (resultSet.next()) {
                // If the product exists in the cart, increment the quantity by 1
                String updateSql = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = ?";
                PreparedStatement updateStatement = conn.prepareStatement(updateSql);
                updateStatement.setInt(1, userId);
                updateStatement.setLong(2, productId);
                updateStatement.executeUpdate();
                updateStatement.close();
            } else {
                // If the product does not exist in the cart, add it with quantity 1
                String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, 1)";
                PreparedStatement insertStatement = conn.prepareStatement(insertSql);
                insertStatement.setInt(1, userId);
                insertStatement.setLong(2, productId);
                insertStatement.executeUpdate();
                insertStatement.close();
            }

            // Close the result set, statements, and database connection
            resultSet.close();
            checkStatement.close();
            conn.close();

            return new ResponseEntity<>("Product added to cart", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
