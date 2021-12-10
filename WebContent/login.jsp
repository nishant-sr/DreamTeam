<!DOCTYPE html>
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
		<div class='login'>
<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table>
<tr>
	<td><div><font>Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div><font>Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>
	</body>
</html>

