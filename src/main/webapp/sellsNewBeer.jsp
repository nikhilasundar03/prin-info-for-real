<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String user = request.getParameter("username");
		String pass = request.getParameter("password");


		//Make an insert statement for the Sells table:
		//String insert = "INSERT INTO UserLogins(username, password)"
				//+ "VALUES (?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		//PreparedStatement ps = con.prepareStatement(insert);
		
		String query = "SELECT * FROM UserLogins WHERE username = ? AND password = ?";
		PreparedStatement ps = con.prepareStatement(query);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, user);
		ps.setString(2, pass);
		//Run the query against the DB
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
		    out.print("Login Successful!");
		 	// Add logout button
	        out.println("<br><br>");
	        out.println("<form method='get' action='HelloWorld.jsp'>");
	        out.println("<input type='submit' value='Logout'>");
	        out.println("</form>");
		} else {
		    out.print("Login Failed.");
		 	// Display the login form again
	        out.println("<form method='get' action='sellsNewBeer.jsp'>");
	        out.println("<table>");
	        out.println("<tr><td>Username</td><td><input type='text' name='username'></td></tr>");
	        out.println("<tr><td>Password</td><td><input type='text' name='password'></td></tr>");
	        out.println("</table>");
	        out.println("<input type='submit' value='Login'>");
	        out.println("</form>");
		}

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("Insert succeeded!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Search failed :()");
	}
%>
</body>
</html>