<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding= "ISO-8859-1"%>
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
	<link rel="stylesheet" type="text/css" href="otp.css">
	<!-- Ttile for organisation -->
	<title>Verify OTP</title>
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
						<form class="myForm text-center" action="#" method="post" name="otpform" >
							<header> 
								<strong>Verification </strong></header>					
							<!-- for otp input -->
							<p id="senttomail" halign="center">OTP is sent to mail, Please Check!</p>
							<div class="form-group">
								<!-- -----------  otp input value -->
								<input class="otpclass" type="text" name="otp" placeholder="OTP" required>
								
								<!-- --------- for taking values further -->
								<input type="hidden" name="otpvalue" value=<%=(String)request.getAttribute("otpvalue")%>>
								<input type="hidden" name="name" value=<%=(String)request.getAttribute("name")%>>
								<input type="hidden" name="email" value=<%=(String)request.getAttribute("email")%>>
								<input type="hidden" name="password" value=<%=(String)request.getAttribute("password")%>>
								<input type="hidden" name="contact" value=<%=(String)request.getAttribute("contact")%>>
								<input type="hidden" name="designation" value=<%=(String)request.getAttribute("designation")%>>
								
							</div>
							<div class="form-group">
								<input type="submit" class="btn btn-primary btn-lg btn-block" 
								id="verifybutton" onsubmit="validate()" value="Verify">
							</div>
							<!-- ---------------------------------------------- for resend otp ---->
							<div>
    							<p class="resend">Resend OTP ?
									<input type="submit" class="btn btn-outline-secondary" 
									id="resendbutton" onclick="resendotp()" value="Resend" disabled>
								</p>
								<progress value="0" max="20" id="progressBar" color="red"></progress>
							</div>
						</form>
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
	
	//------------------- to resend otp
	document.getElementById("resendbutton").addEventListener("click", resendotp);
	function resendotp(){
		document.location.reload(true);
		}
	
	//------------------- to verify
	document.getElementById("verifybutton").addEventListener("submit", validate);
	function validate() {
		document.write("ff");
		var otp = document.getElementById("otp").value;

	}

	</script>
    
    <!-- Optional JavaScript -->
    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
