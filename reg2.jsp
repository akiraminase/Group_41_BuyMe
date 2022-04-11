<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
String firstname=request.getParameter("firstname") ; 
String lastname=request.getParameter("lastname") ; 
 String username=request.getParameter("username") ; 
 String password=request.getParameter("password") ; 
 String email=request.getParameter("email") ; 
 String age=request.getParameter("age") ; 
 
 try {
	 
	 Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme","root", "putpasswordhere");
Statement stmt = con.createStatement();

int insert=stmt.executeUpdate("insert into end_user( username, email, password)values('"+username+"','"+email+"','"+password+"')"); 
 }
 catch (Exception e){
		out.print(e); }
 
 
 
 out.println( " <a href='index.jsp' >login here </a> " );



%> 