<!DOCTYPE html>
<html>
	<head>
		<title>The Dream Team</title>
		<link rel="stylesheet" type="text/css" href="css\style.css">
	</head>
	<body>
		<video src='img/video.mp4' muted loop autoplay></video>
		<header>
			<ul>
				<li><a href="index.jsp" class="active">Home</a></li>
				<li><a href="showcart.jsp">Cart</a></li>
				<%
				String userName = (String) session.getAttribute("authenticatedUser");
				if (userName != null){
					out.println("<li><a href=\"logout.jsp\">Logout</a></li>");
				}
				else
					out.println("<li><a href=\"login.jsp\">Login</a></li>");
				%>
			</ul>
		</header>
		<div class='title'>
			<h1>The Dream Team</h1>
			<p><a href="listprod.jsp" class='shop'>Shop</a></p>
		</div>
	</body>
</html>