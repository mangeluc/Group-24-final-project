<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ page import="com.jtspringproject.JtSpringProject.controller.UserController" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<script>
function addToCart(event, element) {
	  event.preventDefault();

	  const productId = $(element).data('product-id');

	  console.log("Product ID:", productId); // Check the value of productId

	  console.log("jQuery is loaded and working");

	  $.ajax({
	    type: 'POST',
	    url: '/cart/update',
	    data: {
	      'productId': productId
	    },
	    contentType: 'application/x-www-form-urlencoded',
	    success: function (response) {
	      // Update the cart in the UI
	      // You can customize this according to your requirements
	      alert('Product added to cart successfully!');
	    },
	    error: function (xhr, textStatus, errorThrown) {
	      // Log the error information
	      console.log(xhr);
	      console.log(textStatus);
	      console.log(errorThrown);

	      alert('Failed to add product to cart. Please login first.');
	    }
	  });
	}
</script>

<style>
.lastCol{	
	width: 200px;
	margin-right: 5px;
	height: 130px;
	text-align: center;
}
#addCart{
	font-size: 15px;
  	display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 35px;
}
#desCol{
	width: 600px;
}
</style>

<title>Document</title>
</head>
<body class="bg-light">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link" href="/index">Home
							Page</a></li>

				</ul>

			</div>
		</div>
	</nav>
	<div class="container-fluid">

		
		<table class="table">

			<tr>
				<th scope="col">Serial No.</th>
				<th scope="col">Product Name</th>
				<th scope="col">rating</th>
				<th scope="col">Preview</th>
				<th scope="col">Quantity</th>
				<th scope="col">Price</th>
				<th scope="col" id = "desCol">Description</th>
				<th scope="col" id = "lastCol">Add To Cart</th>
				
			</tr>
			<tbody>
				<tr>

					<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection(UserController.databaseURL, UserController.databaseUser, UserController.databasePassword);
						Statement stmt = con.createStatement();
						Statement stmt2 = con.createStatement();
						ResultSet rs = stmt.executeQuery("select * from products");
					%>
					<%
					while (rs.next()) {
					%>
					<td>
						<%= rs.getInt(1) %>
					</td>
					<td>
						<%= rs.getString("name") %>
					</td>
					<td>
						<%= rs.getFloat("rating") %>
					</td>
					<td><img src="/images/<%= rs.getString("image") %>" height="120px" width="120px">
					<td>
						<%= rs.getInt("quantity") %>
					</td>
					<td>
						<%= rs.getInt("price") %>
					</td>
					<td>
						<%= rs.getString("description") %>
					</td>

					<td id = "lastCol">
					<button type = "button" class="btn btn-info btn-lg" id= "addCart" data-product-id=<%= rs.getInt(1) %> onclick="addToCart(event, this)">Add To Cart</button>

					</td>
					<td>
					
					
					</td>

				</tr>
				<%
				}
				%>

			</tbody>
		</table>
		<%
		} catch (Exception ex) {
		out.println("Exception Occurred:: " + ex.getMessage());
		}
		%>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ page import="com.jtspringproject.JtSpringProject.controller.UserController" %>
