<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>
<%@ page import="eStoreProduct.model.custCredModel" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
		
        <style>
           body {
            font-family: Arial, sans-serif;
      		margin: 0;
      		padding: 0;
            background-color: #f2f2f2;
        }

        .container {
            margin-top: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .product-card {
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: box-shadow 0.3s;
            cursor: pointer;
            margin-bottom: 20px;
            display: flex;
        }

        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            width: 200px;
            height: 200px;
            object-fit: cover;
        }

        .product-details {
            padding: 20px;
            flex-grow: 1;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        .product-description {
            font-size: 14px;
            margin-bottom: 10px;
            color: #666;
        }
		#pcd{
		  flex: 0 0 auto;
		  width: 25%;
		}
		#btn{
		  flex: 0 0 auto;
		  width: 15%;
		}
        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #e91e63;
        }
         .input-button-container {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		  }
		
		  .input-button-container .form-control {
		    margin-right: -10px; /* Adjust the margin as needed */
		  }
        </style>
    <script>
    $(document).ready(function() {
        updateCostOnLoad();
    });
    function buynow()
    {
  	  console.log("buy now");
  	 $.ajax({
         url: 'buycartitems',
         method: 'GET',
         success: function(response) {
             console.log("response of updateqty  "+response);
             $('#payment').html(response); // Set the response HTML as the inner HTML of the cart items element
         },
         error: function(xhr, status, error) {
             console.log('AJAX Error: ' + error);
         }
     });

  	  	//window.location.href="buycartitems";  
  	    }
    function updateQuantity(input) {
        var quantity = input.value;
        console.log(quantity+"qnty!!!!!!!!!!!");
        var productId = input.getAttribute('data-product-id');
        console.log("qty in updateqty method "+quantity);
        console.log("product no=" + productId);
        $.ajax({
            url: 'updateQuantity',
            method: 'POST',
            data: { productId: productId, quantity: quantity },
            success: function(response) {
                console.log("response of updateqty  "+response);
                $("#tcost").html("Total Cost: " + response);
                
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }
    
    function chechValidity(){
    	var pincode=document.getElementById("pincode").value;
    	$.ajax({
            url: 'checkPincodeValidity',
            method: 'POST',
            data: { pincode:pincode },
            success: function(response) {
                console.log("response of updateqty  "+response);
                if(response=="true"){
                	toastr.success("Available..");
                }
                else{
                	toastr.info("Not Available..");
                }
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }
    
    function updateCostOnLoad(){
        console.log("updateCostOnLoad");

    	$.ajax({
            url: 'updateCostOnLoad',
            method: 'POST',
            success: function(response) {
            	console.log(response);
                $("#tcost").html("Total Cost: " + response);

            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }
    
   
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            <%-- Iterate over the products and render the HTML content --%>
            <%		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
           			 List<ProductStockPrice> products;
    		if (cust1 != null) {
               products = (List<ProductStockPrice>) request.getAttribute("products");
    		} else {
                products = (List<ProductStockPrice>) request.getAttribute("alist");
			}
				double totalcost=0.0;
                for (ProductStockPrice product : products) {
            %>
             <div class="product-card">
            
                <img class="card-img-top" src="<%= product.getImage_url() %>" alt="${product.getName()}">
                <div class="product-details">
                   <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                        <p class="card-text"><%= product.getPrice() %></p>
                        <label>Qty:</label>
                        <input type="number" class="btn btn-primary qtyinp input-width" id="qtyinp" value="<%=product.getQuantity() %>" min="1" onchange="updateQuantity(this)" data-product-id="<%= product.getProd_id() %>">
                        <br><br>
                        <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                </div>
                
            </div>
            <%
                }
            %>
        </div>
    </div>
    
 <div align="center" class="container mt-3">
  <div id="checkpincode" class="row justify-content-center">
    <div class="col-md-3" id="pcd">
      <input type="text" id="pincode" name="pincode" class="form-control" placeholder="Enter pincode here..">
    </div>
    <div class="col-md-3" id="btn">
      <button class="btn btn-primary pincode" onclick="checkValidity()">Pincode Check</button>
    </div>
  </div>
  <br/>
  <div id="tcost"></div>
  <button class="btn btn-primary BuyNow" onclick="buynow()">Place Order</button>
</div>


</body>
</html>
 
 
