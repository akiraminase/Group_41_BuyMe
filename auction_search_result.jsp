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
            String sortCategory = request.getParameter("sortCategory");
            String sortOrder = request.getParameter("sortOrder");
            String make = request.getParameter("make");
            String model = request.getParameter("model");
            String year = request.getParameter("year");
            
			String SQLstr = "SELECT * FROM (SELECT Auction.Auction_ID, Make, Model, Year, Item_Condition, Closing_Time, Initial_Price, MAX(Price) AS Current_Price "
                           + "FROM Auction, Item, Bid "
                           + "WHERE Start_Time<=NOW() AND Closing_Time >= NOW() AND "
                           + "Auction.Item_ID = Item.Item_ID AND "
                           + "Auction.Auction_ID = Bid.Auction_ID AND "
                           + "Make = '"+make+"' AND "
                           + "Model = '"+model+"' AND "
                           + "Year = '"+year+"' "
                           + "GROUP BY Auction.Auction_ID "
                           + "UNION SELECT Auction.Auction_ID, Make, Model, Year, Item_Condition, Closing_Time, Initial_Price, Initial_Price AS Current_Price "
						   + "FROM Auction, Item WHERE Start_Time<=NOW() AND Closing_Time >= NOW() AND "
                           + "Make = '"+make+"' AND "
                           + "Model = '"+model+"' AND "
                           + "Year = '"+year+"' AND "
						   + "Auction.Item_ID = Item.Item_ID AND Auction_ID NOT IN (SELECT DISTINCT Auction_ID FROM Bid))a"
                           + " ORDER BY "+sortCategory+" "+sortOrder+";";

            //out.println(SQLstr);
            
            
            //out.println("<option value=\"Year\">Year</option>");
 

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(SQLstr);
            //HttpSession session = request.getSession(); 
            out.println("<form method=\"post\" action=\"auction_detail.jsp\"><table><Caption>Current Auctions</Caption>");
            while(result.next()){
                String auctionID = result.getString("Auction_ID");
                //session.setAttribute("auctionID", auctionID);
                out.println(
				"<tr><td>Make: "+ result.getString("Make")+"</td></tr>"+
                "<tr><td>Model: "+ result.getString("Model")+"</td></tr>"+
                "<tr><td>Year: "+ result.getString("Year")+"</td></tr>"+
                "<tr><td>Condition: "+ result.getString("Item_Condition")+"</td></tr>"+
                "<tr><td>Initial Price: "+ result.getString("Initial_Price")+"</td></tr>"+
                "<tr><td>Current Price: "+ result.getString("Current_Price")+" </td></tr>"+
                "<tr><td>Close Time: "+ result.getString("Closing_Time")+" </td></tr>"+
                "<tr><td><input type='submit' value='View Auction #"+auctionID+"' name='selected'></td></tr>");
                out.println("<br><br><br>");
			}
            out.println("</table></form>");
            out.println("<a href='similar_auctions.jsp' >View Similar Items</a>");
            String similarSQLstr = "SELECT Auction.Auction_ID, Make, Model, Year, Item_Condition, Start_Time, Closing_Time, Initial_Price "
                           + "FROM Auction, Item "
                           + "WHERE MONTH(Start_Time)=MONTH(NOW())+1 AND Closing_Time >= NOW() AND "
                           + "Auction.Item_ID = Item.Item_ID AND "
                           + "Make = '"+make+"' AND "
                           + "Model = '"+model+"' "
                           + "ORDER BY "+sortCategory+" "+sortOrder+";";
            request.getSession().setAttribute("similarSQLstr", similarSQLstr);
			//close the connection.
			db.closeConnection(con);
			
			} catch (Exception e) {
			out.print(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>