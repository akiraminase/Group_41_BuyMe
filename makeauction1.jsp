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
	
	
	String username = (String) request.getSession().getAttribute("username");
	
	 Class.forName("com.mysql.jdbc.Driver");
			
	 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme","root", "butter70");
Statement stmt = con.createStatement();




String insert = "INSERT INTO Auction(Initial_Price, Minimum_Price, Closing_Time )"
		+ "VALUES (?, ?, ?)";
PreparedStatement ps = con.prepareStatement(insert);

ps.setFloat(1, Initial_Price);
ps.setFloat(2, Minimum_Price);
ps.setString(3, Closing_Time) ;

ps.executeUpdate();


 insert = "INSERT INTO Item(Category_Level1, Category_Level2, Category_Level3, Item_Condition )"
		+ "VALUES (?, ?, ?, ?)";
 ps = con.prepareStatement(insert);
 ps.setString(1, make) ;
 ps.setString(2, model) ;
 ps.setString(3, yearofcar) ;
 ps.setString(4, Item_Condition) ;
 ps.executeUpdate();
 
 
 
 insert = "INSERT INTO Post( username)" 
		 + "VALUES (?)";
 ps = con.prepareStatement(insert);
 ps.setString(1, username) ;

 ps.executeUpdate();
//insert = "INSERT INTO Item(Item_Condition)"
	//	+ "VALUES (?)";

//ps = con.prepareStatement(insert);
//ps.setString(1,Item_Condition );
//ps.executeUpdate();

con.close();
//int insert=stmt.executeUpdate("insert into Auction( Inital_Price, Minimum_Price, Closing_Time)values('"+Inital_Price+"','"+Minimum_Price+"','"+Closing_Time+"')");
//int insert2=stmt.executeUpdate("insert into Item(Item_Condition)values('"+Item_Condition+"')"); 

 }
 catch (Exception e){
		out.print(e); }
		
		
		
		%>
