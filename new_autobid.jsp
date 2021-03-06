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
			String upperLimit = request.getParameter("upperLimit");
			String increment = request.getParameter("increment");
			String SQLstr = "SELECT Initial_Price AS price FROM Auction WHERE auction_ID = "+auctionID+";";
			ResultSet result = stmt.executeQuery(SQLstr);
			result.next();
			String price = request.getParameter("price");  

			SQLstr = "SELECT COUNT(*) AS count FROM bid WHERE auction_ID = "+auctionID+";";
			result = stmt.executeQuery(SQLstr);
			result.next();
			if(result.getInt("count") == 0){
				//no bid
				String insert = "INSERT INTO Bid VALUES (NULL, ?, ?, ?, NOW())";
				PreparedStatement ps = con.prepareStatement(insert);
 				ps.setInt(1, Integer.parseInt(auctionID)) ;
 				ps.setString(2, username) ;
				ps.setFloat(3, Float.valueOf(increment)+Float.valueOf(price)) ;
				ps.executeUpdate();
				out.println("You have set up your auto bid sccessfully!");
			}else{
				//there is bid already
				SQLstr = "SELECT * FROM bid WHERE auction_ID = "+auctionID+" ORDER BY Price DESC LIMIT 1;";
				result = stmt.executeQuery(SQLstr);
				result.next();
				float highestPrice = Float.valueOf(result.getString("Price"));
				if(Integer.parseInt(upperLimit) <= highestPrice+Integer.parseInt(increment)){
					//wrong input
					out.println("Your upper limit has to be higher than at least one increment of current price. Please re-enter.");
				}else{
					//correct input
					//place bid
					String insert = "INSERT INTO Bid VALUES (NULL, ?, ?, ?, NOW())";
					PreparedStatement ps = con.prepareStatement(insert);
					ps.setInt(1, Integer.parseInt(auctionID)) ;
					ps.setString(2, username) ;
					ps.setFloat(3, Float.valueOf(increment)+highestPrice) ;
					ps.executeUpdate();
					//insert autobid
					insert = "INSERT INTO Auto_Bid VALUES (NULL, ?, ?, ?, ?, NOW())";
					ps = con.prepareStatement(insert);
					ps.setInt(1, Integer.parseInt(auctionID)) ;
					ps.setString(2, username) ;
					ps.setFloat(3, Float.valueOf(upperLimit)) ;
					ps.setFloat(4, Float.valueOf(increment)) ;
					ps.executeUpdate();
					//alert other buyers for higher bid
					SQLstr = "SELECT Username FROM bid WHERE Username != '"+username+"' AND auction_ID = "+auctionID+" ORDER BY Price DESC LIMIT 1;";
					result = stmt.executeQuery(SQLstr);
					result.next();
					String otherUsername = result.getString("Username");
					insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
					ps = con.prepareStatement(insert);
					ps.setString(1, otherUsername) ;
					ps.setString(2, "'There is a higher bid for Auction #"+auctionID+"'") ;
					ps.executeUpdate();
					//alert other buyers for higher bid than upper limit
					SQLstr = "SELECT Username FROM Auto_Bid WHERE auction_ID = "+auctionID+" AND Upper_Limit < "+price+" AND Username != '"+username+"';";
					result = stmt.executeQuery(SQLstr);
					while(result.next()){
						otherUsername = result.getString("Username");
						insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
						ps = con.prepareStatement(insert);
						ps.setString(1, otherUsername) ;
						ps.setString(2, "'There is a higher bid exceeding your upper limit for Auction #"+auctionID+"'") ;
						ps.executeUpdate();
        			}
					out.println("You Automatic bid has been placed.");
				}
			}
			out.println("<br><br>");
			//out.println("<a href='auction_detail.jsp?username="+username+"&selected=View Auction #"+auctionID+">Click here to go back to auction details</a>");
		}catch(Exception e) {
				out.println(e);
		}%>
	</body>
</html>