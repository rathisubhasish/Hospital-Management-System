
import java.io.IOException;  
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mysql.cj.Session;
import javax.servlet.http.*;
import javax.servlet.*;
import java.sql.*;
import javax.net.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.net.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.http.*;
   
//---------------------------------------------------------------------------------------------------
@WebServlet("/Manager")
public class Manager extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Manager() {
        super();
        // TODO Auto-generated constructor stub
    }

	public static String name;
    public static String email;
    public static String password;
    public static String contact;
    public static String designation;
    public static String otpvalue;
    
    public void service(ServletRequest req,ServletResponse res)
    	    throws IOException,ServletException{
    		   String command = req.getParameter("command");
    		   System.out.println(command);
    		   //------------------------------------------------------ for signup 
    		   if(command.contentEquals("tosignup")) 
    		   {
	       	   name = req.getParameter("signupname");
	       	   email = req.getParameter("signupemail");
	       	   password = req.getParameter("signuppassword");
	       	   contact = req.getParameter("signupcontact");	       	   
    	       
    	       /*
    	       res.setContentType("text/html");
    	       PrintWriter pwriter=res.getWriter();
    	       pwriter.print("<html>");
    	       pwriter.print("<body>");
    	       pwriter.print("<h2>Generic Servlet Example</h2>");
    	       pwriter.print("<p>Hello BeginnersBook Readers!</p>");
    	       pwriter.print("</body>");
    	       pwriter.print("</html>");
    	       */
    	       otpmail();
    	       req.setAttribute("otpvalue", otpvalue);
    	       RequestDispatcher requestDispatcher = req.getRequestDispatcher("otppage.jsp");
    	       requestDispatcher.forward(req, res);
    		   }
    		   
    		   //------------------------------------------------------- for resend otp
    		   else if(command.contentEquals("resendotp")) {
    			  otpmail();
    			  req.setAttribute("checkotp", "otpvalue");
    			  RequestDispatcher requestDispatcher = req.getRequestDispatcher("otppage.jsp");
       	       	  requestDispatcher.forward(req, res);
    		   }
    		   
    		   //------------------------------------------------------- for validate otp
    		   else if(command.contentEquals("validateotp")) {
    			  String userotp = req.getParameter("otp");
    			  System.out.format("server says - %s",userotp);
    			  if(userotp.contentEquals(otpvalue)) {
    				  System.out.println("yes");
    				  req.setAttribute("verification", "Done");
    				  RequestDispatcher requestDispatcher = req.getRequestDispatcher("otppage.jsp");
    			      requestDispatcher.forward(req,res);
    			      
    			      try {
    			    	     String dbURL = "jdbc:mysql://localhost:3306/";
    			    		 String dbName = "hospitaldatabase";
    			    		 String dbUsername = "root";
    			    		 String dbPassword = "Developer@12";
    			    		 Class.forName("com.mysql.cj.jdbc.Driver");
    			    	     Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
    			    	     
    			    	     String instruction = String.format("insert into patient values(?,?,?,?)");
    			    	     PreparedStatement st = con.prepareStatement(instruction);
    			    	 	 st.setString(1,name);
    			    	 	 st.setString(2,email);
    			    	 	 st.setString(3,password);
    			    	 	 st.setString(4,contact);
    			    	 	 st.executeUpdate();
    			    	 	 st.close();
    			    	 	 con.close();
    			    		
    			      }
    			      catch (Exception e) {
    			    	  System.out.println("error");
    			    	  e.printStackTrace();
    			      }
    			      
    			  }
    			  else {
    				  System.out.print("-----------");
    				  req.setAttribute("verification", "NotDone");
    				  RequestDispatcher requestDispatcher2 = req.getRequestDispatcher("otppage.jsp");
    			      requestDispatcher2.forward(req,res);
    			  }
    		   }
    		   else if(command.contentEquals("tologin")) {
    			   String signinemail = req.getParameter("signinemail");
    			   String signinpassword = req.getParameter("signinpassword");
    			   String signindesignation = req.getParameter("signindesignation");	       	   
    			   System.out.println(signinemail);
    			   System.out.println(signinpassword);
    			   System.out.println(signindesignation);
    			   
    			   try {
    				    
    				    String dbURL = "jdbc:mysql://localhost:3306/";
    					String dbName = "hospitaldatabase";
    					String dbUsername = "root";
    					String dbPassword = "Developer@12";
    							 
    				    Class.forName("com.mysql.cj.jdbc.Driver");
    					
    					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
    					Statement stmt=con.createStatement();
    					String fetchcommand = String.format("select * from %s where email='%s'",signindesignation,signinemail);
    					System.out.println(fetchcommand);
    					ResultSet rs = stmt.executeQuery(fetchcommand);
    					String fetchusername = "";
    					String fetchpassword ="";
    					
    					while(rs.next()){
    						fetchusername = rs.getString(2);
    						fetchpassword = rs.getString(3);
    					}
    					con.close();
    					
    					if (fetchusername.contentEquals(signinemail) && !fetchpassword.contentEquals(signinpassword)){
    						System.out.println("-----------password wrong--------------\n");
    	    				req.setAttribute("loginresult", "passwordwrong");
    					}
    					else if(fetchusername.contentEquals(signinemail) && fetchpassword.contentEquals(signinpassword)) {
    						System.out.println("-----------allcorrect--------------\n");
    						req.setAttribute("loginresult", "allcorrect");
    					}
    					else {
    						System.out.println("-----------email wrong--------------\n");
    	    				req.setAttribute("loginresult", "emailwrong");
    					}
    					
    					RequestDispatcher requestDispatcher3 = req.getRequestDispatcher("logsign.jsp");
     			        requestDispatcher3.forward(req,res);
    			   }
    			   catch(Exception e) {
    				   e.printStackTrace();
   	    				req.setAttribute("loginresult", "emailwrong");
   	    				RequestDispatcher requestDispatcher3 = req.getRequestDispatcher("logsign.jsp");
 	 			       requestDispatcher3.forward(req,res);
    				   
    			   }
    			   
    		   }
    		   //------------------------------------------------------- security staff details
    		   else if(command.contentEquals("securityinfo")) {
    			   try{
    					 String dbURL = "jdbc:mysql://localhost:3306/";
    					 String dbName = "hospitaldatabase";//database
    					 String dbUsername = "root";
    					 String dbPassword = "Developer@12";
    							 
    					Class.forName("com.mysql.cj.jdbc.Driver");
    					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
    					
    					String instruction = String.format("insert into securitystaff (firstname,lastname,email,password,contact,joiningdate,experience,shift) values(?,?,?,?,?,?,?,?)");
			    	    PreparedStatement st = con.prepareStatement(instruction);
    					st.setString(1,req.getParameter("securityfirstname"));
    					st.setString(2,req.getParameter("securitylastname"));
    					st.setString(3,req.getParameter("securityemail"));
    					st.setString(4,req.getParameter("securitypassword"));
    					st.setString(5,req.getParameter("securitycontact"));
    					st.setString(6,req.getParameter("securityjoiningdate"));
    					st.setString(7,req.getParameter("securityexperience"));
    					st.setString(8,req.getParameter("securityshift"));
    					st.executeUpdate();
    					st.close();
    					con.close();
    				}
    				catch (Exception e){
    					System.out.println("error");
    					e.printStackTrace();
    				}  
    			  RequestDispatcher requestDispatcher = req.getRequestDispatcher("security.jsp");
       	       	  requestDispatcher.forward(req, res);
    		   }
    		   
    		    //------------------------------------------------------- cleaning staff details
    		   else if(command.contentEquals("cleaningstaffinfo")) {
    			   try{
    					 String dbURL = "jdbc:mysql://localhost:3306/";
    					 String dbName = "hospitaldatabase";//database
    					 String dbUsername = "root";
    					 String dbPassword = "Developer@12";
    							 
    					Class.forName("com.mysql.cj.jdbc.Driver");
    					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
    					
    					PreparedStatement st = con.prepareStatement("insert into cleaningstaff(firstname,lastname,email,password,contact,joiningdate,experience,department) values(?,?,?,?,?,?,?,?)");
    					st.setString(1,req.getParameter("cleanerfirstname"));
    					st.setString(2,req.getParameter("cleanerlastname"));
    					st.setString(3,req.getParameter("cleaneremail"));
    					st.setString(4,req.getParameter("cleanerpassword"));
    					st.setString(5,req.getParameter("cleanercontact"));
    					st.setString(6,req.getParameter("cleanerjoiningdate"));
    					st.setString(7,req.getParameter("cleanerexperience"));
    					st.setString(8,req.getParameter("cleanerdepartment"));
    					st.executeUpdate();
    					st.close();
    					con.close();
    				}
    				catch (Exception e){
    					System.out.println("error");
    					e.printStackTrace();
    				} 
    			   

    			   	  RequestDispatcher requestDispatcher = req.getRequestDispatcher("cleaning.jsp");
        	       	  requestDispatcher.forward(req, res);
    		   }
    		   

   		    //------------------------------------------------------- nurses details
   		   else if(command.contentEquals("nursesinfo")) {
   			   try{
   					 String dbURL = "jdbc:mysql://localhost:3306/";
   					 String dbName = "hospitaldatabase";//database
   					 String dbUsername = "root";
   					 String dbPassword = "Developer@12";
   							 
   					Class.forName("com.mysql.cj.jdbc.Driver");
   					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
   					
   					PreparedStatement st = con.prepareStatement("insert into nurses (firstname,lastname,email,password,contact,joiningdate,experience,department,shift) values(?,?,?,?,?,?,?,?,?)");
   					st.setString(1,req.getParameter("nursefirstname"));
   					st.setString(2,req.getParameter("nurselastname"));
   					st.setString(3,req.getParameter("nurseemail"));
   					st.setString(4,req.getParameter("nursepassword"));
   					st.setString(5,req.getParameter("nursecontact"));
   					st.setString(6,req.getParameter("nursejoiningdate"));
   					st.setString(7,req.getParameter("nurseexperience"));
   					st.setString(8,req.getParameter("nursedepartment"));
   					st.setString(9,req.getParameter("nurseshift"));
   					st.executeUpdate();
   					st.close();
   					con.close();
   				}
   				catch (Exception e){
   					System.out.println("error");
   					e.printStackTrace();
   				} 
   			   

   			   	  RequestDispatcher requestDispatcher = req.getRequestDispatcher("nurse.jsp");
       	       	  requestDispatcher.forward(req, res);
   		   }

    		   //------------------------------------------------------- doctor details
   		   else if(command.contentEquals("doctorinfo")) {
   			   try{
   					 String dbURL = "jdbc:mysql://localhost:3306/";
   					 String dbName = "hospitaldatabase";//database
   					 String dbUsername = "root";
   					 String dbPassword = "Developer@12";
   							 
   					Class.forName("com.mysql.cj.jdbc.Driver");
   					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
   					
   					PreparedStatement st = con.prepareStatement("insert into doctor (firstname,lastname,email,password,contact,joiningdate,experience,department,speciality) values(?,?,?,?,?,?,?,?,?)");
   					st.setString(1,req.getParameter("doctorfirstname"));
   					st.setString(2,req.getParameter("doctorlastname"));
   					st.setString(3,req.getParameter("doctoremail"));
   					st.setString(4,req.getParameter("doctorpassword"));
   					st.setString(5,req.getParameter("doctorcontact"));
   					st.setString(6,req.getParameter("doctorjoiningdate"));
   					st.setString(7,req.getParameter("doctorexperience"));
   					st.setString(8,req.getParameter("doctordepartment"));
   					st.setString(9,req.getParameter("doctorspeciality"));
   					st.executeUpdate();
   					st.close();
   					con.close();
   				}
   				catch (Exception e){
   					System.out.println("error");
   					e.printStackTrace();
   				} 
   			   

   			   	  RequestDispatcher requestDispatcher = req.getRequestDispatcher("doctor.jsp");
       	       	  requestDispatcher.forward(req, res);
   		   }

    		   //------------------------------------------------------- receptionist details
   		   else if(command.contentEquals("receptioninfo")) {
   			   try{
   					 String dbURL = "jdbc:mysql://localhost:3306/";
   					 String dbName = "hospitaldatabase";//database
   					 String dbUsername = "root";
   					 String dbPassword = "Developer@12";
   							 
   					Class.forName("com.mysql.cj.jdbc.Driver");
   					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
   					
   					PreparedStatement st = con.prepareStatement("insert into reception (firstname,lastname,email,password,contact,joiningdate,experience,shift) values(?,?,?,?,?,?,?,?)");
   					st.setString(1,req.getParameter("receptionfirstname"));
   					st.setString(2,req.getParameter("receptionlastname"));
   					st.setString(3,req.getParameter("receptionemail"));
   					st.setString(4,req.getParameter("receptionpassword"));
   					st.setString(5,req.getParameter("receptioncontact"));
   					st.setString(6,req.getParameter("receptionjoiningdate"));
   					st.setString(7,req.getParameter("receptionexperience"));
   					st.setString(8,req.getParameter("receptionshift"));
   					st.executeUpdate();
   					st.close();
   					con.close();
   				}
   				catch (Exception e){
   					System.out.println("error");
   					e.printStackTrace();
   				} 
   			   

   			   	  RequestDispatcher requestDispatcher = req.getRequestDispatcher("recept.jsp");
       	       	  requestDispatcher.forward(req, res);
   		   }


    		   //------------------------------------------------------- patient details
   		   else if(command.contentEquals("patientinfo")) {
   			   try{
   					 String dbURL = "jdbc:mysql://localhost:3306/";
   					 String dbName = "hospitaldatabase";//database
   					 String dbUsername = "root";
   					 String dbPassword = "Developer@12";
   							 
   					Class.forName("com.mysql.cj.jdbc.Driver");
   					Connection con = DriverManager.getConnection(dbURL + dbName , dbUsername, dbPassword);
   					
   					PreparedStatement st = con.prepareStatement("insert into patient (firstname,lastname,email,password,contact,admitdate,leavedate) values(?,?,?,?,?,?,?)");
   					st.setString(1,req.getParameter("patientfirstname"));
   					st.setString(2,req.getParameter("patientlastname"));
   					st.setString(3,req.getParameter("patientemail"));
   					st.setString(4,req.getParameter("patientpassword"));
   					st.setString(5,req.getParameter("patientcontact"));
   					st.setString(6,req.getParameter("patientadmitdate"));
   					st.setString(7,req.getParameter("patientleavedate"));
   					st.executeUpdate();
   					st.close();
   					con.close();
   				}
   				catch (Exception e){
   					System.out.println("error");
   					e.printStackTrace();
   				} 
   			   
   			   	  RequestDispatcher requestDispatcher = req.getRequestDispatcher("patient.jsp");
       	       	  requestDispatcher.forward(req, res);
   		   }


    		   else {
    			   System.out.println("error");
    		   }
    	     }
    	    
    public static void otpmail() {
    	try{  
    		  int min = 1000;
    		  int max = 10000;      
    	      //-----------------------------------------------------Generate random int value from 50 to 100 
    		  double otpgenerate = (Math.random() * (max - min + 1) + min);
    		  int getotp = (int)otpgenerate;
    		  otpvalue = Integer.toString(getotp);
    		  System.out.format("\nmail-%s\n",otpvalue);
    		  //-----------------------------------------------------mail material
    		  
   		  final String mailto = email;	  
   	      final String personname = name;
   	      final String subject = "Alphacure Hospital Verification!";
   	      final String messg = "!-------------------------------------------------------------!\n"
   	    		  +" Hello "+personname
   	    		  +"\n Welcome to the Alphacure Hospital! "
   	    		  +"\n Your verification OTP is : "+otpvalue+"\n!-------------------------------------------------------------!";
   	            
   	      //sender email id and password
   	      final String from = "";
   	      final String pass = "";
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
   	      Session session = Session.getInstance(pros, new javax.mail.Authenticator()
   	    		  {
   	    	  		protected PasswordAuthentication getPasswordAuthentication()
   	    	  		{
   	    	  			return new PasswordAuthentication(from,pass);
   	    	  		}
   	    		  }
   	    		  );
   	      
   	      try{
   	      //create a default mime message object
   	      MimeMessage message = new MimeMessage(session);
   	      
   	      //set from : header field
   	      message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailto));
   	      
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
    		}catch (Exception c){
    		  c.printStackTrace();
    		  System.out.print("mailerror");
    	  }
	      
    }
	
}
