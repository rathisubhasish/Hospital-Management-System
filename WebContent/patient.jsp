<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "javax.servlet.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.net.*" %>


<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Patients</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/patient.css" rel="stylesheet">

  <!-- for awesome icons -->
  <link rel="stylesheet" href= "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">  
   <!--     Fonts and icons     -->
   <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

   <!-- CSS Files -->
   <link href="asscet/css/material-dashboard.css?v=2.1.2" rel="stylesheet" />
</head>

<body>
  
<div class="form" align="center">
  <!-- Button trigger modal -->
  <button type="button" class="btn  btn-add btn-rounded btn-info" data-toggle="modal" data-target="#exampleModal">Add</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog" role="document" >
<div class="modal-content">
<div class="frm" align="center">
<form action="./Manager" method="POST">
 <input type="text" id="patientfirstname" name="patientfirstname" placeholder="FirstName"><br>
 <input type="text" id="patientlastname" name="patientlastname" placeholder="LastName"><br>
 <input type="text" id="patientemail" name="patientemail" placeholder="Email ID"><br>
 <input type="password" id="patientpassword" name="patientpassword" placeholder="Password"><br>
 <input type="text" id="patientcontact" name="patientcontact" placeholder="Contact"><br>
 <input type="date" id="patientadmitdate" name="patientadmitdate" placeholder="Admit Date"><br>
 <input type="date" id="patientleavedate" name="patientleavedate" placeholder="Leave Date"><br>
 <br><br>
 <input type="hidden" id="command" name="command" value="patientinfo"> 
 <button type="button" class="btn btn-View btn-rounded btn-info" data-dismiss="modal">Close</button>
 <input type="submit" class="btn btn-add btn-rounded btn-info" value="Add">   
 </form>
 </div>
 </div>
 </div>
 </div>
</div>
 

<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hospitaldatabase";
String userId = "root";
String password = "Developer@12";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>
</tr>
<tr bgcolor="#A52A2A">
<td><b>Firstname</b></td>
<td><b>Lastname</b></td>
<td><b>Email</b></td>
<td><b>Password</b></td>
<td><b>Contact</b></td>
<td><b>Admitdate</b></td>
<td><b>Leavedate</b></td>
</tr>
<%
try{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
String sql ="SELECT * FROM patient";

resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr bgcolor="#DEB887">

<td><%=resultSet.getString("firstname") %></td>
<td><%=resultSet.getString("lastname") %></td>
<td><%=resultSet.getString("email") %></td>
<td><%=resultSet.getString("password") %></td>
<td><%=resultSet.getString("contact") %></td>
<td><%=resultSet.getString("admitdate") %></td>
<td><%=resultSet.getString("leavedate") %></td>
</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>


        <!-- Optional JavaScript -->
      <!-- jQuery first, then Popper.js, then Bootstrap JS -->
      <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous">
      </script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
      </script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
      </script>

</body>

</html>