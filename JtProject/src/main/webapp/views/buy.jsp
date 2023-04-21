<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="body-text">Write your name in the right fields. Also
		write your imaginary card number. By clicking CCV field card will
		turn.</div>
	<form action="/checkout" method="post">
		<div class="wrapper">
			<div class="card">
				<h2 class="visa">VISA</h2>
				<h3 class="num">XXXX XXXX XXXX XXXX</h3>
				<h4>name</br>Trojan</h4>
				<h4>EXP</br>XX/XX</h4>
				<h4>CCV</br>XXX</h4>
			</div>
			<div class="main">
				<div class="content">
					<h1>Payment Informations</h1>
					<form>

						<div class="personal-information"></div>

						<input id="input-field" type="text" name="number"
							placeholder="Card Number" /> <input id="column-left" type="text"
							name="expiry" placeholder="MM / YY" /> <input id="column-right"
							type="text" name="cvc" placeholder="CCV" />

						<div class="card-wrapper"></div>

						<input id="input-field" type="text" name="streetaddress"
							required="required" autocomplete="on" maxlength="45"
							placeholder="Streed Address" /> <input id="column-left"
							type="text" name="city" required="required" autocomplete="on"
							maxlength="20" placeholder="City" /> <input type="hidden"
							name="userId" value="${userId}"> <input id="column-right"
							type="text" name="zipcode" required="required" autocomplete="on"
							pattern="[0-9]*" maxlength="5" placeholder="ZIP code" />

					</form>
					<div class="payment">
						<input id="input-button" type="submit" value="Submit Payment" />
					</div>
				</div>
			</div>
		</div>

<style>
/* @import url('https://fonts.googleapis.com/css2?family=Comic+Neue&family=Playfair+Display:wght@500&display=swap');
@import url('https://fonts.googleapis.com/css?family=Open+Sans&display=swap');
@import url('https://fonts.googleapis.com/css?family=Montserrat&display=swap');
@import url(https://fonts.googleapis.com/css?family=Roboto:400,900,700,500); */

@font-face {
  font-family: 'Optima';
  src: url('/path/to/your/font/optima-regular.woff2') format('woff2'),
       url('/path/to/your/font/optima-regular.woff') format('woff');
  font-weight: normal;
  font-style: normal;
}

body {
	padding: 60px 0;
	background-color: #fff5f7; background-image : linear-gradient( 315deg,
	#e1d7f0 0%, #f7d9ec 74%);
	font-family: Optima;
	margin: 0 auto;
	width: 600px;
	background-image: linear-gradient(315deg, #e1d7f0 0%, #f7d9ec 74%);
}

.body-text {
	padding: 0 20px 30px 20px;
	font-family: Optima;
	font-size: 1em;
	color: #333;
	text-align: center;
	line-height: 1.2em;
}


.wrapper {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	margin-left: auto;
	margin-right: auto;
	
}


.main {
	background-color: white;
	border: 2px solid #6200EA;
	width: 450px;
	height: 450px;
	box-shadow: 0px 8px 60px -10px white;
	border-radius: 10px;
	padding: 70px;
	padding-top: 10px;
}

.content h1 {
	font-family: Optima;
}

.content {
	padding-top: 10px;
	padding-left: 140px;
	font-family: 'Montserrat Medium';
}


input {

	width: 100%;
	padding: 15px 10px;
	margin: 3px 0;
	box-sizing: border-box;
	border: none;
	border-bottom: 2px solid #96a4e7;
	font-family: Optima;
}


.card {
	background-image: linear-gradient(to right, #eac1ff, #dfc9ff, #d7d0ff, #d1d6ff, #cedbff);	
	position: fixed;
	right: 70%;
	top: 25%;
	float: left;
	width: 300px;
	height: 200px;
	box-shadow: 8px 10px 0px 1px #cedbff;
	border-radius: 10px;
	font-family: 'Montserrat Thin';
	border: 2px solid #6200EA;
}

.visa {
	padding-left: 220px;
	font-style: italic;
	text-shadow: #eac1ff 3px 0 1px;
	color: white;
	/*visa font*/
	font-family: "Myriad Pro", Myriad, "Liberation Sans", "Nimbus Sans L", "Helvetica Neue", Helvetica, Arial, sans-serif;
}


.card h4 {
	color: white;
	float: left;
	width: 33%;
	text-align: center;
}

.num {
	color: white;
	text-align: center;
	padding-top: 20px;
	line-height: 0;
}

</style>
</body>
</html>