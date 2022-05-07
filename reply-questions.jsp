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
			String test = "select * from Answer;";
			ResultSet testResult = stmt.executeQuery(test);
			
			String str = "select distinct(question_id), description from Question where question_id NOT IN (select question_id from Answer);";
			if (!testResult.next()){
				str = "select q.question_id, q.description from Question q;";
			}
			
			ResultSet result = stmt.executeQuery(str);
			if (!result.next()){
				out.println("No Questions To Be Answered Right Now");
			}
			else{
			result = stmt.executeQuery(str);
			out.println("Choose a Question To Reply To:");
			out.println("<br><br>");
			out.println("<form method=\"get\" action=\"prompt.jsp\">");
			out.println("<select name=\"question-id\" size=1>");
			while(result.next()){
				out.println("<option value=\"" + result.getInt("question_id") +"\">" +  result.getString("description") + "</option>");
			}
			out.println("<br><br>");
			out.println("</select>&nbsp;<br> <input type=\"submit\" value=\"Answer\">");
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
