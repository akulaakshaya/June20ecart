<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Prouct Added Successfully</title>
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
      background-color: #f2f2f2;
    }
    
    .container {
      max-width: 520px;
      padding: 40px;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    
    h2 {
      margin-bottom: 20px;
    }
    
    p {
      font-size: 18px;
      margin-bottom: 30px;
    }
    
    a {
      display: inline-block;
      color: #333;
      text-decoration: none;
      border: 1px solid #333;
      padding: 10px 20px;
      border-radius: 5px;
      transition: background-color 0.3s;
    }
    
    a:hover {
      background-color: #333;
      color: #fff;
    }
    
  </style>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
  $(document).on('click', '#back', function(event) {
	    event.preventDefault();
            window.history.back();
  });
    </script>
</head>
<body>
  <div class="container">
    <h2>Product Added Successfully</h2>
    <p>Product added Succesfully .You can Continue Adding </p>
    <a href="addNewProductInTheMasterEntry" id="back">Back to Adding</a>
  </div>
</body>
</html>