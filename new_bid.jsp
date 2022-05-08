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
			String auctionID = (String) request.getSession().getAttribute("auctionID");
			String price = request.getParameter("price");
            
			String SQLstr = "SELECT COUNT(*) AS count FROM bid WHERE Auction_ID = "+auctionID+";";
			ResultSet result = stmt.executeQuery(SQLstr);
			result.next();
			if(result.getInt("count") == 0){
				//no bid
				String insert = "INSERT INTO Bid VALUES (NULL, ?, ?, ?, 'Manual', NOW())";
				PreparedStatement ps = con.prepareStatement(insert);
 				ps.setString(1, Auction_ID) ;
 				ps.setString(2, username) ;
				ps.setString(3, price);
				ps.executeUpdate();
				out.println("You have placed your bid sccessfully!");
			}else{
				//there is bid already
				SQLstr = "SELECT * FROM bid WHERE Auction_ID = "+auctionID+" ORDER BY Price DESC LIMIT 1;";
				result = stmt.executeQuery(SQLstr);
				result.next();
				int highestPrice = result.getInt("Price");

				if(Integer.parseInt(upperLimit) <= highestPrice){
					//wrong input
					out.println("Your price has to be higher than current price. Please re-bid.");
				}else{
					//correct input
					String insert = "INSERT INTO Bid VALUES (NULL, ?, ?, ?, 'Manual', NOW())";
					PreparedStatement ps = con.prepareStatement(insert);
					ps.setString(1, Auction_ID) ;
					ps.setString(2, username) ;
					ps.setString(3, price) ;
					ps.executeUpdate();
					out.println("You have placed your bid sccessfully!");
					//alert other buyers for higher bid
					SQLstr = "SELECT Username FROM bid WHERE Username != '"+username+"' AND Auction_ID = "+auctionID+" ORDER BY Price DESC LIMIT 1;";
					result = stmt.executeQuery(SQLstr);
					result.next();
					String otherUsername = result.getString("Username");
					insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
					PreparedStatement ps = con.prepareStatement(insert);
					ps.setString(1, otherUsername) ;
					ps.setString(2, "'There is a higher bid for Auction #"+auctionID+"'") ;
					ps.executeUpdate();
					//alert other buyers for higher bid than upper limit
					SQLstr = "SELECT Username FROM Auto_Bid WHERE Auction_ID = "+auctionID+" AND Upper_Limit < "+price+" AND Username != '"+username+"';";
					result = stmt.executeQuery(SQLstr);
					while(result.next()){
						otherUsername = result.getString("Username");
						insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
						ps = con.prepareStatement(insert);
						ps.setString(1, otherUsername) ;
						ps.setString(2, "'There is a higher bid exceeding your upper limit for Auction #"+auctionID+"'") ;
						ps.executeUpdate();
					}
					
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