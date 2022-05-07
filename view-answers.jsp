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
		
		try {

			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String str = "select q.description as Question,a.description as Answer,a.customer_representative from Question q, Answer A where q.question_id = a.question_id;";
			ResultSet result = stmt.executeQuery(str);
			
			out.println("QUESTION   ---->    ANSWER    ---->    ANSWERED BY");
			out.println("<br>");
			out.println("<br>");
			while(result.next()){
				out.println(result.getString("Question") + "    ---->    "+ result.getString("Answer") + "    ---->    "+ result.getString("customer_representative"));
				out.println("<br>");
			}
			//close the connection.
			db.closeConnection(con);
			} catch (Exception e) {
			out.print(e);
		}
		
		out.println("<br><br>");
		out.println("<a href='main_page.jsp?username="+username+"&password="+password+"'>Click here to go back to home page</a>");
		%>
		<br>
		<br>
		<a href='index.jsp' >Logout</a> 
	

	</body>
</html>
