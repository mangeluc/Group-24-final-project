<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.jtspringproject.JtSpringProject.controller.UserController" %>
<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script>
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const alertElem = document.querySelector('.alert');
            if (alertElem) {
                alertElem.style.display = 'none';
            }
        }, 5000); // 5 seconds
    });
</script>

<style>
	#updateButton{
		font-size: 15px;
		height: 45px;
	    display: flex;
	    align-items: center;
	    justify-content: center;	
	    margin-top: 25px;    
	}
	#desCol{
		width: 600px;
	}
	#lastCol{
		width: 200px;
		margin-right: 5px;
		height: 130px;
		text-align: center;
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
					<li class="nav-item active"><a class="nav-link" href="/logout">Logout</a>
					</li>

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
				<th scope="col" class = "lastCol">Update</th>
				
			</tr>
			<tbody>
				<tr>

					<%
					// Get the userId from the request scope
					int userId = (Integer) request.getAttribute("userId");
					
					try {
					    String url = "jdbc:mysql://localhost:3306/springproject";
					    Class.forName("com.mysql.cj.jdbc.Driver");
					    Connection con = DriverManager.getConnection(UserController.databaseURL, UserController.databaseUser, UserController.databasePassword);
					    Statement stmt = con.createStatement();
					    ResultSet rs = stmt.executeQuery("SELECT p.*, o.order_id, o.rating as order_rating, o.quantity as order_quantity FROM order_history o JOIN products p ON o.product_id = p.id WHERE o.user_id = " + userId);
					%>
					<%
					while (rs.next()) {
					%>
				    <td>
				        <%= rs.getInt("id") %>
				    </td>
				    <td>
				        <%= rs.getString("name") %>
				    </td>
					<td>
					    <form action="/updateRating" method="post">
					        <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
					        <input type="hidden" name="userId" value="<%= userId %>">
					        <input type="hidden" name="orderId" value="<%= rs.getInt("order_id") %>">
					        <input type="number" name="rating" value="<%= rs.getInt("order_rating") > 0 ? rs.getInt("order_rating") : "" %>" min="0" max="5" class="form-control" required>

					</td>
				    <td><img src="/images/<%= rs.getString("image") %>" height="120px" width="120px">
					<td>
						<%= rs.getInt("order_quantity") %>
					</td>
				    <td>
				        <%= rs.getInt("price") %>
				    </td>
				    <td>
				        <%= rs.getString("description") %>
				    </td>

			
					<td>
					    <input type="submit" value="Update" class="btn btn-info btn-lg" id = "updateButton">
					    </form>
					</td>
					
					<td>
					
					
					</td>

				</tr>
				<%
				}
				%>

			</tbody>
		</table>
	<!-- Display error messages -->
		<c:if test="${not empty ratingSuccess}">
		    <div class="alert alert-success" role="alert">
		        ${ratingSuccess}
		    </div>
		</c:if>
		<c:if test="${not empty ratingError}">
	    <div class="alert alert-danger" role="alert">
	        ${ratingError}
	    </div>
		</c:if>
		<%
		} catch (Exception ex) {
		out.println("Exception Occurred:: " + ex.getMessage());
		}
		%>
	</div>



	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
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