<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>
<%@ page import="eStoreProduct.model.custCredModel" %>
<%@ page import="eStoreProduct.model.productqty" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order Summary</title>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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
    </style>
    <script>
        function openCheckout(orderId) {
        	console.log("amount in payment options jsp "+${amt});
            var options = {
                key: "rzp_test_Eu94k5nuplVQzA",
                name: "E-Cart",
                amount:${amt},
                description: "SLAM payments",
                image: "https://s29.postimg.org/r6dj1g85z/daft_punk.jpg",
                prefill: {
                    name: "Meghana",
                    email: "potalameghana2@gmail.com",
                    contact: "9133845963"
                },
                notes: {
                    address: "Hello World",
                    merchant_order_id: orderId
                },
                theme: {
                    color: "#F37254"
                },
                order_id: orderId,
                handler: function (response) {
                    document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                    document.getElementById('razorpay_order_id').value = orderId;
                   // document.getElementById('razorpay_signature').value = response.razorpay_signature;
                    document.getElementById('razorpay_amount').value =${amt};

                    document.razorpayForm.submit();
                },
                modal: {
                    ondismiss: function () {
                        console.log("This code runs when the popup is closed");
                    },
                    escape: true,
                    backdropclose: false
                }
            };

            var rzpButton = document.getElementById("rzp-button1");
            rzpButton.addEventListener("click", function (e) {
                e.preventDefault();

                // Open Razorpay checkout with updated options
                var rzp = new Razorpay(options);
                rzp.open();
            });
        }
    </script>
</head>
<body>
<form action="invoice" method="POST" name="razorpayForm">
    
        <input id="razorpay_payment_id" type="hidden" name="razorpay_payment_id" />
        <input id="razorpay_order_id" type="hidden" name="billNumber" />
		<input id="razorpay_amount" type="hidden" name="total" />

		<input id="shippingAddress" type="hidden" name="shippingAddress" value="<%=cust.getCustSAddress()%>" />
		<input id="customerId" type="hidden" name="customerId" value="<%=cust.getCustId()%>" />
		
    </form>
    <h3>Order Summary</h3>
    <div id="id1">
        <div class="container mt-5">
            <div class="row mt-4">
                <% custCredModel cust1 = (custCredModel) session.getAttribute("customer");
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
                            <p class="card-text">Subtotal: <%= product.getQtyprice() %></p>
                             <p class="card-text">gst: <%= product.getGst() %></p>
                            
                            
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <div id="cont">
            <form id="shipment-form">
                <table>
                    <tr>
                        <td class="table-col1">Delivery Location:</td>
                        <td class="table-col2"></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Name:</td>
                        <td class="table-col2"><%=cust1.getCustName()%></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Address:</td>
                        <td class="table-col2"><%=cust1.getCustSAddress()%></td>
                    </tr>
                    <tr>
                        <td class="table-col1">Pincode:</td>
                        <td class="table-col2"><%=cust1.getCustPincode()%></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
             <label>Use Wallet</label>
          <input type="number" id="wallet" name="wallet" value="1000">
             
        <input type="checkbox" id="walletAmount10" name="walletAmount"  onclick="checkWalletAmount()">
          </div>
        <div>
            <button class="btn btn-primary back">Back</button>
             <button id="rzp-button1" onclick="openCheckout('${orderId}')">Pay</button>
           <%--  <a href="#" class="btn btn-primary" id="tamt" onclick="continuenext(<%=ProductStockPrice.getTotal()%>)"><%=ProductStockPrice.getTotal()%></a>
              --%></div>

             
    </div>

    <script>
    function checkWalletAmount() {
        var total = parseFloat(<%=ProductStockPrice.getTotal()%>);
        var wallet = parseFloat(document.getElementById("wallet").value);
        var useWallet = document.getElementById("walletAmount10").checked;
        
        if (useWallet && total > wallet && wallet!=0) {
            total -= wallet;
            document.getElementById("tamt").innerHTML = '<a href="#" class="btn btn-primary" id="tamt" onclick="continuenext()">' + total.toFixed(2) + '</a>';
        } else {
            document.getElementById("tamt").innerHTML = '<a href="#" class="btn btn-primary" id="tamt" onclick="continuenext()">' + total.toFixed(2) + '</a>';
            if (useWallet) {
                alert("Wallet amount is insufficient.");
            }
        }
    }
     
     
    
    
        function continuenext(amount) {
            console.log("hiiiiiiiii");
            window.location.href="paymentoptions?total="+amount;
        }

        $(document).on('click', '.back', function(event) {
            event.preventDefault();
            console.log("Back");
            history.back();
        });

 
    </script>
</body>
</html>
