<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Sign In</title>
  </head>
<style>
  /* Add your custom styles here */
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }
  
  .container {
    display: grid;
    grid-template-columns: 1fr 2fr;
    background-color: red;
    background: linear-gradient(to bottom, rgb(6, 108, 100), rgb(14, 48, 122));
    width: 800px;
    height: 400px;
    margin: 10% auto;
    border-radius: 5px;
  }

  .content-holder {
    text-align: center;
    color: white;
    font-size: 14px;
    font-weight: lighter;
    letter-spacing: 2px;
    margin-top: 15%;
    padding: 50px;
  }

  .content-holder h2 {
    font-size: 34px;
    margin: 20px auto;
  }

  .content-holder p {
    margin: 30px auto;
  }

  .content-holder button {
    border: none;
    font-size: 15px;
    padding: 10px;
    border-radius: 6px;
    background-color: white;
    width: 150px;
    margin: 20px auto;
  }

  .box-2 {
    background-color: white;
    margin: 5px;
  }

  .login-form-container {
    text-align: center;
    margin-top: 10%;
  }

  .userlogin-form-container h1 {
    color: black;
    font-size: 24px;
    padding: 20px;
  }

  .input-field {
    box-sizing: border-box;
    font-size: 14px;
    padding: 10px;
    border-radius: 7px;
    border: 1px solid rgb(168, 168, 168);
    width: 250px;
    outline: none;
  }

  .login-button {
    box-sizing: border-box;
    color: white;
    font-size: 14px;
    padding: 13px;
    border-radius: 7px;
    border: none;
    width: 250px;
    outline: none;
    background-color: rgb(56, 102, 189);
  }

  .button-2 {
    display: none;
  }

  .adminlogin-form-container {
    position: relative;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-60%);
    text-align: center;
    display: none;
  }

  .adminlogin-form-container h1 {
    color: black;
    font-size: 24px;
    padding: 20px;
  }

  .signup-button {
    box-sizing: border-box;
    color: white;
    font-size: 14px;
    padding: 13px;
    border-radius: 7px;
    border: none;
    width: 250px;
    outline: none;
    background-color: rgb(56, 189, 149);  
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function validateEmail()
{
	   var email = $("#email").val();
	   console.log("email in verification "+email);
	   $.ajax({
	    type: "POST",
	    url: "emailValid",
	    data: { custEmail: email },
	    success: function(response) {
	      console.log("response of email verification " + response);
	         if (response == "no") {
	    	 $("#emailVerify").text("Please enter valid email");
	    	
	    	setTimeout(function() {
	         $("#emailVerify").text("");
	       }, 2000);
	    	$("#email").val("");} 
	       //console.log("signin email verification response "+response);
	         
	      },error: function() {
	            alert("Error occurred. Please try again later.");
       }
     });
}
</script>
</head>
<body>
 <div class="container">
      <!--Data or Content-->
      <div class="box-1">
          <div class="content-holder">
              <h2>Hello!</h2>
             
              <button class="button-1" >USER</button>
              
          </div>
      </div>

      
      <!--Forms-->
      <div class="box-2">
          <div class="userlogin-form-container" align="center">
              <h1>Login Form</h1>
              <div id="emailVerify"></div>
              <form action="signOk">
              <input type="email" placeholder="Email" name="custEmail" id="email" class="input-field" onblur="validateEmail()">
              <br><br>
              <input type="password" placeholder="Password" class="input-field" name="custPassword">
              <br><br>
              <button class="login-button" type="submit">Sign In</button>
              </form>
                   <div>
          <br>
          <br>
         <a href="forgotPassword">Forget Password</a>
          </div>
          </div>



</div>
      </div>
 
      
<script>
function usersignin()
{
    document.querySelector(".userlogin-form-container").style.cssText = "display: none;";
    document.querySelector(".adminlogin-form-container").style.cssText = "display: block;";
    document.querySelector(".container").style.cssText = "background: linear-gradient(to bottom, rgb(56, 189, 149),  rgb(28, 139, 106));";
    document.querySelector(".button-1").style.cssText = "display: none";
    document.querySelector(".button-2").style.cssText = "display: block";

};


</script>
</body>
</html>
