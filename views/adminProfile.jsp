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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <script>
    $(document).ready(function() {
        $(document).on('click', '#edit-profile', function(event) {
            event.preventDefault();
            console.log("entered admin profile");
            editProfile();
        });
    });
    
    function editProfile(){
        $.ajax({
            url: "editAdminProfile",
            method: 'GET',
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

            <div class="card">
                <div class="card-body">
                	<h6 class="card-title">Id: <%= id %></h6>
                    <p class="card-title">Name: <%= adminName %></p>
                    <p class="card-text">Email: <%= adminEmail %></p>
                    <p class="card-text">Role: <%= adminRole %></p>
                </div>
            </div>

            <br>
            <a href="#" id="edit-profile" class="btn btn-primary">Edit Profile</a>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</body>
</html>
