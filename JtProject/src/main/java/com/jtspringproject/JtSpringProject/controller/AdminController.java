package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.mysql.cj.protocol.Resultset;



@Controller
public class AdminController {
	public static final String databaseURL = UserController.databaseURL;
	public static final String databaseUser = UserController.databaseUser;
	public static final String databasePassword = UserController.databasePassword;
	
	int adminlogcheck = 0;
	String usernameforclass = "";
	@RequestMapping(value = {"/","/logout"})
	public String returnIndex() {
		adminlogcheck =0;
		usernameforclass = "";
		return "userLogin";
	}
	

	
	@GetMapping("/index")
	public String index(Model model, HttpSession session) {
		String username = (String) session.getAttribute("username");
		if(username == null)
			return "userLogin";
		else {
			List<Product> products = new ArrayList<>();
			Util.FillProducts(products);
		    model.addAttribute("product1", products.get(0));
		    model.addAttribute("product2", products.get(1));
		    model.addAttribute("product3", products.get(2));
			model.addAttribute("username", username);
			return "index";
		}
			
	}

	
	@GetMapping("/userloginvalidate")
	public String userlog(Model model) {
		
		return "userLogin";
	}
	@PostMapping("/userloginvalidate")
	public String userlogin( @RequestParam("username") String username, @RequestParam("password") String pass, HttpSession session, Model model) {
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+username+"' and password = '"+ pass+"' ;");
			if(rst.next()) {
				session.setAttribute("username", username);
				session.setAttribute("userId", rst.getInt("user_id"));
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
	
	
	@GetMapping("/admin")
	public String adminlogin(Model model) {
		
		return "adminlogin";
	}
	@GetMapping("/adminhome")
	public String adminHome(Model model) {
		if(adminlogcheck!=0)
			return "adminHome";
		else
			return "redirect:/admin";
	}
	@GetMapping("/loginvalidate")
	public String adminlog(Model model) {
		
		return "adminlogin";
	}
	@RequestMapping(value = "loginvalidate", method = RequestMethod.POST)
	public String adminlogin( @RequestParam("username") String username, @RequestParam("password") String pass,Model model) {
		
		if(username.equalsIgnoreCase("admin") && pass.equalsIgnoreCase("Johnsonlu351!")) {
			adminlogcheck=1;
			return "redirect:/adminhome";
			}
		else {
			model.addAttribute("message", "Invalid Username or Password");
			return "adminlogin";
		}
	}
	@GetMapping("/admin/categories")
	public String getcategory() {
		return "categories";
	}
	@RequestMapping(value = "admin/sendcategory",method = RequestMethod.GET)
	public String addcategorytodb(@RequestParam("categoryname") String catname)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			
			PreparedStatement pst = con.prepareStatement("insert into categories(name) values(?);");
			pst.setString(1,catname);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}
	
	@GetMapping("/admin/categories/delete")
	public String removeCategoryDb(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			
			PreparedStatement pst = con.prepareStatement("delete from categories where categoryid = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}
	
	@GetMapping("/admin/categories/update")
	public String updateCategoryDb(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryname)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			
			PreparedStatement pst = con.prepareStatement("update categories set name = ? where categoryid = ?");
			pst.setString(1, categoryname);
			pst.setInt(2, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/products")
	public String getproduct(Model model) {
		return "products";
	}
	@GetMapping("/admin/products/add")
	public String addproduct(Model model) {
		return "productsAdd";
	}

	@GetMapping("/admin/products/update")
	public String updateproduct(@RequestParam("pid") int id,Model model) {
		String pname,pdescription,pimage;
		int pid,pprice,pweight,pquantity,pcategory;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from products where id = "+id+";");
			
			if(rst.next())
			{
			pid = rst.getInt(1);
			pname = rst.getString(2);
			pdescription = rst.getString(3);
			pprice =  rst.getInt(6);
			pquantity = rst.getInt(9);
		
			model.addAttribute("pid",pid);
			model.addAttribute("pname",pname);
			model.addAttribute("pdescription",pdescription);
			model.addAttribute("pprice",pprice);
			model.addAttribute("pquantity",pquantity);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "productsUpdate";
	}
	
	@RequestMapping(value = "admin/products/updateData",method=RequestMethod.POST)
	public String updateproducttodb(@RequestParam("id") int id,@RequestParam("name") String name, @RequestParam("price") int price, @RequestParam("quantity") int quantity, @RequestParam("description") String description) 
	
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			
			PreparedStatement pst = con.prepareStatement("update products set name= ?, description = ?, price = ?, quantity = ? where id = ?;");
			pst.setString(1, name);
			pst.setString(2, description);
			pst.setInt(3, price);
			pst.setInt(4, quantity);
			pst.setInt(5, id);
			int i = pst.executeUpdate();			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@GetMapping("/admin/products/delete")
	public String removeProductDb(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			
			
			PreparedStatement pst = con.prepareStatement("delete from products where id = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@PostMapping("/admin/products")
	public String postproduct() {
		return "redirect:/admin/categories";
	}
	@RequestMapping(value = "admin/products/sendData",method=RequestMethod.POST)
	public String addproducttodb(@RequestParam("name") String name, @RequestParam("categoryid") String catid, @RequestParam("price") int price, @RequestParam("weight") int weight, @RequestParam("quantity") int quantity, @RequestParam("description") String description, @RequestParam("productImage") String picture ) {
		
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from categories where name = '"+catid+"';");
			if(rs.next())
			{
			int categoryid = rs.getInt(1);
			
			PreparedStatement pst = con.prepareStatement("insert into products(name,image,categoryid,quantity,price,weight,description) values(?,?,?,?,?,?,?);");
			pst.setString(1,name);
			pst.setString(2, picture);
			pst.setInt(3, categoryid);
			pst.setInt(4, quantity);
			pst.setInt(5, price);
			pst.setInt(6, weight);
			pst.setString(7, description);
			int i = pst.executeUpdate();
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@GetMapping("/admin/customers")
	public String getCustomerDetail() {
		return "displayCustomers";
	}
	
	
	@GetMapping("profileDisplay")
	public String profileDisplay(Model model) {
		String displayusername,displaypassword,displayemail,displayaddress;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+usernameforclass+"';");
			
			if(rst.next())
			{
			int userid = rst.getInt(1);
			displayusername = rst.getString(2);
			displayemail = rst.getString(3);
			displaypassword = rst.getString(4);
			displayaddress = rst.getString(5);
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
	
	@RequestMapping(value = "updateuser",method=RequestMethod.POST)
	public String updateUserProfile(@RequestParam("userid") int userid,@RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("address") String address) 
	
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			
			PreparedStatement pst = con.prepareStatement("update users set username= ?,email = ?,password= ?, address= ? where uid = ?;");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, address);
			pst.setInt(5, userid);
			int i = pst.executeUpdate();	
			usernameforclass = username;
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/index";
	}

}
