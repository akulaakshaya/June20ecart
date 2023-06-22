<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice,eStoreProduct.model.custCredModel" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order Summary</title>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
       .container {
		    max-width: 960px;
		    margin: 0 auto;
		}
		
		.mt-5 {
		    margin-top: 3rem;
		}
		
		.mt-4 {
		    margin-top: 2rem;
		}
		
		.mb-4 {
		    margin-bottom: 2rem;
		}
		
		.card {
		    border: 1px solid #ddd;
		    border-radius: 4px;
		}
		
		.card-img-top {
		    width: 100%;
		    height: 200px;
		    object-fit: cover;
		    border-top-left-radius: 4px;
		    border-top-right-radius: 4px;
		}
		
		.card-body {
		    padding: 1rem;
		}
		
		.card-title {
		    font-size: 1.25rem;
		    font-weight: bold;
		    margin-bottom: 0.5rem;
		}
		
		.card-text {
		    font-size: 1rem;
		    margin-bottom: 0.5rem;
		}
		
		.btn-primary {
		    background-color: #007bff;
		    color: #fff;
		    border-color: #007bff;
		    padding: 0.5rem 1rem;
		    font-size: 1rem;
		    cursor: pointer;
		}
		
		.btn-primary:hover {
		    background-color: #0069d9;
		    border-color: #0062cc;
		}
		
		.container.mt-5:nth-child(2) {
		    background-color: #f9f9f9;
		    padding: 20px;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		    margin-bottom: 20px;
		}
        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            cursor: pointer;
        }
        
        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }
        
        table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
            table-layout: fixed; /* Added to enforce consistent width */
        }
        
        table td {
            padding: 0.25rem;
            word-wrap: break-word; /* Added to wrap long content */
        }
        
        input[type="text"] {
            width: 100%;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
        }
        
        .table-col1 {
            width: 20%; /* Adjust the width as needed */
        }
        
        .table-col2 {
            width: 80%; /* Adjust the width as needed */
        }
        /* Custom styles for the box containing the shipment form */
		#cont {
		    background-color: #f9f9f9;
		    padding: 20px;
		    margin-bottom: 20px;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		}
        
    </style>
     
</head>
<body>
 
<br/>
    <b><h3 align="center">Order Summary</h3></b>
    <div class="container mt-5">
        <div class="row mt-4">
            <% 
            custCredModel cust1 = (custCredModel) session.getAttribute("customer");
            List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");

            for (ProductStockPrice product : products) {
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                        <p class="card-text">Quantity: <%= product.getQuantity() %></p>
                        <p class="card-text">Price: <%= product.getPrice() %></p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <div class="container mt-5">
        <div id="cont" class="bg-light p-4">
            <form id="shipment-form">
                <table>
                    <tr>
                        <td class="table-col1">Delivery Location:</td>
                        <td class="table-col2"><%=cust1.getCustAddress() %></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Name:</td>
                        <td class="table-col2"><%=cust1.getCustName() %></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Address:</td>
                        <td class="table-col2"><%=cust1.getCustSAddress() %></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Pincode:</td>
                        <td class="table-col2"><%=cust1.getCustPincode() %></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Total Cost:</td>
                        <td class="table-col2"><%=request.getAttribute("cartcost") %></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="container mt-5">
        <div class="text-center">
            <button class="btn btn-primary back">Back</button>
             <button id="rzp-button1" onclick="openCheckout('${orderId}')">Pay</button>
        </div>
    </div>
</body>

    <script>
     
   

        $(document).on('click', '.back', function(event) {
            event.preventDefault();
            console.log("Back");
            history.back();
        });

        $(document).ready(function() {
            $('#shipment-form').submit(function(e) {
                e.preventDefault();
                var submitButton = $(this).find('input[type="submit"]');
                console.log("shipment address");

                var name = $("#name").val();
                var add = $("#custSAddress").val();
                var pin = $("#shippincode").val();
                console.log(name);

                $.ajax({
                    type: 'POST',
                    url: 'confirmShipmentAddress',
                    data: { name: name, custSAddress: add, shippincode: pin },
                    success: function(response) {
                        console.log(response);
                        submitButton.val("Saved");
                    },
                    error: function(error) {
                        console.error(error);
                    }
                });
            });
        });
    </script>
</html>