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
			
			String str = "select auction_id, item_id, start_time, closing_time from auction";
			
			ResultSet result = stmt.executeQuery(str);
			if (!result.next()){
				out.println("No auctions available to delete");
			}
			else{
			result = stmt.executeQuery(str);
			out.println("Choose one of the following auctions to delete: (Auctions are in the format -> Auction ID : Item ID : Start Time : Closing Time)");
			out.println("<br><br>");
			out.println("<form method=\"get\" action=\"delete-auction2.jsp\">");
			out.println("<select name=\"auction-id\" size=1>");
			while(result.next()){
				out.println("<option value=\"" + result.getInt("auction_id") +"\">" +  result.getInt("auction_id") + " : " + result.getInt("item_id") + " : " + result.getDate("start_time") + " : " + result.getDate("closing_time") + "</option>");
			}
			out.println("<br>");
			out.println("<br>");
			out.println("</select>&nbsp;<br> <input type=\"submit\" value=\"Delete Auction\">");
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
