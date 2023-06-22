 <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Catalog</title>

<script>
    function showProductDetails(productId) {
        window.location.href = "prodDescription?productId=" + productId;
        console.log(productId);
    }

    
</script>
</head>
<body>
<div class="container mt-5">
    <h2>Product Catalog</h2>
    <div class="row mt-4">
        <%-- Iterate over the products and render the HTML content --%>
        <%
            List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");
        	//ProdStockDAO ps = new ProdStockDAOImp();
            for (ProductStockPrice product : products) {
        %>
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <a href="javascript:void(0)" onclick="showProductDetails('<%= product.getProd_id() %>')">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                </a>
                <div class="card-body">
                    <h5 class="card-title"><%= product.getProd_title() %></h5>
                    <p class="card-text"><%= product.getProd_desc() %></p>
                    <p class="card-text"><%= product.getPrice() %></p> 
                    
                    <button class="btn btn-primary addToCartButton" data-product-id="<%= product.getProd_id() %>"data-quantity="<%= product.getQuantity() %>">Add To Cart</button>
                    <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                </div>
            </div>
        </div>
        
        <%
            }
        %>
    </div>
</div>
</body>
</html>