<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

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
	<div class="productInfo">
<%
// Get product name to search for
String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productPrice, productImageURL, productDesc FROM Product P  WHERE productId = ?";

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
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h3>"+rst.getString(2)+"</h3>");
		
		int prodId = rst.getInt(1);
		out.println("<h5>Price: " + currFormat.format(rst.getDouble(3)) + "</h5><br>");

		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+imageLoc+"\" width=300px>");

		out.println("<h4>Description:</h4>");
		out.println("<h5>"+ rst.getString(5) + "</h5>" + "<br>");
		out.println("<p><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></p>");		
		out.println("<br>");
		out.println("<p><a href=\"listprod.jsp\">Continue Shopping</a></p>");
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>
</div>
</body>
</html>

