<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
    <script>
    function buynow()
    {
  	  console.log("buy now");

  	  	window.location.href="login";  
  	    }
    </script>
</head>
<body>
<div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            <%-- Iterate over the products and render the HTML content --%>
            <%
                List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("alist");
				double totalcost=0.0;
                for (ProductStockPrice product : products) {
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                        <p class="card-text"><%= product.getPrice() %></p>
                        <% totalcost= product.getPrice()*product.getQuantity();%>
                        <label>Qty:</label>
                        <input type="number" class="btn btn-primary qtyinp input-width" id="qtyinp" name="quantity" value="1" min="1" data-product-id="<%= product.getProd_id() %>">
                        <br><br>
                        <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <div align="center" container mt-3">
        <div id="cst">
            <p align="center">Total Cost=<%=totalcost %></p>
        </div>
        <button class="btn btn-primary BuyNow" onclick="buynow()">Place Order</button>
    </div>
</body>
</html>