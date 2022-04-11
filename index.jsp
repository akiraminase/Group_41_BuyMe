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
		<form method="post" action="redirect.jsp">
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
out.println( " <a href='new account registration.html' >register here </a> " );
</body>
</html>