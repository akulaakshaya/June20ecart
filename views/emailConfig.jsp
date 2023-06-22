<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
    body {
        font-family: Arial, sans-serif;
    }

    form {
        margin: 20px;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 300px;
    }

    label {
        display: block;
        margin-bottom: 5px;
    }

    input[type="text"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    input[type="button"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="button"]:hover {
        background-color: #45a049;
    }

    #p {
        margin-top: 10px;
        font-weight: bold;
    }
</style>

<script type="text/javascript">
    function getemail() {
        var email = document.getElementById("email").value;
        var pwd = document.getElementById("pwd").value;
        console.log("hello");
        $.ajax({
            url: "EmailConfiguration",
            method: 'POST',
            data: {
                email: email,
                pwd: pwd
            },
            success: function(response) {
                $('#p').html("done");
                console.log('In the updation of master entry function');
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <form>
        <label for="email">New Email:</label>
        <input type="text" id="email" placeholder="Enter your new email" name="email">

        <label for="pwd">Password:</label>
        <input type="text" id="pwd" placeholder="Enter your password" name="pwd">

        <input type='button' onclick="getemail()" value="Submit">
    </form>
    <p id="p"></p>
</body>
</html>