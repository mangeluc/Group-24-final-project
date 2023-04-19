<!doctype html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en" xmlns:th="http://www.thymeleaf.org"
	xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">

<head>

<meta charset="UTF-8">

<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

<meta http-equiv="X-UA-Compatible" content="ie=edge">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
	integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
	crossorigin="anonymous"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
	integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
	crossorigin="anonymous"></script>

<script>
	function addToCart(event, element) {

		event.preventDefault();

		const productId = $(element).data('product-id');

		console.log("Product ID:", productId); // Check the value of productId

		console.log("jQuery is loaded and working");

		$.ajax({

			type : 'POST',

			url : '/cart/update',

			data : {

				'productId' : productId

			},

			contentType : 'application/x-www-form-urlencoded',

			success : function(response) {

				// Update the cart in the UI

				// You can customize this according to your requirements

				alert('Product added to cart successfully!');

			},

			error : function(xhr, textStatus, errorThrown) {

				// Log the error information

				console.log(xhr);

				console.log(textStatus);

				console.log(errorThrown);

				alert('Failed to add product to cart. Please login first.');

			}

		});

	}
</script>

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

</head>

<body>

	<!-- Display success message -->

	<c:if test="${not empty successMessage}">

		<div class="alert alert-success" role="alert">${successMessage}

		</div>

	</c:if>

	<section class="wrapper">

		<div class="container-fostrap">

			<nav class="navbar navbar-expand-lg navbar-light">

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

						<h4>Welcome ${ username }</h4>

						<ul class="navbar-nav mr-auto"></ul>

						<ul class="navbar-nav">

							<li class="nav-item active"><a class="nav-link"
								th:href="@{/}" href="#">Home</a></li>

							<li class="nav-item active"><a class="nav-link"
								href="profileDisplay">Profile</a></li>

							<c:choose>

								<c:when test="${not empty sessionScope.username}">

									<li class="nav-item active"><a class="nav-link"
										href="logout">Logout</a></li>

								</c:when>

								<c:otherwise>

									<li class="nav-item active"><a class="nav-link"
										href="userloginvalidate">Login</a></li>

								</c:otherwise>

							</c:choose>

						</ul>

					</div>

					<div class="search">

						<form class="form-inline my-2 my-lg-0" action="/search"
							method="POST">

							<input class="form-control mr-sm-2" type="search"
								placeholder="Search" aria-label="Search" name="search_term">

							<button class="btn btn-outline-success my-2 my-sm-0"
								type="submit">Search</button>

						</form>

					</div>

				</div>

			</nav>

			<div class="bg mt-5">

				<div class="bg-product mt-5">

					<div class="container product">

						<div class="row">

							<div id="sliderproduct" class="carousel slide "
								data-ride="carousel" data-interval="10000">

								<ol class="carousel-indicators">

									<li data-target="#sliderproduct" data-slide-to="0"
										class="active"></li>

									<li data-target="#sliderproduct" data-slide-to="1"></li>

									<li data-target="#sliderproduct" data-slide-to="2"></li>

								</ol>

								<div class="carousel-inner" role="listbox"
									data-interval="10000000">

									<div class="carousel-item active">

										<div class="container text-center">

											<div class="row">

												<div class="col-sm-6 image">

													<div class="item">

														<!-- <h1>Today's Deal</h1> -->

														<p>${image1}
														<p>

															<img class="img-fluid" src="${product1.image}"
																alt="Product Image" />
													</div>
													<!--enditem-->

												</div>
												<!--endcol-->

												<div class="col-sm-6">

													<!-- <div class="top d-flex justify-content-center">

<a href=""><b>2</b> <br>days</a>

<a href=""><b>20</b> <br> hours</a>

<a href=""><b>15</b> <br>min</a>

<a href=""><b>2</b> <br> sec</a>

</div>endtop -->

													<div class="details">

														<h2 class="cr3">${product1.name}</h2>

														<p class="cr4">${product1.description}.</p>

														<div class="rating">

															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																class="fa fa-star"></i>

														</div>
														<!--endrating-->

														<p class="cr1">${product1.price}</s>
														</p>

														<button type="button" id="add-to-cart-btn"
															class="btn btn-food add-to-cart"
															data-product-id="${product1.id}"
															onclick="addToCart(event, this)">Add To Cart</button>

													</div>
													<!--enddetails-->

												</div>
												<!--endcol-->

											</div>
											<!--endrow-->

										</div>
										<!--endcontainer-->

									</div>
									<!--endcarousel-item-->

									<div class="carousel-item">

										<div class="container text-center">

											<div class="row">

												<div class="col-sm-6 image">

													<div class="item">

														<!-- <h1>Today Deal</h1> -->

														<img class="img-fluid" src="${product2.image}"
															alt="product Image">

													</div>
													<!--enditem-->

												</div>
												<!--endcol-->

												<div class="col-sm-6">

													<!-- <div class="top d-flex justify-content-center">

<a href=""><b>2</b> <br>days</a>

<a href=""><b>20</b> <br> hours</a>

<a href=""><b>15</b> <br>min</a>

<a href=""><b>2</b> <br> sec</a>

</div>endtop -->

													<div class="details">

														<h2 class="cr3">${product2.name}</h2>

														<p class="cr4">${product2.description}.</p>

														<div class="rating">

															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																class="fa fa-star"></i>

														</div>
														<!--endrating-->

														<p class="cr1">${product2.price}</s>
														</p>

														<button type="button" id="add-to-cart-btn"
															class="btn btn-food add-to-cart"
															data-product-id="${product2.id}"
															onclick="addToCart(event, this)">Add To Cart</button>

													</div>
													<!--enddetails-->

												</div>
												<!--endcol-->

											</div>
											<!--endrow-->

										</div>
										<!--endcontainer-->

									</div>
									<!--endcarousel-item-->

									<div class="carousel-item">

										<div class="container text-center">

											<div class="row">

												<div class="col-sm-6 image">

													<div class="item">

														<h1></h1>

														<img class="img-fluid" src="${product3.image}"
															alt="product image">

													</div>
													<!--enditem-->

												</div>
												<!--endcol-->

												<div class="col-sm-6">

													<!-- <div class="top d-flex justify-content-center">

<a href=""><b>2</b> <br>days</a>

<a href=""><b>20</b> <br> hours</a>

<a href=""><b>15</b> <br>min</a>

<a href=""><b>2</b> <br> sec</a>

</div>endtop -->

													<div class="details">

														<h2 class="cr3">${product3.name}</h2>

														<p class="cr4">${product3.description}.</p>

														<div class="rating">

															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																class="fa fa-star"></i>

														</div>
														<!--endrating-->

														<p class="cr1">${product3.price}</s>
														</p>

														<button type="button" id="add-to-cart-btn"
															class="btn btn-food add-to-cart"
															data-product-id="${product3.id}"
															onclick="addToCart(event, this)">Add To Cart</button>

													</div>
													<!--enddetails-->

												</div>
												<!--endcol-->

											</div>
											<!--endrow-->

										</div>
										<!--endcontainer-->

									</div>
									<!--endcarousel-item-->

									<a class="carousel-control-prev fa fa-angle-left"
										href="#sliderproduct" role="button" data-slide="prev"> </a> <a
										class="carousel-control-next fa fa-angle-right"
										href="#sliderproduct" role="button" data-slide="next"> </a>

								</div>
								<!--endslidesliderproduct-->

							</div>
							<!--endrow-->

						</div>
						<!--endcontainer-->

					</div>
					<!--endbg-product-->

				</div>

			</div>

			<style>
:root { -
	-cr1: #F36E45; -
	-cr2: #fff; -
	-cr3: #000000da; -
	-cr4: #000000a1; -
	-cr5: #BEB4B1; -
	-fs1: 34px; -
	-fs2: 24px; -
	-fs3: 20px; -
	-fs4: 16px; -
	-fs5: 14px;
}

.img-fluid {
	width: 300px; /* Change the width and height to suit your needs */
	height: 300px;
	overflow: hidden;
}

.img-fluid img {
	width: 100%; /* This makes the image fill the entire width of the box */
	height: auto; /* This preserves the aspect ratio of the image */
	display: block; /* This removes any default spacing around the image */
}

body {
	background: #e5e5e5;
}

/* the same attribute */
.cr1 {
	color: var(- -cr1);
}

.c2 {
	color: var(- -cr2);
}

.cr3 {
	color: var(- -cr3);
}

.cr4 {
	color: var(- -cr4);
}

.cr5 {
	color: var(- -cr5);
}

.fs1 {
	font-size: 34px;
}

.fs2 {
	font-size: 24px;
}

.fs3 {
	font-size: 20px;
}

.fs4 {
	font-size: 16px;
}

.fs5 {
	font-size: 14px;
}

/* end the same attribute */
@font-face {
	src: url(ProductSansRegular_0.ttf);
	font-family: product;
}

* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
	font-family: segoe ui
}

body, html {
	width: 100%;
	height: 100%;
}

[class*="container"] {
	max-width: 1170px !important;
}

.bg-product {
	/*height: 446px;*/
	background: #d1d7f5;

	/* overflow: hidden; */
}

#sliderproduct {
	width: 100%;
}

#sliderproduct .carousel-inner {
	overflow: visible;
}

#sliderproduct .col-sm-6.image {
	background: #fff;
	box-shadow: 0px 4px 8px 0px #959595;
	position: relative;

	/*top: -44px;

padding: 100px;

padding-top: 40px;*/
}

.item {
	padding: 20px 20px 40px 20px;
}

.col-sm-6.image .item img.img-fluid {
	/*min-width: 100%;*/
	width: 315px;
}

.col-sm-6.image h1 {
	margin-bottom: 20px;
}

#sliderproduct .top a {
	text-decoration: none;
	text-transform: uppercase;
	font-size: 18px;
	padding: 14px 22px;
	background: #e0794f;
	box-sizing: border-box !important;
	text-align: center;
	margin: 0px 2px;
	display: block;
	color: #fff;
	width: 96px;
}

#sliderproduct .col-sm-4.mr-auto {
	margin-top: 22px;
}

* {
	
}

#sliderproduct p.cr1 {
	font-size: 20px;
	font-weight: 500;
	margin-bottom: 30px;
}

#sliderproduct .col-sm-6:last-child {
	padding-top: 27px;
	padding-bottom: 27px;
}

#sliderproduct .details p.d-inline-block {
	color: #e0794f;
}

#sliderproduct .details .fa {
	color: #e0794f;
	padding: 0px 3px;
}

#sliderproduct .rating {
	margin: 23px 0px;
}

#sliderproduct .details .btn {
	text-transform: uppercase;
	font-weight: 400;
	padding: 16px 22px;
	background: #e0794f;
	color: #fff;
	border-radius: 81px;
	font-size: 14px;
	display: inline-block;
}

@font-face {
	font-family: 'Optima';
	src: url('/path/to/your/font/optima-regular.woff2') format('woff2'),
		url('/path/to/your/font/optima-regular.woff') format('woff');
	font-weight: normal;
	font-style: normal;
}

#sliderproduct .details h2 {
	margin: 25px 0px 30px 0px;
	font-size: 50px;
	font-weight: normal;
	font-family: Optima;
}

#sliderproduct .details p.cr4 {
	font-weight: 500;
	font-size: 16px;
	line-height: 19px;
	margin-bottom: 0px;
}

#sliderproduct .carousel-item {
	transition: 0.4s;
}

#sliderproduct a.carousel-control-prev, #sliderproduct a.carousel-control-next
	{
	border-radius: 50%;
	background-color: brown;
	width: 46px;
	height: 46px;
	font-size: 30px;
	text-align: center;
	line-height: 40px;
	opacity: 1;
	top: 50%;
	transform: translate(-50%, -60%);
}

.bg {
	height: 570px;
	overflow: hidden;
}

#sliderproduct ol.carousel-indicators {
	display: none;
}

.footer {
	position: fixed;
	bottom: 0;
	padding: 15px;
	width: 100%;
	text-align: center;
	background-color: #292929;
	color: #fff;
	font-family: sans-serif;
	font-size: 14px;
}

.footer img {
	width: 26px;
	position: relative;
	top: 0px;
	left: -3px;
}

.footer a {
	color: #fff;
	font-weight: bold;
	text-decoration: none;
}
</style>

			<div class="row">

				<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4"
					data-aos="zoom-in-down">

					<div class="card">

						<a class="img-card"> <img src=/images/deals.jpeg />

						</a>

						<div class="card-content">

							<h4 class="card-title">Best deal's</h4>

							<p class="">

								view all products <br>

							</p>

						</div>

						<div class="card-read-more">

							<a href="/user/products" class="btn btn-link btn-block"> GO </a>

						</div>

					</div>

				</div>

				<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4"
					data-aos="zoom-in-down">

					<div class="card">

						<a class="img-card"> <img src="/images/cart2.png">

						</a>

						<div class="card-content">

							<h4 class="card-title">View cart</h4>

							<p class="">

								view added items. <br>

							</p>

						</div>

						<div class="card-read-more">

							<a href="/ucart" class="btn btn-link btn-block">