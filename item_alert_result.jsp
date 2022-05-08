<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
	<head>
		<meta content="charset=ISO-8859-1">
		<title>Search Result</title>
	</head>
	<body class="main">
		<% try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();

            String username = (String) request.getSession().getAttribute("username");
			String model = request.getParameter("model")
			String make = request.getParameter("make");
			String year = request.getParameter("year");

			
            
			String SQLstr = "SELECT COUNT(*) AS count FROM Item_Alert_Manager WHERE Username = '"+username+"' AND Make = '"make+"' AND Model = '"+model+"' AND Year = '"+year+"';";
			ResultSet result = stmt.executeQuery(SQLstr);
			result.next();
			if(result.getInt("count") > 0){
				out.println("You have set up this alert");
			}else{
					String insert = "INSERT INTO Item_Alert_Manager VALUES (NULL, ?, ?, ?, ?)";
					PreparedStatement ps = con.prepareStatement(insert);
					ps.setString(1, username) ;
					ps.setString(2, make) ;
					ps.setString(3, model) ;
					ps.setString(4, year) ;
					ps.executeUpdate();
					out.println("You have set up an item alert sccessfully!");
			}
			
			out.println("<br><br>");
		}catch(Exception e) {
				out.println(e);
		}%>
    <a href='index.jsp' >Logout </a>
	</body>
</html>