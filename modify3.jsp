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
			String command = request.getParameter("command");
			
			if (command.equals("delete")){
				try{
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();
					Statement stmt = con.createStatement();
					
					String str = "delete from end_user where username = \"" + modify_username + "\"";
					stmt.executeUpdate(str);
					out.println("User Deleted");
					
					db.closeConnection(con);
				}catch (Exception e){
					out.println(e);
				}
			}
			else if (command.equals("changeUsername")){
				out.println("Enter new username:");
				out.println("<br>");
				out.println("<form action=\"modify4.jsp\" method = \"post\">");
				out.println("<input type=\"text\" name=newUsername />");
				out.println("<br><br>");
			    out.println("<input type=\"submit\" value=\"Change Username\"/>");
				out.println("</form>");
			}
			else if (command.equals("changeEmail")){
				out.println("Enter new email:");
				out.println("<br>");
				out.println("<form action=\"modify4.jsp\" method = \"post\">");
				out.println("<input type=\"text\" name=newEmail />");
				out.println("<br><br>");
			    out.println("<input type=\"submit\" value=\"Change Email\"/>");
				out.println("</form>");
			}
			else if (command.equals("changePassword")){
				out.println("Enter new password:");
				out.println("<br>");
				out.println("<form action=\"modify4.jsp\" method = \"post\">");
				out.println("<input type=\"text\" name=newPassword />");
				out.println("<br><br>");
			    out.println("<input type=\"submit\" value=\"Change Password\"/>");
				out.println("</form>");
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
