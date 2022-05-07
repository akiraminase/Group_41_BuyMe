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

			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String username = request.getParameter("username");
			String password = request.getParameter("password");


            //get unread alert numbers
			String str = "SELECT * FROM Customer_Representative WHERE Username = '"+username+"';";
			ResultSet result = stmt.executeQuery(str);

			try{
				result.next();
				if(result.getString("Password").equals(password)){
                    request.getSession().setAttribute("username", username);
                    request.getSession().setAttribute("password", password);
					
                    out.println("Welcome customer rep: " + username + "\n");
                    out.println("<br>");
                    out.println("<br>");
                    
					out.println("<form method=\"post\" action=\"reply-questions.jsp\">");
					out.println("<input type=\"submit\" value=\"Click here to reply to user questions\"/>");
					out.println("</form>");
					
					out.println("<br>");
					out.println("<br>");
					
					out.println("<form method=\"post\" action=\"modify-account.jsp\">");
					out.println("<input type=\"submit\" value=\"Click here to modify user accounts\"/>");
					out.println("</form>");
					
					out.println("<br>");
					out.println("<br>");
					
					out.println("<form method=\"post\" action=\"delete-bid.jsp\">");
					out.println("<input type=\"submit\" value=\"Click here to remove bids\"/>");
					out.println("</form>");
					
					out.println("<br>");
					out.println("<br>");
					
					out.println("<form method=\"post\" action=\"delete-auction.jsp\">");
					out.println("<input type=\"submit\" value=\"Click here to remove auctions\"/>");
					out.println("</form>");
				}else{
					out.print("Wrong Customer Representative Password");
				}
			} catch (Exception e){
				out.print("Wrong Customer Representative Username!\n");
                out.print(e);
			}
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
