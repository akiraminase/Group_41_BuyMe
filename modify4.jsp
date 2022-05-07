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
			String modify_username = (String)request.getSession().getAttribute("modify-username");
			String newUsername = request.getParameter("newUsername");
			String newEmail = request.getParameter("newEmail");
			String newPassword = request.getParameter("newPassword");
			
			
			try{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				
				if (newUsername != null){
					String str = "update end_user set username = \"" + newUsername + "\" where username = \"" + modify_username + "\"";
					stmt.executeUpdate(str);
					out.println("Username Updated");
				}
				else if (newEmail != null){
					String str = "update end_user set email = \"" + newEmail + "\" where username = \"" + modify_username + "\"";
					stmt.executeUpdate(str);
					out.println("Email Updated");
				}
				else if (newPassword != null){
					String str = "update end_user set password = \"" + newPassword + "\" where username = \"" + modify_username + "\"";
					stmt.executeUpdate(str);
					out.println("Password Updated");
				}
				
				
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
