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
			String questionID = request.getParameter("question-id");
			request.getSession().setAttribute("question-id", questionID);
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String test = "select * from Answer;";
			ResultSet testResult = stmt.executeQuery(test);
			
			String str = "select description,end_user from Question where question_id = " + questionID + ";";

			ResultSet result = stmt.executeQuery(str);
			result.next();
			
			out.println(result.getString("description"));
			request.getSession().setAttribute("end-user", result.getString("end_user"));
			out.println("<br>");
			out.println("<br>");
			
			out.println("<form action=\"post-response.jsp\" method = \"post\">");
			out.println("<input type=\"text\" name= answer />");
		    out.println("<input type=\"submit\" value=\"Submit Answer\"/>");
		    out.println("<br><br>");
			out.println("</form>");
			
			
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
