<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Order Confirmation</title>
  
  
  <style>
  .container {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}

h1 {
  text-align: center;
}

.message {
  background-color: #f2f2f2;
  border-radius: 5px;
  padding: 20px;
  text-align: center;
  opacity: 0;
  transform: translateY(-20px);
  transition: opacity 0.5s ease, transform 0.5s ease;
}

.message.show {
  opacity: 1;
  transform: translateY(0);
}

.message h2 {
  color: #333;
}

.message p {
  color: #666;
}

  
  </style>
  <script>
  window.onload = function() {
	    setTimeout(function() {
	      var message = document.querySelector('.message');
	      message.classList.add('show');
	    }, 500);
	  };
  </script>
</head>
<body>
  <div class="container">
    <h1>Order Confirmation</h1>
    <div class="message">
      <h2>Your order has been placed successfully!</h2>
      <p>Thank you for shopping with us.</p>
      <a href="loggedIn">Continue Shopping</a>
    </div>
  </div>
</body>
</html>
