<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
	<head>
		<meta content="charset=ISO-8859-1">
		<title>Search Result</title>
	</head>
	<body class="main">
		<% try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();

            String username = (String) request.getSession().getAttribute("username");

			String alertsql = "SELECT Sent_Time, Message FROM Alert LEFT JOIN Buyer ON alert.username = buyer.username WHERE Sent_Time> last_read_time AND alert.Username = '"+username+"';";
			ResultSet result = stmt.executeQuery(SQLstr);
            out.println("<table><Caption>Current Alerts</Caption>");
            while(result.next()){
                out.println(
				"<tr><td>Time: "+ result.getString("Sent_Time")+"</td></tr>"+
				"<tr><td>Message: "+ result.getString("Message")+"</td></tr>");
                out.println("<br>");
				out.println("<br>");
			}
			out.println("</table>");
			//Update last_read time
			String update = "UPDATE Buyer SET Last_read_time = NOW() WHERE username ='"+username+"';";
			PreparedStatement ps = con.prepareStatement(update);
			ps.executeUpdate();

            out.println("<form method=\"post\" action=\"item_alert_result.jsp\">");
							out.println("<table><Caption>New Item Alert</Caption><tr><td>Make: </td><td><input type=\"text\" name=\"make\" required></td></tr>"
								+ "<tr><td>Model: </td><td><input type=\"text\" name=\"model\"required > </td></tr>"
								+ "<tr><td>Year: </td><td><input type=\"text\" name=\"year\"required></td></tr></table>");
                            out.println("<input type=\"submit\" value=\"Create Alert\"></form><br>");
			db.closeConnection(con);
			
			} catch (Exception e) {
			out.print(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>