<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html>
<html>
	<head>
		<meta content="charset=ISO-8859-1">
		<title>BuyMe Customer Representative Login</title>
	</head>
	
	Please enter your username and password to login as a customer representative:
	<br>
		<form method="post" action="customer_rep_main_page.jsp">
			<table>
				<tr>
					<td>Username</td><td><input type="text" name="username" required></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="password" name="password" required></td>
				</tr>
			</table>
			<input type="submit" value="Login">
		</form>
	<br>
	<body>
<a href='index.jsp'>Click here to return to main login page</a>
</body>
</html>