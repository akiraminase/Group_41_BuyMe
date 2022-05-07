<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html>
<html>
	<head>
		<meta content="charset=ISO-8859-1">
		<title>BuyMe Login</title>
	</head>
	
	Please enter your username and password to login to the BuyMe site:
	<br>
		<form method="post" action="main_page.jsp">
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
<a href='new account registration.html' >register here </a>
<br>
<a href='administrator-login.jsp'>Click here to login as an administrator</a>
<br>
<a href='customer-representative-login.jsp'>Click here to login as a customer representative</a>
</body>
</html>