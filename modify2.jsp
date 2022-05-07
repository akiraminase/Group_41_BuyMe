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
			String modify_username = request.getParameter("modify-username");
			request.getSession().setAttribute("modify-username", modify_username);
			
			
			out.println("How would you like to modify the account: " + modify_username);
			out.println("<br>");
			
			out.println("<form method=\"get\" action=\"modify3.jsp\">");
			out.println("<input type=\"radio\" name=\"command\" value=\"delete\"/>Delete Account");
			out.println("<br>");
			out.println("<input type=\"radio\" name=\"command\" value=\"changeUsername\"/>Change Username");
			out.println("<br>");
			out.println("<input type=\"radio\" name=\"command\" value=\"changeEmail\"/>Change Email");
			out.println("<br>");
			out.println("<input type=\"radio\" name=\"command\" value=\"changePassword\"/>Change Password");
			out.println("<br>");
			out.println("<input type=\"submit\" value=\"Continue\" />");
			out.println("</form>");
			
			
			out.println("<br>");
			out.println("<br>");
			
			out.println("<a href='customer_rep_main_page.jsp?username="+username+"&password="+password+"'>Click here to go back to customer rep home page</a>");
		%>
		
		<br>
		<br>
		<a href='index.jsp' >Logout</a> 
	

	</body>
</html>
