<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
try {
	String dbDriver = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost:3306/";
	//Database name to access
	String dbName = "test";
	String dbUsername = "root";
	String dbPassword = "Developer@12";
	
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(dbURL+dbName,dbUsername,dbPassword);
	
	//create a sql query to insert data into table
	PreparedStatement st = con
			.prepareStatement("insert into signup values(?,?,?,?)");
	
	//get the data using request object
	st.setString(1, request.getParameter("signupname"));
	st.setString(2, request.getParameter("signupemail"));
	st.setString(3, request.getParameter("signuppassword"));
	st.setString(4, request.getParameter("signupcontact"));
	
	//Execute the insert command using executeUpdate()
	//to make changes to database
	st.executeLargeUpdate();
	
	//Close all the connection
	st.close();
	con.close();
}
catch (Exception e) {
	e.printStackTrace();
}
%>
<h1>Successfully Inserted"</h1>
</body>
</html>