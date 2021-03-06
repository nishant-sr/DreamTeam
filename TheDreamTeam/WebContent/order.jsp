<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
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
		<div class="summary">

<%
// Get customer id
String custId = request.getParameter("customerId");
// Get password
String password = request.getParameter("password");
// Get shopping cart
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
                
try 
{	
	if (custId == null || custId.equals("")){
		out.println("<h3 style=\"text-align: center;\">Invalid customer id.  Go back to the previous page and try again.</h3>");
		out.println("<section><a href=\"checkout.jsp\" id=\"btn\">Previous Page</a></section>");
	}
	else if (productList == null)
		out.println("<h3 style=\"text-align: center;\">Your shopping cart is empty!</h3>");
	else
	{	
		// Check if customer id is a number
		int num=-1;
		try
		{
			num = Integer.parseInt(custId);
		} 
		catch(Exception e)
		{
			out.println("<h3 style=\"text-align: center;\">Invalid customer id.  Go back to the previous page and try again.</h3>");
			out.println("<section><a href=\"checkout.jsp\" id=\"btn\">Previous Page</a></section>");
			return;
		}		
        
		// Get database connection
        getConnection();
	                		
        String sql = "SELECT customerId, firstName+' '+lastName, password FROM customer WHERE customerId = ?";	
				      
   		con = DriverManager.getConnection(url, uid, pw);
   		PreparedStatement pstmt = con.prepareStatement(sql);
   		pstmt.setInt(1, num);
   		ResultSet rst = pstmt.executeQuery();
   		int orderId=0;
   		String custName = "";

   		if (!rst.next())
   		{
   			out.println("<h3 style=\"text-align: center;\">Invalid customer id.  Go back to the previous page and try again.</h3>");
			out.println("<section><a href=\"checkout.jsp\" id=\"btn\">Previous Page</a></section>");
   		}
   		else
   		{	
   			custName = rst.getString(2);
			String dbpassword = rst.getString(3);
				    		
			// make sure the password on the database is the same as the one the user entered
			if (!dbpassword.equals(password)) 
			{
				out.println("<h3 style=\"text-align: center;\">The password you entered was not correct. Please go back and try again.</h3><br>"); 
				return;
			}
		
   			// Enter order information into database
   			sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";

   			// Retrieve auto-generated key for orderId
   			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
   			pstmt.setInt(1, num);
   			pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
   			pstmt.executeUpdate();
   			ResultSet keys = pstmt.getGeneratedKeys();
   			keys.next();
   			orderId = keys.getInt(1);

         	  	out.println("<table style=\" width=\"100%\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

           	double total =0;
           	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
           	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
						
           	while (iterator.hasNext())
           	{ 
           		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
   				String productId = (String) product.get(0);
                   out.print("<tr><td align=\"center\">"+productId+"</td>");
                   out.print("<td align=\"center\">"+product.get(1)+"</td>");
   				out.print("<td align=\"center\">"+product.get(3)+"</td>");
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
   				out.print("<td align=\"center\">"+currFormat.format(pr)+"</td>");
                  	out.print("<td align=\"center\">"+currFormat.format(pr*qty)+"</td></tr>");
                   out.println("</tr>");
                   total = total +pr*qty;

               	sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
   				pstmt = con.prepareStatement(sql);
   				pstmt.setInt(1, orderId);
   				pstmt.setInt(2, Integer.parseInt(productId));
   				pstmt.setInt(3, qty);
   				pstmt.setString(4, price);
   				pstmt.executeUpdate();				
           	}
			out.println("<tr><td>&nbsp</td></tr>");
           	out.println("<tr><b>Order Total</b></td>"
                          	+"<td>"+currFormat.format(total)+"</td></tr>");
           	out.println("</table>");

   			// Update order total
   			sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
   			pstmt = con.prepareStatement(sql);
   			pstmt.setDouble(1, total);
   			pstmt.setInt(2, orderId);			
   			pstmt.executeUpdate();						

   			out.println("<p>Thank you for you order. It will be shipped to you soon.</p>");
   			out.println("<p>Your order reference number is: "+orderId+"</p>");
   			out.println("<p>Shipping to Customer: "+custId+"      Name: "+custName+"</p>");   			
   			
   			// Clear session variables (cart)
   			session.setAttribute("productList", null);    
   		}
   	}
}
catch (SQLException ex)
{ 	out.println(ex);
}
finally
{
	try
	{
		if (con != null)
			con.close();
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
}  
%>                       				
</div>
</body>
</html>
