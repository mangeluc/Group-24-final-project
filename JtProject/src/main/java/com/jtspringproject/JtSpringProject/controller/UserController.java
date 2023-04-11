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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


class Product {
    private int id;
    private int price;
    private String image;

    public Product() {
    }

    public Product(int id, String image, int price) {
        this.id = id;
        this.image = image;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}


@Controller
public class UserController{
	//IMPORTANT: make sure these three variables are correct before running
	public static final String databaseURL = "jdbc:mysql://localhost:3306/flowers";
	public static final String databaseUser = "root";
	public static final String databasePassword = "L123@qwe";

	@GetMapping("/register")
	public String registerUser()
	{
		return "register";
	}
	@GetMapping("/contact")
	public String contact()
	{
		return "contact";
	}
	@GetMapping("/buy")
	public String buy()
	{
		return "buy";
	}
	
	@GetMapping("/user/products")
	public String getproduct(Model model) {
		return "uproduct";
	}
	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public String newUseRegister(@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("email") String email)
	{
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			PreparedStatement pst = con.prepareStatement("insert into users(username,password,email, role) values(?,?,?, 'ROLE_USER');");
			pst.setString(1,username);
			pst.setString(2, password);
			pst.setString(3, email);
			
			int i = pst.executeUpdate();
			System.out.println("data base updated"+i);
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/";
	}
	
	@RequestMapping(value = "search", method = RequestMethod.POST)
	public String search(@RequestParam("search_term") String searchTerm, Model model) {
	    List<Product> products = new ArrayList<>();


	    try {
	        Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
	        String query = "SELECT id, price, image FROM products WHERE name LIKE ? OR keywords LIKE ?";
	        PreparedStatement pst = con.prepareStatement(query);
	        pst.setString(1, "%" + searchTerm + "%");
	        pst.setString(2, "%" + searchTerm + "%");
	        ResultSet rs = pst.executeQuery();
	        while (rs.next()) {
	            int id = rs.getInt("id");
	            int price = rs.getInt("price");
	            String image = rs.getString("image");
	            Product product = new Product(id, image, price);
	            products.add(product);
	        }
	        con.close();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    for(int i = 0; i<products.size(); i++)
	    {
	    	System.out.println(products.get(i).getImage());
	    }
	      
	    if (products.size() < 3) {
	        Set<Integer> selectedProductIds = products.stream()
	                .map(Product::getId)
	                .collect(Collectors.toSet());

	        try (Connection connection = DriverManager.getConnection(databaseURL,databaseUser,databasePassword)) {
	            String sql;
	            
	            if (!selectedProductIds.isEmpty()) {
	                sql = "SELECT id, image, price FROM products WHERE id NOT IN (" +
	                        selectedProductIds.stream().map(String::valueOf).collect(Collectors.joining(", ")) +
	                        ") ORDER BY RAND() LIMIT ?";
	            } else {
	                sql = "SELECT id, image, price FROM products ORDER BY RAND() LIMIT ?";
	            }
	            
	      

	            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
	                pstmt.setInt(1, 3 - products.size());
	                ResultSet rs = pstmt.executeQuery();

	                while (rs.next()) {
	                	int id = rs.getInt("id");
	    	            int price = rs.getInt("price");
	    	            String image = "/images/" + rs.getString("image");
	    	            Product product = new Product(id, image, price);
	    	            products.add(product);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    
	
	    
	    
	    


	    model.addAttribute("products", products);
	    return "index";
	}
}
