<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Product Category Selection</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
  function loadCategories() {
    // Function to handle AJAX call and populate the select options
    $.ajax({
      url: "CategoriesServlet",
      method: 'GET',
      success: function(response) {
        $('#catg').html(response); // Set the response HTML as the inner HTML of the select element
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
  }
  $(document).change(function() {
	  var category=document.getElementById("catg").value;
	  $.ajax({
	      url: "products",
	      method: 'GET',
	      data:{category:category},
	      success: function(response) {
	        $('#display').html(response); // Set the response HTML as the inner HTML of the select element
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
	  });

  </script>
</head>
<body onload="loadCategories()">
  <h1>Select Product Category</h1>
  <form action="/process-category" method="POST">
    <select name="catg" id="catg">
      <!-- The options will be populated here -->
    </select>
    <div id="display"></div>
  </form>
</body>
</html>