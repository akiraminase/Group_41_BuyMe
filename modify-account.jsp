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
		<% try {
			String username = (String)request.getSession().getAttribute("username");
			String password = (String)request.getSession().getAttribute("password");
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String str = "select username from end_user";
			
			ResultSet result = stmt.executeQuery(str);
			if (!result.next()){
				out.println("No users currently registered");
			}
			else{
			result = stmt.executeQuery(str);
			out.println("Choose a User Account to Modify:");
			out.println("<br><br>");
			out.println("<form method=\"get\" action=\"modify2.jsp\">");
			out.println("<select name=\"modify-username\" size=1>");
			while(result.next()){
				out.println("<option value=\"" + result.getString("username") +"\">" +  result.getString("username") + "</option>");
			}
			out.println("<br>");
			out.println("<br>");
			out.println("</select>&nbsp;<br> <input type=\"submit\" value=\"Modify\">");
			out.println("</form>");
			out.println("<br>");
			}
			
			
			out.println("<br>");
			out.println("<br>");
			
			out.println("<a href='customer_rep_main_page.jsp?username="+username+"&password="+password+"'>Click here to go back to customer rep home page</a>");
			//close the connection.
			db.closeConnection(con);
			} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<br>
		<a href='index.jsp' >Logout</a> 
	

	</body>
</html>
