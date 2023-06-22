
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Sign Up</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    /* Add your custom styles here */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }
    
    .container {
      max-width: 520px;
      padding: 20px;
      background-color: #f2f2f2;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    
    h2 {
      text-align: center;
      margin-bottom: 20px;
    }
    
    form {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 10px;
    }
    
    .form-group {
      display: flex;
      flex-direction: column;
    }
    
    label {
      font-weight: bold;
      margin-bottom: 5px;
    }
    
    input[type="text"],
    input[type="password"],
    input[type="number"] {
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 3px;
    }
    
    .button-container {
      display: flex;
      justify-content: center;
      margin-top: 20px;
    }
    
    .button-container button {
      background-color: #333;
      color: #fff;
      border: none;
      padding: 10px;
      border-radius: 3px;
      cursor: pointer;
    }
    
    .button-container button:hover {
      background-color: #555;
    }
    
    .form-group span {
      margin-top: 5px;
      font-size: 12px;
    }
  </style>
  <script>
   function validateEmail()
   {
	   var email = $("#email").val();
	   console.log("email in verification "+email);
	   $.ajax({
   	    type: "POST",
   	    url: "emailValid",
   	    data: { email: email },
   	    success: function(response) {
   	      console.log("response of email verification " + response);
   	      if (response !== "no") {
   	    	 $("#emailCheck").text("Account already existed with this mail");
   	    	 $("#email").val("");
   	    	setTimeout(function() {
   	         $("#emailCheck").text("");
   	       }, 2000);
   	      }
   	      },error: function() {
	            alert("Error occurred. Please try again later.");
          }
        });
   }
   
    function validatePassword() {
      var passwordInput = document.getElementById("password").value;
      console.log("Password: " + passwordInput);
      var confirmPassword = document.getElementById("confirm-password").value;
      var message = document.getElementById("confirm-password-message");
      
      if (passwordInput !== confirmPassword) {
        message.style.color = "red";
        message.innerHTML = "Passwords do not match";
        return false;
      } else {
        message.style.color = "green";
        message.innerHTML = "Passwords match";
        return true;
      }
    }
  </script>
</head>
<body>
  <div class="container">
    <h2>Create Account</h2>
    <form action="signInCreateAccount" method="POST" name="form">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="custName" required>
      </div>
   <div class="form-group">
        <label for="email">Email</label>
        <input type="text" id="email" name="custEmail" required onblur="validateEmail()">
        <div id="emailCheck"></div>
   </div>


      <div class="form-group">
        <label for="mobile">Mobile</label>
        <input type="text" id="mobile" name="custMobile" required>
      </div>
            
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" name="custAddress" required>
      </div>
      
      <div class="form-group">
        <label for="pincode">Pincode</label>
        <input type="number" id="pincode" name="custPincode" required>
      </div>
      
      <div class="form-group">
        <label for="shipment-address">Shipment Address</label>
        <input type="text" id="shipment-address" name="custSAddress" required>
      </div>
      
      <div class="form-group">
        <label for="spincode">ShipmentPincode</label>
        <input type="number" id="spincode" name="custSpincode" required>
      </div>
      
      <div class="form-group">
        <label for="location">Location</label>
        <input type="text" id="location" name="custLocation" required>
      </div>
      
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="custPassword" required>
      </div>
      
      <div class="form-group">
        <label for="confirm-password">Confirm Password</label>
        <input type="password" id="confirm-password" name="confirm-password" required>
        <span id="confirm-password-message"></span>
      </div>
      
      <div class="button-container">
        <button onclick="return validatePassword()">Create Account</button>
      </div>
    </form>
  </div>
</body>
</html>




