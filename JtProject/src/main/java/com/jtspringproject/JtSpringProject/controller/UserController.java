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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



@Controller
public class UserController{
	//IMPORTANT: make sure these three variables are correct before running
	public static final String databaseURL = "jdbc:mysql://localhost:3306/flowers";
	public static final String databaseUser = "root";
	public static final String databasePassword = "L123@qwe";
	
	@RequestMapping(value = {"/logout"})
	public String returnIndex(HttpSession session) {
		session.removeAttribute("username");
		session.removeAttribute("userId");
		session.removeAttribute("role");
		return "redirect:/";
	}
	

	@GetMapping({"/index", "/"})
	public String index(Model model, HttpSession session) {
		if("ROLE_ADMIN".equals(session.getAttribute("role")))
		{
			return "adminHome";
		}
		String username = (String) session.getAttribute("username");
		List<Product> products = new ArrayList<>();
		Util.FillProducts(products);
	    model.addAttribute("product1", products.get(0));
	    model.addAttribute("product2", products.get(1));
	    model.addAttribute("product3", products.get(2));
		model.addAttribute("username", username);
		return "index";
			
	}

	
	@GetMapping("/userloginvalidate")
	public String userlog(Model model) {
		
		return "userLogin";
	}
	@PostMapping("/userloginvalidate")
	public String userlogin( @RequestParam("username") String username, @RequestParam("password") String pass, HttpSession session, Model model) {
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+username+"' and password = '"+ pass+"' ;");
			if(rst.next()) {
				String role = rst.getString("role");
				session.setAttribute("username", username);
				session.setAttribute("userId", rst.getInt("user_id"));
				session.setAttribute("role", rst.getString("role"));
				if(role.equals("ROLE_ADMIN"))
				{
					return "adminHome";
				}
				return "redirect:/index";
				}
			else {
				model.addAttribute("message", "Invalid Username or Password");
				return "userLogin";
			}
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "userLogin";
			
	}
	

	@GetMapping("/register")
	public String registerUser()
	{
		return "register";
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
	public String newUseRegister(@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("email") String email, @RequestParam("address") String address)
	{
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			PreparedStatement pst = con.prepareStatement("insert into users(username,password,email, role, address) values(?,?,?, 'ROLE_USER', ?);");
			pst.setString(1,username);
			pst.setString(2, password);
			pst.setString(3, email);
			pst.setString(4, address);
			
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
	
	
	@GetMapping("profileDisplay")
	public String profileDisplay(Model model, HttpSession session) {
	    if (session.getAttribute("userId") == null) {
	        // Redirect to an appropriate page (e.g., login) if userId is not found in the session
	        return "redirect:/userloginvalidate";
	    }
		String displayusername,displaypassword,displayemail,displayaddress;
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+(String) session.getAttribute("username")+"';");
			
			if(rst.next())
			{
			int userid = rst.getInt(1);
			displayusername = rst.getString(2);
			displayemail = rst.getString("email");
			displaypassword = rst.getString("password");
			displayaddress = rst.getString("address");
			model.addAttribute("userid",userid);
			model.addAttribute("username",displayusername);
			model.addAttribute("email",displayemail);
			model.addAttribute("password",displaypassword);
			model.addAttribute("address",displayaddress);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		System.out.println("Hello");
		return "updateProfile";
	}
	
	@RequestMapping(value = "updateuser", method = RequestMethod.POST)
	public String updateUserProfile(@RequestParam("userid") int userid,@RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("address") String address, HttpSession session) 
	
	{
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			
			PreparedStatement pst = con.prepareStatement("update users set username= ?,email = ?,password= ?, address= ? where user_id = ?;");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, address);
			pst.setInt(5, userid);
			pst.executeUpdate();
			session.removeAttribute("username");
			session.setAttribute("username", username);

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/index";
	}
}
