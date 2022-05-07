<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%

 String username=request.getParameter("username") ; 
 String password=request.getParameter("password") ; 
 String email=request.getParameter("email") ; 
 String adminUsername = (String)request.getSession().getAttribute("username");
 
 try {
	 
	 ApplicationDB db = new ApplicationDB();	
	 Connection con = db.getConnection();
	 Statement stmt = con.createStatement();

	 stmt.executeUpdate("insert into Customer_Representative( Username, Email, Password, Created_By) values ('"+username+"','"+email+"','"+password+"','" + adminUsername + "');");
	 out.println("Customer Representative Account Successfully Created!\n\n");
	 db.closeConnection(con);
 }
 catch (SQLException ex){
	 if (ex.getSQLState().startsWith("23")){
		 out.println("An account with this username already exists\n\n");
	 }
 }
 catch (Exception e){
		out.print(e); 
}
 
 	
%> 
<br>
<br>
<br>
<a href='main_administrator_page.jsp?username=administrator&password=admin_password_123' >Return to home administrator page </a>
<br>
<a href='index.jsp' >Logout </a>