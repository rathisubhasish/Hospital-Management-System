<%@ page import="java.sql.*" %>
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
Connection conn = null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitaldatabase","root","Developer@12");
	if(conn!=null)
	{
		out.print("connected successfully");
	}
}catch (Exception e)
{
	out.print("failed");
}
%>
</body>
</html>