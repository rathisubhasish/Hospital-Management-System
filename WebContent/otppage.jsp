<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%@page import="java.io.PrintWriter"%>
<%@ page import = "java.io.*,java.util.*"%>
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.net.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.activation.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "javax.servlet.*" %>

    <!-- ----------------------------------  Verification Screen --------------------------------- -->
<!DOCTYPE html>
<html>
<head lang="en">
 	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	<!-- my css  -->
	<link rel="stylesheet" type="text/css" href="otppage.css">
	<!-- Ttile for organisation -->
	<title>Verify OTP</title>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
	<script>
	//-------------------------------------- for timer progress show
	function otptimer(){
		var timeleft = 20;
		var downloadTimer = setInterval(function(){
		  if(timeleft <= 0){
			console.log(timeleft);
		    clearInterval(downloadTimer);
			document.getElementById("resendbutton").disabled = false;
			document.getElementById("progressBar").remove();
		  }
		  document.getElementById("progressBar").value = 20 - timeleft;
		  timeleft -= 1;
		}, 1000);
		}
	</script>
</head>
<body onload="otptimer()">
	<!-- -------------------------------------  HTML  CODE ------------------------------------------------- -->
	<div class="container">     
		<div class="myCard">
			<div class="row">
				<div class="col-md-6">
					<!-- -------------OTP INPUT and SUBMIT FORM---------------------- -->
					<div class="myLeftSide">
							<header> 
								<strong>Verification </strong></header>					
							<!-- for otp input -->
							<p id="senttomail" halign="center">OTP is sent to mail, Please Check!</p>
							<div>
								<form action="./Manager" method="get" onsubmit="result()">
								<!-- -----------  otp input value  ------------ -->
								<input class="otpclass" type="text" name="otp" id="otp" placeholder="OTP" required>						
								<input type="hidden" name="command" value="validateotp">
								<input type="submit" class="btn btn-primary btn-lg btn-block" 
								id="verifybutton"  name="verifybutton" value="Verify">
								</form>
							<!-- ---------------------------------------------- for resend otp ---->
								<form action="./Manager" method="get">
								<input type="hidden" value="resendotp" name="command">
    							<p class="resend">Resend OTP ?
								<input type="submit" class="btn btn-outline-secondary" id="resendbutton" 
									 disabled value="Resend">
								</p>
								</form>
								<progress value="0" max="20" id="progressBar" color="red"></progress>
							</div>
					</div>
				</div>	
				<!-- for right portion -->
				<div class="col-md-6">	
					<div class="myRightSide">
						<div class="box">
							<header>  
							</header>
							<img src="verifyimg.jpg" alt="verifyimage" id="verifyimg">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	function result(){
		<%
		String mssg = (String)request.getAttribute("verification");
		System.out.format("--**** %s",mssg);
		if (mssg!=null && mssg.equals("Done")){
			PrintWriter pwriter=response.getWriter();
			pwriter.print("<html><body>");
			pwriter.print("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
 	        pwriter.print("<script type='text/javascript'>swal({title:'success',text: 'Now you can login',icon: 'success',button: 'Login'}).then(function(){window.location.href='logsign.jsp'});</script>");
			pwriter.print("</body></html>");
		}
		else if(mssg!=null && mssg.equals("NotDone")){
			PrintWriter pwriter2=response.getWriter();
			pwriter2.print("<html><body>");
			pwriter2.print("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
		    pwriter2.print("<script type='text/javascript'>swal({title: 'Not Matched!',text: 'OTP is wrong',icon: 'error',button: 'Try Again'});</script>");
			pwriter2.print("</body></html>");
		}
		%>
	}
	</script>
	
  </body>
  </html>