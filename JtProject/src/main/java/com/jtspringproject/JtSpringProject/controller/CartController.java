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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



@Controller
public class CartController {

    public static final String databaseURL = UserController.databaseURL;
    public static final String databaseUser = UserController.databaseUser;
    public static final String databasePassword = UserController.databasePassword;
    
    
	@GetMapping("/ucart")
	public String usercart(Model model, HttpSession session) {
	    if (session.getAttribute("userId") == null) {
	        // Redirect to an appropriate page (e.g., login) if userId is not found in the session
	        return "redirect:/login";
	    }
		int userId = (int) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		return "ucart";
	}

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
    
    
    @PostMapping("/updateCart")
    public String updateCart(@RequestParam("userId") int userId,
                             @RequestParam("productId") int productId,
                             @RequestParam("quantity") int quantity) {
        try {
            Connection con = DriverManager.getConnection(UserController.databaseURL, UserController.databaseUser, UserController.databasePassword);
            PreparedStatement pstmt = null;

            if (quantity > 0) {
                pstmt = con.prepareStatement("UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?");
                pstmt.setInt(1, quantity);
                pstmt.setInt(2, userId);
                pstmt.setInt(3, productId);
            } else {
                pstmt = con.prepareStatement("DELETE FROM cart WHERE user_id = ? AND product_id = ?");
                pstmt.setInt(1, userId);
                pstmt.setInt(2, productId);
            }

            // Execute the update statement
            pstmt.executeUpdate();

            // Close the connection
            pstmt.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return "redirect:/error";
        }

        return "redirect:/ucart";
    }
    
    
    @GetMapping("/payment")
    public String payment(Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            // Redirect to an appropriate page (e.g., login) if userId is not found in the session
            return "redirect:/login";
        }
        int userId = (int) session.getAttribute("userId");
        model.addAttribute("userId", userId);
        return "buy";
    }
    
    
    @PostMapping("/checkout")
    public String checkout(@RequestParam("userId") int userId, RedirectAttributes redirectAttributes) {
        try (Connection connection = DriverManager.getConnection(databaseURL, databaseUser, databasePassword)) {
            // Get the cart items for the specified userId
            String cartItemsQuery = "SELECT c.product_id, c.quantity, p.quantity as product_quantity FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
            PreparedStatement cartItemsStatement = connection.prepareStatement(cartItemsQuery, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            cartItemsStatement.setInt(1, userId);
            ResultSet cartItemsResultSet = cartItemsStatement.executeQuery();

            // Check if any cart item has a quantity greater than the product quantity
            List<String> errors = new ArrayList<>();
            while (cartItemsResultSet.next()) {
                int productId = cartItemsResultSet.getInt("product_id");
                int cartQuantity = cartItemsResultSet.getInt("quantity");
                int productQuantity = cartItemsResultSet.getInt("product_quantity");

                if (cartQuantity > productQuantity) {
                    String errorMessage = "Checkout failed. Too many products selected. Product ID: " + productId;
                    errors.add(errorMessage);
                }
            }

            if (!errors.isEmpty()) {
                // Pass the error messages to the next page (i.e., the cart page)
                redirectAttributes.addFlashAttribute("errors", errors);
                return "redirect:/ucart";
            } else {
                // Update the product quantities in the database and delete cart items
                cartItemsResultSet.beforeFirst(); // Reset ResultSet cursor
                while (cartItemsResultSet.next()) {
                    int productId = cartItemsResultSet.getInt("product_id");
                    int cartQuantity = cartItemsResultSet.getInt("quantity");
                    int productQuantity = cartItemsResultSet.getInt("product_quantity");

                    // Update the product quantity
                    String updateProductQuantityQuery = "UPDATE products SET quantity = ? WHERE id = ?";
                    PreparedStatement updateProductQuantityStatement = connection.prepareStatement(updateProductQuantityQuery);
                    updateProductQuantityStatement.setInt(1, productQuantity - cartQuantity);
                    updateProductQuantityStatement.setInt(2, productId);
                    updateProductQuantityStatement.executeUpdate();

                    // Delete the cart item
                    String deleteCartItemQuery = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
                    PreparedStatement deleteCartItemStatement = connection.prepareStatement(deleteCartItemQuery);
                    deleteCartItemStatement.setInt(1, userId);
                    deleteCartItemStatement.setInt(2, productId);
                    deleteCartItemStatement.executeUpdate();
                }

                // Pass a success message to the next page (i.e., the index page)
                redirectAttributes.addFlashAttribute("successMessage", "Checkout successful!");
                return "redirect:/index";
            }
        } catch (SQLException e) {
            // Handle the exception as appropriate for your application
            e.printStackTrace();
            return "redirect:/error";
        }
    }

}
