<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="eStoreProduct.model.custCredModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Page</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>

<body>
    <h1>Payment Page</h1>

    <button id="rzp-button1" onclick="openCheckout('${orderId}')">Pay</button>
	<% custCredModel cust = (custCredModel) session.getAttribute("customer") ;%>
    <form action="invoice" method="POST" name="razorpayForm">
    
        <input id="razorpay_payment_id" type="hidden" name="razorpay_payment_id" />
        <input id="razorpay_order_id" type="hidden" name="billNumber" />
		<input id="razorpay_amount" type="hidden" name="total" />

		<input id="shippingAddress" type="hidden" name="shippingAddress" value="<%=cust.getCustSAddress()%>" />
		<input id="customerId" type="hidden" name="customerId" value="<%=cust.getCustId()%>" />
		
    </form>

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
</body>
</html>