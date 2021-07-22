<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "java.io.*,java.util.*"%>
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.net.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.activation.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "javax.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="ISO-8859-1">
    <title>Login</title>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta http-equiv="X-UA-Compatile" content="ie=edge" />
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     <link rel="stylesheet" href="logsign.css"/>
    <!-- for awesome icons -->
	<link rel="stylesheet" href= "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">  
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
	

</head>
<body>
	<div class="container" id="container">
	<div class="form-container sign-up-container">
		<form id="signupform" action="./Manager" method="get">
			<h2>Create Account</h2>
			<div class="social-container">
				<a href="#" class="social"><i class="fa fa-facebook icon"></i></a>
				<a href="#" class="social"><i class="fa fa-google-plus icon"></i></a>
				<a href="#" class="social"><i class="fa fa-linkedin icon"></i></a>
			</div>
			<input type="hidden" id="type" name="command" value="tosignup"> 
			<input type="text" placeholder="Name" name="signupname" id="signupname" required>
			<input type="email" placeholder="Email" name="signupemail" id="signupemail" required>
            <input type="password" placeholder="Password" name="signuppassword" id="signuppassword" 
            pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
            <input type="tel" placeholder="9845785851" name="signupcontact" title="9845785851" id="signupcontact" required pattern="[0-9]{3}[0-9]{3}[0-9]{4}">
			<label for="designationlabel">Designation</label>
			<input type="hidden" name="signupdesignation" id="signupdesignation" value="patient">
			<input type="submit" class="SignUp"  value="SignUp">
		</form>
	</div>

	

	<div class="form-container sign-in-container">
		<form action="./Manager" method="post" onsubmit="loginresult()">
			<h2>Sign in</h2>
			<div class="social-container">
				<a href="#" class="social"><i class="fa fa-facebook icon"></i></a>
				<a href="#" class="social"><i class="fa fa-google-plus icon"></i></a>
				<a href="#" class="social"><i class="fa fa-linkedin icon"></i></a>
			</div>
			<span>or use your account</span>
			<input type="hidden" id="type" name="command" value="tologin">
			<input type="email" id="signinemail" name="signinemail" placeholder="Email" required>
			<input type="password" id="signinpassword" name="signinpassword" placeholder="Password" required>
			<select name="signindesignation" id="signindesignation" required>
				<option value="">None</option>
			    <option value="patient">Patient</option>
			    <option value="doctor">Doctor</option>
			    <option value="receptionist">Receptionist</option>
			    <option value="accountant">Accountant</option>
			    <option value="admin">Admin</option>
			</select>
			<input type="submit" class="SignIn"  value="SignIn">
			<a href="#">Forgot your password?</a>
		</form>
	</div>
	<div class="overlay-container">
		<div class="overlay">
			<div class="overlay-panel overlay-left">
				<h1>Alphacure Hospital!</h1>
				<p>To keep connected with us please signin </p>
				<a href="home.html">Home</a>
				<button class="signinbutton" id="signIn">Sign In</button>
			</div>
			<div class="overlay-panel overlay-right">
				<h1>Alphacure Hospital!</h1>
				<p>Signup to our caring world.<br>
				   Only Patient can Signup</p>
				   
				<a href="home.html">Home</a>
				<button class="signupbutton" id="signUp">Sign Up</button>
			</div>
		</div>
	</div>
</div>
<script>
 function loginresult(){
	 <%
		String mssg = (String)request.getAttribute("loginresult");
	 	System.out.format("~~%s\n",mssg);
		
	 	if (mssg!=null && mssg.equals("emailwrong")){
			PrintWriter pwriter=response.getWriter();
			pwriter.print("<html><body>");
			pwriter.print("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
	        pwriter.print("<script type='text/javascript'>swal({title:'invalid email id',text: 'Try again',icon: 'warning',button: 'Try Again'});</script>");
			pwriter.print("</body></html>");
		}
		else if(mssg!=null && mssg.equals("passwordwrong")){
			PrintWriter pwriter2=response.getWriter();
			pwriter2.print("<html><body>");
			pwriter2.print("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		    pwriter2.print("<script type='text/javascript'>swal({title: 'Password Not Matched!',text: 'correct it',icon: 'error',button: 'Try Again'});</script>");
			pwriter2.print("</body></html>");
		}
		else if(mssg!=null && mssg.equals("allcorrect")){
			PrintWriter pwriter2=response.getWriter();
			pwriter2.print("<html><body>");
			pwriter2.print("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		    pwriter2.print("<script type='text/javascript'>swal({title: 'Hurray!',text: 'Logged in  sucessfully',icon: 'success',button: 'home'}).then(function(){window.location.href='home.html'});</script>");
			pwriter2.print("</body></html>");
		}
		%>
 }
</script>
<script type="text/javascript" src="logsign.js"></script>

</body>
</html>