<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
try {
	  	
	String Item_Condition = request.getParameter("Item_Condition");
	float Initial_Price =  Float.valueOf(request.getParameter("Initial_Price"));
	float Minimum_Price = Float.valueOf(request.getParameter("Minimum_Price"));
	String Closing_Time = request.getParameter("Closing_Time");
	String make = request.getParameter("make");
	String model = request.getParameter("model");
	String yearofcar = request.getParameter("yearofcar");
String description = request.getParameter("description") ;
	
	
	
	
String username = (String) request.getSession().getAttribute("username");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme","root", "butter70");
Statement stmt = con.createStatement();
String insert = "INSERT INTO Item(Item_ID, Make, Model, Year, Item_Condition )"
		+ "VALUES (NULL, ?, ?, ?, ?)";
PreparedStatement ps = con.prepareStatement(insert);
 ps.setString(1, make) ;
 ps.setString(2, model) ;
 ps.setString(3, yearofcar) ;
 ps.setString(4, Item_Condition) ;
 ps.executeUpdate();
int Item_ID = 0 ;
ResultSet rs=ps.executeQuery("SELECT * FROM Item ORDER BY Item_ID DESC Limit 1;"); 
while(rs.next()) {
	 Item_ID = rs.getInt(1) ;
}
insert = "INSERT INTO Auction(Auction_ID, Item_ID, Initial_Price, Minimum_Price, Closing_Time, Closing_price, Start_Time, Winner)"
		+ "VALUES (NULL, ?, ?, ?, ?, Null, NOW(), NULL)";
ps = con.prepareStatement(insert);
ps.setInt(1, (Item_ID)) ;
ps.setFloat(2, Float.valueOf(Initial_Price));
ps.setFloat(3, Float.valueOf(Minimum_Price));
ps.setString(4, Closing_Time) ;
ps.executeUpdate();
int Auction_ID = 0 ;
rs=ps.executeQuery("SELECT * FROM Auction ORDER BY Auction_ID DESC Limit 1;"); 
while(rs.next()) {
	 Auction_ID = rs.getInt(1) ;
}
insert = "INSERT INTO Post(Post_ID, Auction_ID, username,  Description)" 
		 + "VALUES (NULL, ?, ?, ?)";
ps = con.prepareStatement(insert);
ps.setInt(1, (Auction_ID)) ;
ps.setString(2, username) ;
ps.setString(3, description) ;
ps.executeUpdate();
//alert other users of new item
String SQLstr = "SELECT Username FROM Item_Alert_Manager WHERE Make = '"+make+"' AND Model = '"+model+"' AND Year ='"+yearofcar+"' AND Username != '"+username+"';";
ResultSet result = stmt.executeQuery(SQLstr);
while(result.next()){
String	otherUsername = result.getString("Username");
	insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
	ps = con.prepareStatement(insert);
	ps.setString(1, otherUsername) ;
	ps.setString(2, "There is a new item posted for your "+yearofcar+" "+make+" "+model+" at Auction #"+Auction_ID) ;
	ps.executeUpdate();
}
con.close();
out.println( " <a href='index.jsp' >return to main page </a> " );
 }
 catch (Exception e){
		out.print(e); }
		
		
		
		%>
