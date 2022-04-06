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
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			//Make a SELECT query from the table specified by the  parameter at the index.jsp
			String str = "SELECT * FROM end_user WHERE Username = '"+username+"';";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			try{
				result.next();
				if(result.getString("Password").equals(password)){
					out.println("Login Success! ");
					out.println( " <a href='index.jsp' >logout </a> " );
				}else{
					out.print("Wrong Password");
				}
			} catch (Exception e){
				out.print("Username doesn't exist");
			}
			//close the connection.
			db.closeConnection(con);
			
			} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>