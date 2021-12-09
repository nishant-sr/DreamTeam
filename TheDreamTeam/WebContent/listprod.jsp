<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
	<head>
		<title>The Dream Team</title>
		<link rel="stylesheet" type="text/css" href="css\style.css">
	</head>
<body>
	<header>
		
		<ul class='navbar'>
			<li><a href="index.jsp">Home</a></li>
			<li><a href="listprod.jsp" class="active">Browse</a></li>
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
	<div class="search">
			<form method="get" action="listprod.jsp">
					<p>FILTERS</p>
					<select size="1" name="categoryName">
						<option>All</option>
						<option>NHL</option>
						<option>NFL</option>
						<option>MLB</option>
					</select>
				<input type="text" name="productName">
				<input class="button" type="submit" value="Submit">
				<input class="button" type="reset" value="Reset">
			</form>

<%
// Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ? AND categoryName = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>"+category+" Products</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE categoryName = ?";
}
else
{
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P JOIN Category C ON P.categoryId = C.categoryId";
}

out.println(filter);

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try { // Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}

try ( Connection con = DriverManager.getConnection(url, uid, pw);){
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam)
	{
		pstmt.setString(1, name);	
		if (hasCategoryParam)
		{
			pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();
	out.println("<div class='products'>");
	while (rst.next()) 
	{
		int id = rst.getInt(1);
		
		out.println("<div class=\"product\">");
		String imageLoc = rst.getString(5);
		out.println("<img src=\""+imageLoc+"\" width=300px>");
		out.println("<p class=\"name\"><a href=\"product.jsp?id="+id+"\">" + rst.getString(2) + "</a></p>");
		String itemCategory = rst.getString(4);
		out.println("<p class=\"price\">" + currFormat.format(rst.getDouble(3)) + "</p>");
		out.println("<p><addcart><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
			+ "&price=" + rst.getDouble(3)+"\">+</a></addcart></p>");
		out.println("</div>");
	}
	out.println("</div>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>
</body>
</html>

