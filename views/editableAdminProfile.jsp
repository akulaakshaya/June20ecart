<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="eStoreProduct.model.admin.entities.adminModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Profile Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
        }

        .card {
            max-width: 400px;
            margin: 0 auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-title {
            font-size: 24px;
            font-weight: bold;
        }

        .card-text {
            margin-bottom: 10px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }
    </style>
   <script>
   
   $(document).on('click', '#update-button', function(event) {
    event.preventDefault();
 	console.log("updating profile");
    
    var id = document.getElementById("adminId").value;
   
    
    var name = document.getElementById("adminName").value;
    var email = document.getElementById("adminEmail").value;
    var role = document.getElementById("adminRole").value;
    var password = document.getElementById("adminPassword").value;
    console.log("updating profile",id);
    updateProfile(id,name,email,role,password);
});


function updateProfile(id,name,email,role,password){
console.log("in viewing  shipped Orders");
 $.ajax({
      url: "updateAdminDetails",
      method: 'GET',
      data:{id:id,
    	  title:name,
    	  email:email,
    	  designation:role,
    	  password:password},
      success: function(response) {
        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
}

   </script>
   
</head>
<body>
    <div class="container">
    <div id="content">
        <h1>Admin Profile</h1>
        <hr>
        <% adminModel am = (adminModel) session.getAttribute("admin"); %>
        <%-- Replace the following lines with your server-side code to retrieve admin profile information --%>
        <% int id=am.getId(); %>
        <% String adminName = am.getTitle(); %>
        <% String adminEmail = am.getEmail(); %>
        <% String adminRole = am.getDesignation(); %>
        <%String password=am.getPassword(); %>
	<form  >
        <div class="card">
            <div class="card-body">
            <h6 class="card-title"> ID:
            <input id="adminId" type="text" class="form-control" name="id" value="<%= id %>" readonly >

            </h6>
                <p class="card-title">Name:
                    <input id="adminName" type="text" class="form-control" name="title" value="<%= adminName %>" >
                </p>
                <p class="card-text">Email:
                    <input id="adminEmail" type="email" class="form-control" name="email" value="<%= adminEmail %>" >
                </p>
                <p class="card-text">Role:
                    <input id="adminRole" type="text" class="form-control" name="designation" value="<%= adminRole %>" >
                </p>
                
               <%--  <p class="card-text">Password:
                    <input id="adminPassword" type="text" class="form-control" name="password" value="<%= password %>" >
                </p> --%>
                
            </div>
        </div>

        <br>
       <input type="submit" value="update" id="update-button">
       </form>
    </div>
</div>
</body>
</html>
