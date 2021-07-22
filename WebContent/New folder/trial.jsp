
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*"%>
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.net.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.activation.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "javax.servlet.*" %>


<%
try{  
	  int min = 1000;
	  int max = 10000;      
      //-----------------------------------------------------Generate random int value from 50 to 100 
	  double otpgenerate = (Math.random() * (max - min + 1) + min);
	  int getotp = (int)otpgenerate;
	  String otpvalue = Integer.toString(getotp);
	  request.setAttribute("otpvalue",otpvalue);
	  System.out.format("\nmail-%s\n",otpvalue);
	  //-----------------------------------------------------mail material
	  /*
	  final String to = request.getParameter("signupemail");
      final String pn = request.getParameter("signupname");
      final String subject = "Alphacure Hospital Verification!";
      final String messg = "!-------------------------------------------------------------!\n"
    		  +" Hello "+pn
    		  +"\n Welcome to the Alphacure Hospital! "
    		  +"\n Your verification OTP is : "+otpvalue+"\n!-------------------------------------------------------------!";
            
      //sender email id and password
      final String from = "2019cssubhasish7753@poornima.edu.in";
      final String pass = "khuljaid12";
      // define the gmail host
      String host = "smtp.gmail.com";
      //create the properties object
      Properties pros = new Properties();
      
      //define the properties
      pros.put("mail.smtp.host",host);
      pros.put("mail.transport.protocol","smtp");
      pros.put("mail.smtp.auth","true");
      pros.put("mail.smtp.starttls.enable","true");
      pros.put("mail.user",from);
      pros.put("mail.password",pass);
      pros.put("mail.smtp.port","587");
      
      
      //authorized the session object
      
      Session mailSession = Session.getInstance(pros, new Authenticator()
    		  {
    	  		protected PasswordAuthentication getPasswordAuthentication()
    	  		{
    	  			return new PasswordAuthentication(from,pass);
    	  		}
    		  }
    		  );
      
      try{
      //create a default mime message object
      MimeMessage message = new MimeMessage(mailSession);
      
      //set from : header field
      message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
      
      //set the subject field
      message.setSubject(subject);
      //set the message field
      message.setText(messg);
      
      //send the message
      Transport.send(message);
      }
      catch (Exception e)
      {
    	e.printStackTrace();
      }
        */
	}catch (Exception c){
	  c.printStackTrace();
	  System.out.print("error");
  }
		  
%>
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
	<link rel="stylesheet" type="text/css" href="otpscreen.css">
	<!-- Ttile for organisation -->
	<title>Verify OTP</title>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
	<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
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
								<form action="#" id="otpform" onsubmit="route();return false">
								<!-- -----------  otp input value  ------------ -->
								<input class="otpclass" type="text" name="otp" id="otp" placeholder="OTP" required>						
								<input type="submit" class="btn btn-primary btn-lg btn-block" 
								id="verifybutton" name="verifybutton" value="Verify">
								</form>
								
							<!-- ---------------------------------------------- for resend otp ---->
							
    							<p class="resend">Resend OTP ?
									<button class="btn btn-outline-secondary" id="resendbutton" 
									onclick="resendotp()" disabled>Resend</button>
								</p>
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
<script language="javascript"> 

function resendotp(){ 
	document.location.reload(true);
}


$(function() { 
	$("#otpform").submit(function() { 
	$.ajax({ 
		window.history.replace("resendmail.jsp?otp="+"otp");
		<%
		String otp = (String)request.getParameter("otp");
		if(otp!=null){
		String otpcheck = (String)request.getAttribute("otpvalue");
		System.out.format("check - %s , otp - %s\n",otpcheck,otp);
		}
		%>
		} 
	}); 
	return false; 
});

//function verification(){
	//alert("hi");
	//window.history.replace("resendmail.jsp?otp="+"otp");
		<%
			//String otp = (String)request.getParameter("otp");   // otp is not working only.
			//if(otp!=null){
			//String otpcheck = (String)request.getAttribute("otpvalue");
			//System.out.format("check - %s , otp - %s\n",otpcheck,otp);
			//}
		%>
	
		//window.location.replace("resendmail.jsp?otp="+enterotp);
	<%
		/*
		String enterotp=request.getParameter("otp");
		if(enterotp != null && !enterotp.isEmpty()){
			String otpcheck = (String)request.getAttribute("otpvalue");
			System.out.format("(otpcheck- %s , enterotp - %s)\n",otpcheck,enterotp);
		}
		else{
        	System.out.println("!!!!!null or empty.\n");
		}
		*/
	%>
	
/*
	var otpvalue = document.getElementById("otpvalue").value;
	var otp = document.getElementById("otp").value;	
	if(otp==otpvalue){
		swal({
			  title: "Verified Successfully!",
			  text: "Now you can login",
			  icon: "success",
			  button: "Login",
			}).then(function(){
				window.location.href="./signupdatabase";
			});
	}
	else{
		swal({
			  title: "Not Matched!",
			  text: "OTP is wrong",
			  icon: "error",
			  buttons: "Try Again",
			});
	}
*/
//}
</script> 


<!-- Optional JavaScript -->
<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body> 
</html>