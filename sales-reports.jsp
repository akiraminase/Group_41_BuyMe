<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
 
 	
%> 

<form method="get" action="generate1.jsp">
			<select name="typeReport" size=1>
				<option value="total-earnings">Generate sales report for total earnings</option>
				<option value="earnings-per">Generate sales report for earnings per (item, item type, end-user)</option>
				<option value="best-selling">Generate sales report for best selling (items, buyers)</option>
			</select>&nbsp;<br> <input type="submit" value="Generate">
</form>

<br>
<a href='main_administrator_page.jsp?username=administrator&password=admin_password_123' >Return to home administrator page </a>
<br>
<a href='index.jsp' >Logout </a>