<html>
    <head>
		<title>BGMR Glasses</title>
		<link rel = "icon" href = "img\BGMR_transp.png" type = "image/x-icon"> 
		<link rel="stylesheet" type="text/css" href="css\style.css">
	</head>
	<body>
		<header>
			<a href="index.jsp" title="Return to home page." id="logo">
                <img src="img\BGMR_transp.png" alt="Logo" style="width:80px"></a>
			<ul>
				<li><a href="index.jsp" class="active">Home</a></li>
				<li><a href="listprod.jsp">Browse</a></li>
				<%
				String userName = (String) session.getAttribute("authenticatedUser");
				if (userName != null){
					out.println("<li><a href=\"customer.jsp\">" + userName + "\'s Account</a></li>");
					out.println("<li><a href=\"logout.jsp\">Logout</a></li>");
				}
				else
					out.println("<li><a href=\"login.jsp\">Login</a></li>");
				%>
				<li><a href="showcart.jsp">Cart</a></li>
			</ul>
		</header>  
        <div class="display">
			<h3 id="h3" style="text-align: center;">Register</h3>
            <div style="margin:0 auto;text-align:center;display:inline">

    <br>  
    <form>  
        <table style="display:inline">
            <tr>
                <td><div align="left"><font color="white" face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
                <td><input type="text" name="firstName"  size=10 maxlength=10></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
                <td><input type="text" name="lastName" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
                <td><input type="email" name="email" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Phone Number: </font></div></td>
                <td><input type="text" name="phone" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white" face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
                <td><input type="text" name="address"  size=10 maxlength=10></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
                <td><input type="text" name="city" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">State/Province: </font></div></td>
                <td><input type="text" name="statprov" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white" face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
                <td><input type="text" name="pcode"  size=10 maxlength=10></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
                <td><input type="password" name="country" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Username: </font></div></td>
                <td><input type="text" name="username" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Password: </font></div></td>
                <td><input type="password" name="password" size=10 maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="left"><font color="white"face="Arial, Helvetica, sans-serif" size="2">Re-type Password: </font></div></td>
                <td><input type="pasword" name="repassword" size=10 maxlength="10"></td>
            </tr>
            </table>
            <br/>
            <input type="submit" value="Register">
            </table>  
    </form>
    <%
    //Check both passwords match [INCOMPLETE]


    //Add customer to database [INCOMPLETE]
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("statprov");
    String postalCode = request.getParameter("pcode");
    String country = request.getParameter("country");
    String userid = request.getParameter("username");
    String password = request.getParameter("password");

    String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password);";
    
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    
    try { // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " +e);
    }
    
    try ( Connection con = DriverManager.getConnection(url, uid, pw);){
        PreparedStatement pstmt = con.prepareStatement(sql);

        closeConnection();
    }
    catch (SQLException ex) {
	    out.println(ex);
    }
    
    
    %>
</div> 
</div>
    </body>  
    </html>  