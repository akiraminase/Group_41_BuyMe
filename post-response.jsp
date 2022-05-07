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
		
		String questionID = (String)request.getSession().getAttribute("question-id");
		String endUser = (String)request.getSession().getAttribute("end-user");
		String answer = request.getParameter("answer");
		
		try {

			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String str = "insert into answer (question_id, end_user, customer_representative, description) values (" + questionID + ", \"" + endUser +"\", \""+username+"\",\"" + answer + "\");";
			stmt.executeUpdate(str);
			out.println("Question Answered.");
			//close the connection.
			db.closeConnection(con);
			} catch (Exception e) {
			out.print(e);
		}
		
		out.println("<br><br>");
		out.println("<a href='customer_rep_main_page.jsp?username="+username+"&password="+password+"'>Click here to go back to customer rep home page</a>");
		%>
		<br>
		<br>
		<a href='index.jsp' >Logout</a> 
	

	</body>
</html>
