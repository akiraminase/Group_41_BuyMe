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
			String reportType = request.getParameter("command");
			
			if (reportType.equals("end-user")){
				String tempTableQuery = "select e.username, a.closing_price from Seller e, Post p, Auction a WHERE e.Username = p.Username AND p.Auction_ID = a.Auction_ID AND DATE(a.closing_time) < DATE(NOW()) AND a.closing_price >= a.minimum_price";
				String str = "select temp.username, sum(temp.closing_price) as earnings from (" + tempTableQuery + ") as temp group by temp.username;";
				ResultSet result = stmt.executeQuery(str);
				out.println("Username ---> Earnings");
				out.println("<br>");
				out.println("<br>");
				while (result.next()){
					out.println(result.getString("username") + " ----> $" + result.getDouble("earnings"));
					out.println("<br>");
				}
			}
			else if (reportType.equals("item")){
				String tempTableQuery = "select i.make, a.closing_price from Item i, Auction a where i.item_id = a.item_id AND DATE(a.closing_time) < DATE(NOW()) AND a.closing_price >= a.minimum_price";
				String str = "select temp.make as Item, sum(temp.closing_price) as Earnings from (" + tempTableQuery + ") as temp group by temp.make;";
				ResultSet result = stmt.executeQuery(str);
				out.println("Item  --->  Earnings");
				out.println("<br>");
				out.println("<br>");
				while (result.next()){
					out.println(result.getString("Item") + "  ---->  $" + result.getDouble("Earnings"));
					out.println("<br>");
				}
				
			}
			else if (reportType.equals("itemType")){
				String tempTableQuery = "select i.model, a.closing_price from Item i, Auction a where i.item_id = a.item_id AND DATE(a.closing_time) < DATE(NOW()) AND a.closing_price >= a.minimum_price";
				String str = "select temp.model as Item_Type, sum(temp.closing_price) as Earnings from (" + tempTableQuery + ") as temp group by temp.model;";
				ResultSet result = stmt.executeQuery(str);
				out.println("Item Type  --->  Earnings");
				out.println("<br>");
				out.println("<br>");
				while (result.next()){
					Statement stmt2 = con.createStatement();
					String str2 = "select make from Item where model = \"" + result.getString("Item_Type") + "\"";
					ResultSet result2 = stmt2.executeQuery(str2);
					result2.next();
					String brand = result2.getString("make");
					out.println(brand + " " + result.getString("Item_Type") + "  ---->  $" + result.getDouble("Earnings"));
					out.println("<br>");
				}
			}
			else if (reportType.equals("bestItems")){
				String str = "select i.make, i.model, i.year, i.item_condition, a.closing_price from Item i, Auction a where i.item_id = a.item_id AND DATE(a.closing_time) < DATE(NOW()) AND a.closing_price >= a.minimum_price order by a.closing_price DESC;";
				ResultSet result = stmt.executeQuery(str);
				out.println("Item  ---->  Price");
				out.println("<br>");
				out.println("<br>");
				while (result.next()){
					out.println(result.getString("make") + " " + result.getString("model") + " " + result.getString("year") + ", " + result.getString("item_condition") + "  ---->  $" + result.getString("closing_price"));
					out.println("<br>");
				}
			}
			else if (reportType.equals("bestBuyers")){
				String str = "select b.username, sum(a.closing_price) as total_spent from Auction a, Bid b where a.auction_id = b.auction_id AND a.closing_price = b.price group by b.username order by sum(a.closing_price) DESC;";
				ResultSet result = stmt.executeQuery(str);
				out.println("Buyer username  ---->  Total Spent");
				out.println("<br>");
				out.println("<br>");
				while (result.next()){
					out.println(result.getString("username") + "  ---->  $" + result.getString("total_spent"));
					out.println("<br>");
				}
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
