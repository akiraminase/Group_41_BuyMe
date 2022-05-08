<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="Bider"%>


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
			String auctionID = (String) request.getSession().getAttribute("auctionID");
			String price = request.getParameter("price");
            
			String SQLstr = "SELECT COUNT(*) AS count FROM bid WHERE auction_ID = "+auctionID+";";
			ResultSet result = stmt.executeQuery(SQLstr);
			result.next();
			if(result.getInt("count") == 0){
				//no bid
				String insert = "INSERT INTO Bid VALUES (NULL, ?, ?, ?, NOW())";
				PreparedStatement ps = con.prepareStatement(insert);
 				ps.setInt(1, Integer.parseInt(auctionID)) ;
 				ps.setString(2, username) ;
				ps.setFloat(3, Float.valueOf(price));
				ps.executeUpdate();
				out.println("You have placed your bid sccessfully!");
			}else{
				//there is bid already
				SQLstr = "SELECT * FROM bid WHERE auction_ID = "+auctionID+" ORDER BY Price DESC LIMIT 1;";
				result = stmt.executeQuery(SQLstr);
				result.next();
				int highestPrice = result.getInt("Price");

				if(Integer.parseInt(upperLimit) <= highestPrice){
					//wrong input
					out.println("Your price has to be higher than current price. Please re-bid.");
				}else{
					//correct input
					//place bid
					Bider b = new Bider();
					b.bid(username, auctionID, price);
				}
			}

			out.println("<br><br>");
			out.println("<a href='auction_detail.jsp?username="+username+"&selected=View Auction #"+auctionID+">Click here to go back to auction details</a>");
		}catch(Exception e) {
				out.println(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>