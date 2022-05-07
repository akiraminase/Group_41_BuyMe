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
            
			String SQLstr = "SELECT * FROM Alert_Message, Alert WHERE Alert_Message.Alert_ID = Alert.Alert_ID AND Username = '"+username+"' AND Is_Read = 0;";
            
			ResultSet result = stmt.executeQuery(SQLstr);
            out.println("<form method=\"post\" action=\"auctiondetail.jsp\"><table><Caption>Current Alerts</Caption>");
            while(result.next()){
                String auctionID = result.getString("Auction_ID");
                out.println(
				"<tr><td>Time: "+ result.getString("Sent Time")+"</td></tr>"+
                "<tr><td>Model: "+ result.getString("Model")+"</td></tr>"+
                "<tr><td>Year: "+ result.getString("Year")+"</td></tr>"+
                "<tr><td>Condition: "+ result.getString("Item_Condition")+"</td></tr>"+
                "<tr><td>Initial Price: "+ result.getString("Initial_Price")+"</td></tr>"+
                "<tr><td>Start Time: "+ result.getString("Starting_Time")+" </td></tr>"+
                "<tr><td>Close Time: "+ result.getString("Closing_Time")+" </td></tr>"+
                "<tr><td><input type=\"submit\" value=\"View\"></td></tr>");
                out.println("<br><br><br>");
			}
            //stmt.executeQuery("UPDATE Alert_Message SET Is_Read = 1 WHERE Is_Read = 0;");
            out.println("<form method=\"post\" action=\"buyerpage.jsp\">");
							out.println("<table><Caption>New Item Alert</Caption><tr><td>Make: </td><td><input type=\"text\" name=\"make\" required></td></tr>"
								+ "<tr><td>Model: </td><td><input type=\"text\" name=\"model\"required > </td></tr>"
								+ "<tr><td>Year: </td><td><input type=\"text\" name=\"year\"required></td></tr></table>");
                            out.println("<input type=\"submit\" value=\"Create Alert\"></form><br>");
			//TODO: add insert statement
			db.closeConnection(con);
			
			} catch (Exception e) {
			out.print(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>