<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*"%>
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.net.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.activation.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "javax.servlet.*" %>
    
    
//	    try{
//	    	String dbDriver = "com.mysql.jdbc.Driver";
//	    	String dbURL = "jdbc:mysql://localhost:3306/";
//	    	//Database name to access
//	    	String dbName = "hospitaldatabase";
//	    	String dbUsername = "root";
//	    	String dbPassword = "Developer@12";
//	    	
//	    	Class.forName(dbDriver);
//	    	Connection con = DriverManager.getConnection(dbURL + dbName,dbUsername,dbPassword);
//	    	
//	    	String designation = (String)request.getAttribute("signupcontact");
//	    	String insert = String.format("insert into %s values(?,?,?,?)",designation);
//	    	//create a sql query to insert the data 
//	    	PreparedStatement st = con
//	    		.prepareStatement(insert);
//	    	
//	    	st.setString(1,request.getParameter("signupname"));
//	    	st.setString(2,request.getParameter("signupemail"));
//	    	st.setString(3,request.getParameter("signuppassword"));
//	    	st.setString(4,request.getParameter("signupcontact"));
//	    	
//	    	st.executeUpdate();
//	    	
//	    	st.close();
//	    	con.close();	    	
//	    }
//	    catch (Exception e){
//	    	e.printStackTrace();
//	    }
//	}
    