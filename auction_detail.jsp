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
			String auctionID = request.getParameter("selected").split("#")[1];
			request.getSession().setAttribute("auctionID", auctionID);
            
			String SQLstr = "SELECT * FROM Auction, post, item WHERE Auction.Auction_ID = "+auctionID+" AND item.item_ID = auction.item_ID AND Auction.Auction_ID = Post.Auction_ID;";
			ResultSet result = stmt.executeQuery(SQLstr);
			try{
				result.next();
				out.println("<form method=\"post\" action=\"user_history.jsp\">");
				out.println(
                "<table><Caption>Auction Detail</Caption><tr><td>Make: "+ result.getString("Make")+"</td></tr>"+
                "<tr><td>Model: "+ result.getString("Model")+"</td></tr>"+
                "<tr><td>Year: "+ result.getString("Year")+"</td></tr>"+
                "<tr><td>Condition: "+ result.getString("Item_Condition")+"</td></tr>"+
                "<tr><td>Initial Price: "+ result.getString("Initial_Price")+"</td></tr>"+
                "<tr><td>Close Time: "+ result.getString("Closing_Time")+" </td></tr>"+
				"<tr><td>Seller: <a href='user_history.jsp?user="+result.getString("Username")+"'>"+result.getString("Username")+"</a></td></tr>"+
				"<tr><td>Winner: <a href='user_history.jsp?user="+result.getString("Winner")+"'>"+result.getString("Winner")+"</a></td></tr>"+
				"<tr><td>Description: "+ result.getString("Description")+"</td></tr></table></form>"
				);
			} catch (Exception e) {
				out.println(e);
			}
			out.println("<br>");
			out.println("<br>");
			out.println("<br>");
					
			out.println("Start a new bid");
			out.println("<br><form method=\"post\" action=\"new_bid.jsp\"><table>");
			out.println("<tr><td>Price</td><td><input type=\"text\" name=\"price\" required></td></tr>");
			out.println("</table><input type=\"submit\" value=\"Bid\"></form><br>");
			
			out.println("<br>");
			out.println("<br>");
			out.println("<br>");
			
			out.println("Set up automatic bid");
			out.println("<br><form method=\"post\" action=\"new_autobid.jsp\"><table>");
			out.println("<tr><td>Upper Limit</td><td><input type=\"text\" name=\"upperLimit\" required></td></tr>");
			out.println("<tr><td>Increment</td><td><input type=\"text\" name=\"increment\" required></td></tr>");
			out.println("</table><input type=\"submit\" value=\"Set\"></form><br>");
				
			SQLstr = "SELECT * FROM bid WHERE Auction_ID ="+auctionID+" ORDER BY Biding_Time DESC;";
			result = stmt.executeQuery(SQLstr);
			out.println("<form method=\"post\" action=\"user_history.jsp\"><table><Caption>Bid History</Caption>");
            while(result.next()){
                out.println(
				"<tr><td>Username: <a href='user_history.jsp?user="+result.getString("Username")+"'>"+result.getString("Username")+"</a></td></tr>"+
                "<tr><td>Bid Price: "+ result.getString("Price")+"</td></tr>"+
                "<tr><td>Bid Time: "+ result.getString("Biding_Time")+" </td></tr>");
                out.println("<br><br><br>");
			}
            out.println("</table></form>");
		}catch(Exception e) {
				out.println(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>