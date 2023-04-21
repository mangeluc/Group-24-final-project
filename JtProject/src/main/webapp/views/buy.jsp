<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="/checkout" method="post">
		<div class="body-text"> Write your imaginary card number. 
		The Address, City and Zipcode areas are required. Click Submit Payment for purchasing. </div>
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
							<input type="hidden" name="userId" value="${userId}">
							<input type="text" name="number" placeholder="Card Number" /> 
							<input type="text" name="expiry" placeholder="MM / YY" /> 
							<input type="text" name="cvc" placeholder="CCV" />
							<input type="text" name="streetaddress" required="required" autocomplete="on" maxlength="45" placeholder="Streed Address" /> 
							<input type="text" name="city" required="required" autocomplete="on" maxlength="20" placeholder="City" /> 
							<input type="text" name="zipcode" required="required" autocomplete="on" pattern="[0-9]*" maxlength="5" placeholder="ZIP code" />
					</form>
					<div class="payment">
						<input id="input-button" type="submit" value="Submit Payment" />
					</div>
				</div>
			</div>
		</div>
	</form>
<style>
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
	padding-right: 140px;
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
	left: 70%;
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