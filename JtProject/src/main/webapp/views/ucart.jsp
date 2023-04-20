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

<title>Document</title>

<style>
	#updateButton{	
		font-size: 12px;
		height: 40px;
		width: 90px;
		display: flex;
		
	}
	
	#checkoutButton{
		font-size: 12px;
		margin-right: 33px;
		height: 40px;
		width: 90px;
	}

	
</style>

</head>




<body class="bg-light">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
				th:src="@{/images/logo.png}" src="../static/images/logo.png"
				width="auto" height="40" class="d-inline-block align-top" alt="" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link" href="/adminhome">Home
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
				<th scope="col">Description</th>
				<th scope="col">Update</th>
				
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
					    ResultSet rs = stmt.executeQuery("SELECT p.*, c.quantity as cart_quantity FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = " + userId);
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
				        <%= rs.getFloat("rating") %>
				    </td>
				    <td><img src="/images/<%= rs.getString("image") %>" height="130px" width="120px">
					<td>
					    <form action="/updateCart" method="post">
					        <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
					        <input type="hidden" name="userId" value="<%= userId %>">
					        <input type="number" name="quantity" value="<%= rs.getInt("cart_quantity") %>" min="0" class="form-control">
					</td>
				    <td>
				        <%= rs.getInt("price") %>
				    </td>
				    <td>
				        <%= rs.getString("description") %>
				    </td>

					
					<td style="display: flex; align-items: center; justify-centent: center; height: 130px">
						<div style="margin: auto;">
					    	<input type="submit" value="Update" class="btn btn-info btn-lg" id = "updateButton">
					    </div>
					    </form>
					</td>
					</td>
					<td>
					
					
					</td>

				</tr>
				<%
				}
				%>

			</tbody>
		</table>
		<form action="/payment" method="get">
		    <input type="hidden" name="userId" value="${userId}">
		    <button type="submit" class="btn btn-primary float-right" id = "checkoutButton">Checkout</button>
		</form>
	<!-- Display error messages -->
		<c:if test="${not empty errors}">
		    <div class="alert alert-danger" role="alert">
		        <ul>
		            <c:forEach items="${errors}" var="error">
		                <li>${error}</li>
		            </c:forEach>
		        </ul>
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