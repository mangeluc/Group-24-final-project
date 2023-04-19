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
	        String query = "SELECT id, price, image, name, description FROM products WHERE name LIKE ? OR keywords LIKE ?";
	        PreparedStatement pst = con.prepareStatement(query);
	        pst.setString(1, "%" + searchTerm + "%");
	        pst.setString(2, "%" + searchTerm + "%");
	        ResultSet rs = pst.executeQuery();
	        while (rs.next()) {
	            int id = rs.getInt("id");
	            String price = rs.getString("price") + "$";
	            String image = "/images/" +rs.getString("image");
	            String name = rs.getString("name");
	            String description = rs.getString("description");
	            Product product = new Product(id, name, description, image, price);
	            products.add(product);
	        }
	        con.close();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    Util.FillProducts(products);
	    model.addAttribute("product1", products.get(0));
	    model.addAttribute("product2", products.get(1));
	    model.addAttribute("product3", products.get(2));
	    return "index";
	}
}
