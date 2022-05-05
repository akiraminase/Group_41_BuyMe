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
			String str = "SELECT * FROM end_user WHERE Username = '"+username+"';";
			ResultSet result = stmt.executeQuery(str);

			try{
				result.next();
				if(result.getString("Password").equals(password)){
                    request.getSession().setAttribute("username", username);
                    //TODO: check alert conditions and make alert by insert
                    out.println( "Welcome to BuyMe Car Auction Market!<br>" );
					String alertsql = "SELECT COUNT(*) AS Unread_Alert_N FROM Alert_Message, Alert WHERE Alert_Message.Alert_ID = Alert.Alert_ID AND Username = '"+username+"' AND Is_Read = 0;";
                    result = stmt.executeQuery(alertsql);
                    try{
						result.next();
                        out.println("Unread Alerts: "+result.getString("Unread_Alert_N")+"<br>");
                        out.println("<form method=\"post\" action=\"alert_manager.jsp\">");
                        out.println("<input type=\"submit\" value=\"View Alerts\"></form><br>");
                    }catch(Exception e){
                        out.println("Unread Alerts: Exception"+"<br>");;}
				
					
					//test if user is a buyer

					str = "SELECT * FROM buyer WHERE Username = '"+username+"';";
					result = stmt.executeQuery(str);
					try{
						result.next();
						if(result.getString("Username").equals(username)){
							out.println("<form method=\"post\" action=\"auction_search_result.jsp\">");
							out.println("<table><Caption>Start Your Search</Caption><tr><td>Make: </td><td><input type=\"text\" name=\"make\" required></td></tr>"
								+ "<tr><td>Model: </td><td><input type=\"text\" name=\"model\"required > </td></tr>"
								+ "<tr><td>Year: </td><td><input type=\"text\" name=\"year\"required></td></tr></table>");
							out.println("<label for=\"sortCategory\">Sort By:</label>");
							out.println("<select name=\"sortCategory\" id=\"sortCategory\">");
							out.println("<option value=\"Initial_Price\">Initial Price</option>");
							out.println("<option value=\"Current_Price\">Current Price</option>");
							out.println("<option value=\"Closing_Time\">Closing Time</option></select>");
							//out.println("");
							out.println("<label for=\"sortOrder\">Order:</label>");
							out.println("<select name=\"sortOrder\" id=\"sortOrder\">");
							out.println("<option value=\"ASC\">Ascending</option>");
							out.println("<option value=\"DESC\">Descending</option></select>");
							//out.println("");
                            out.println("<input type=\"submit\" value=\"Search\"></form><br>");
							
           					//String[] searchStrs = new String[3];
							//request.setAttribute("searchStrs", searchStrs);
						}

                        String SQLstr = "SELECT Auction.Auction_ID, Category_LEVEL1 AS Make, Category_LEVEL2 As Model, Category_LEVEL3 AS Year, Item_Condition, Closing_Time, Initial_Price, MAX(Price) AS Current_Price "
                           + "FROM Auction, Item, Bid "
                           + "WHERE Start_Time<=NOW() AND Closing_Time >= NOW() AND "
                           + "Auction.Item_ID = Item.Item_ID AND "
                           + "Auction.Auction_ID = Bid.Auction_ID "
                           + "GROUP BY Auction.Auction_ID ";

                        result = stmt.executeQuery(SQLstr);
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
                            "<tr><td>Close Time: "+ result.getString("Closing_Price")+" </td></tr>"+
                            "<tr><td><input type=\"submit\" value=\"View\"></td></tr>");
                            out.println("<br><br><br>");
			            }
                        out.println("</table></form>");


					}catch (Exception e){;}
					
					
                    str = "SELECT * FROM seller WHERE Username = '"+username+"';";
					result = stmt.executeQuery(str);
					try{
						result.next();
						if(result.getString("Username").equals(username)){
							out.println( " <a href='sellerpage.jsp' >Enter seller mode </a><br> " );
						}
					}catch (Exception e){
						;//do nothing
					}

				}else{
					out.print("Wrong Password");
				}
			} catch (Exception e){
				out.print("Username doesn't exist");
                out.print(e);
			}
			//close the connection.
			db.closeConnection(con);
			out.println( " <a href='index.jsp' >Logout </a> " );
			} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>