<html>
    <head>
		<title>The Dream Team</title>
		<link rel="stylesheet" type="text/css" href="css\style.css">
	</head>
<body>
	<header>
		<ul>
			<li><a href="index.jsp">Home</a></li>
			<li><a href="listprod.jsp">Browse</a></li>
			<li><a href="showcart.jsp">Cart</a></li>
		</ul>
	</header>
    <div class="checkoutform">
    		<form method="get" action="order.jsp">
    		<table>
				<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
				<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
			</table>
			<br/>
			<input type="submit" value="Submit">
			<input type="reset" value="Reset">
		</form>
	</div>
</body>
</html>

