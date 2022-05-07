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
			out.println("<form method=\"post\" action=\"answer_search_result.jsp\">");
			out.println("Search Keyword: <input type=\"text\" name=\"keyword\" required>");
			out.println("<input type=\"submit\" value=\"Search\"><br>");
			out.println("<table><Caption>Q&A</Caption>");
			while(result.next()){
				out.println(
				"<tr><td>Question: "+ result.getString("Question")+"</td></tr>"+
                "<tr><td>Answer: "+ result.getString("Answer")+"</td></tr>"+
                "<tr><td>Answered By: "+ result.getString("customer_representative")+"</td></tr>");
				out.println("<br>");
			}
			out.println("</table></form>");
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
