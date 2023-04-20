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


	@GetMapping("/admin/products")
	public String getproduct(HttpSession session) {
		if(!"ROLE_ADMIN".equals(session.getAttribute("role")))
		{
			return "redirect:/userloginvalidate";
		}
		return "products";
	}
	
	
	@GetMapping("/adminhome")
	public String getadminhome(HttpSession session) {
		if(!"ROLE_ADMIN".equals(session.getAttribute("role")))
		{
			return "redirect:/userloginvalidate";
		}
		return "adminHome";
	}
	

	@GetMapping("/admin/products/update")
	public String updateproduct(@RequestParam("pid") int id,Model model, HttpSession session) {
		if(!"ROLE_ADMIN".equals(session.getAttribute("role")))
		{
			return "redirect:/userloginvalidate";
		}	
		String pname,pdescription;
		int pid,pprice,pquantity;
		try
		{
			Connection con = DriverManager.getConnection(databaseURL,databaseUser,databasePassword);
			Statement stmt = con.createStatement();
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
	public String removeProductDb(@RequestParam("id") int id, HttpSession session)
	{
		if(!"ROLE_ADMIN".equals(session.getAttribute("role")))
		{
			return "redirect:/userloginvalidate";
		}
		try
		{
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
	
	
	@GetMapping("/admin/customers")
	public String getCustomerDetail(HttpSession session) {
		if(!"ROLE_ADMIN".equals(session.getAttribute("role")))
		{
			return "redirect:/userloginvalidate";
		}
		return "displayCustomers";
	}
	


}
