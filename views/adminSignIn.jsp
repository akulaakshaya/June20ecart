<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Sign In</title>
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

    .adminlogin-form-container {
      text-align: center;
      margin-top: 10%;
    }

    .adminlogin-form-container h1 {
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
  </style>
</head>
<body>
  <div class="container">
    <!-- Data or Content -->
    <div class="box-1">
      <div class="content-holder">
        <h2>Hello!</h2>
        <button class="button-2" onclick="adminsignin()">Admin</button>
      </div>
    </div>

    <!-- Forms -->
    <div class="box-2">
      <div class="adminlogin-form-container">
        <h1>Admin Sign In</h1>
        <form action="adminSignOk" method="POST" >
          <input type="email" placeholder="Email" name="email" class="input-field">
          <br><br>
          <input type="password" placeholder="Password" name="password" class="input-field">
          <br><br>
          <button class="login-button" type="submit">Sign In</button>
        </form>
      </div>
    </div>
  </div>

  <script>
    function adminsignin() {
      document.querySelector(".adminlogin-form-container").style.cssText = "display: block;";
      document.querySelector(".container").style.cssText = "background: linear-gradient(to bottom, rgb(56, 189, 149),  rgb(28, 139, 106));";
      document.querySelector(".button-2").style.cssText = "display: none;";
    }
  </script>
</body>
</html>
