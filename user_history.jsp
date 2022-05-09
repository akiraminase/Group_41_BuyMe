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

            String username = (String) request.getParameter("user");
			//out.println(username);
			String SQLstr = "SELECT * FROM bid, auction, item WHERE username = '"+username+"' AND bid.Auction_id = Auction.Auction_ID AND Auction.Item_ID = Item.Item_ID GROUP BY Auction.Auction_ID";
			ResultSet result = stmt.executeQuery(SQLstr);
            out.println("<form method=\"post\" action=\"auction_detail.jsp\"><table><Caption>User Auctions</Caption>");
            while(result.next()){
                String auctionID = result.getString("Auction_ID");
                //session.setAttribute("auctionID", auctionID);
                out.println(
				"<tr><td>Make: "+ result.getString("Make")+"</td></tr>"+
                "<tr><td>Model: "+ result.getString("Model")+"</td></tr>"+
                "<tr><td>Year: "+ result.getString("Year")+"</td></tr>"+
                "<tr><td>Condition: "+ result.getString("Item_Condition")+"</td></tr>"+
				"<tr><td>Close Time: "+ result.getString("Closing_Time")+" </td></tr>"+
                "<tr><td>Bid Time: "+ result.getString("Biding_Time")+" </td></tr>"+
				"<tr><td>Initial Price: "+ result.getString("Initial_Price")+"</td></tr>"+
				"<tr><td>Bid Price: "+ result.getString("Price")+" </td></tr>"+
                "<tr><td><input type='submit' value='View Auction #"+auctionID+"' name='selected'></td></tr>");
                out.println("<br><br><br>");
			}
			out.println("</table></form>");
		}catch(Exception e){
			out.println(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>