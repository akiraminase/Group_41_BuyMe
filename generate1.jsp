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
			String reportType = request.getParameter("typeReport");
			
			if (reportType.equals("total-earnings")){
				String str = "SELECT Closing_Price FROM Auction WHERE Closing_Price >= Minimum_Price AND DATE(Closing_Time) < DATE(NOW()); ";
				ResultSet result = stmt.executeQuery(str);
				double count = 0;
				try{
					while (result.next()){
						count += result.getDouble("Closing_Price");
					}
					
					out.println("Current Total Earnings For All Users: $" + count);
				} catch (Exception e){
	                out.print(e);
				}
			}
			else if (reportType.equals("earnings-per")){
				out.println("<form method=\"get\" action=\"generate2.jsp\">");
				out.println("<input type=\"radio\" name=\"command\" value=\"item\"/>Choose this for earnings per item");
				out.println("<br>");
				out.println("<input type=\"radio\" name=\"command\" value=\"itemType\"/>Choose this for earnings per item type");
				out.println("<br>");
				out.println("<input type=\"radio\" name=\"command\" value=\"end-user\"/>Choose this for earnings per end-user");
				out.println("<br>");
				out.println("<input type=\"submit\" value=\"submit\" />");
				out.println("</form>");
			}
			else if (reportType.equals("best-selling")){
				out.println("<form method=\"get\" action=\"generate2.jsp\">");
				out.println("<input type=\"radio\" name=\"command\" value=\"bestItems\"/>Choose this for best-selling items");
				out.println("<br>");
				out.println("<input type=\"radio\" name=\"command\" value=\"bestBuyers\"/>Choose this for best buyers");
				out.println("<br>");;
				out.println("<input type=\"submit\" value=\"submit\" />");
				out.println("</form>");
			}
			//close the connection.
			db.closeConnection(con);
			} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<br>
		<br>
		<a href='main_administrator_page.jsp?username=administrator&password=admin_password_123' >Return to home administrator page </a>
		<br>
		<a href='index.jsp' >Logout</a> 
	

	</body>
</html>
