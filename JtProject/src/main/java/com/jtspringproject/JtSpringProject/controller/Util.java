package com.jtspringproject.JtSpringProject.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class Util {
	public static void FillProducts( List<Product> products)
	{
		if (products.size() < 3) {
	        Set<Integer> selectedProductIds = products.stream()
	                .map(Product::getId)
	                .collect(Collectors.toSet());

	        try (Connection connection = DriverManager.getConnection(UserController.databaseURL,UserController.databaseUser,UserController.databasePassword)) {
	            String sql;
	            
	            if (!selectedProductIds.isEmpty()) {
	                sql = "SELECT id, image, price, name, description FROM products WHERE id NOT IN (" +
	                        selectedProductIds.stream().map(String::valueOf).collect(Collectors.joining(", ")) +
	                        ") ORDER BY RAND() LIMIT ?";
	            } else {
	                sql = "SELECT id, image, price, name, description FROM products ORDER BY RAND() LIMIT ?";
	            }
	            
	      

	            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
	                pstmt.setInt(1, 3 - products.size());
	                ResultSet rs = pstmt.executeQuery();

	                while (rs.next()) {
	                	int id = rs.getInt("id");
	    	            String price = rs.getString("price") + "$";
	    	            String image = "/images/" + rs.getString("image");
	    	            String name = rs.getString("name");
	    	            String description = rs.getString("description");
	    	            Product product = new Product(id, name, description, image, price);
	    	            products.add(product);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
		
	}

}
