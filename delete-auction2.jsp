<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Redirect</title>
	</head>
	<body class="main">
		<% 
			String username = (String)request.getSession().getAttribute("username");
			String password = (String)request.getSession().getAttribute("password");
			String auctionID = request.getParameter("auction-id");
			
			try{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				
				String str = "delete from auction where auction_id = " + auctionID;
				stmt.executeUpdate(str);
				out.println("Auction Deleted");
				
				db.closeConnection(con);
			}catch (Exception e){
				out.println(e);
			}
			
			
			out.println("<br>");
			out.println("<br>");
			
			out.println("<a href='customer_rep_main_page.jsp?username="+username+"&password="+password+"'>Click here to go back to customer rep home page</a>");
		%>
		
		<br>
		<br>
		<a href='index.jsp' >Logout</a> 
	

	</body>
</html>
