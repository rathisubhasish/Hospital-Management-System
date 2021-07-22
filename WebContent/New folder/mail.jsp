<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.net.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import="javax.servlet.*" %>


<!DOCTYPE html>
<html>
   <head>
      <title>Send Email using JSP</title>
   </head>
   <body>
      <h1>Send Email using JSP</h1>
      <%
      String result;
      final String to = request.getParameter("email");
      final String subject = request.getParameter("sub");
      final String messg = request.getParameter("mess");
      
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
      result = "Sended Successfully!!";
      }
      catch (Exception e)
      {
    	e.printStackTrace();
    	result="error occured";
      }
      %>
   </body>
</html>