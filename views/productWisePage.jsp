<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, eStoreProduct.model.ProductShip" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Information</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f2f2f2;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
        
        .edit-button {
            display: inline-block;
            padding: 6px 10px;
            background-color: #2196F3;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 5px;
        }
        
        .edit-button:hover {
            background-color: #0d8bf2;
        }
    </style>
</head>
<body>
<% List<ProductShip> productList=(List<ProductShip>)request.getAttribute("plist"); %>
<h1>Product Information</h1>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Shipping Charge</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%-- Iterate over the product model list and display each product --%>
    <% for (ProductShip product : productList) { %>
    <tr>
        <td><%= product.getProd_id()%></td>
        <td><%= product.getProd_title() %></td>
        <td><%= product.getProd_price() %></td>
        <td>
            <span id="shippingCharges_<%= product.getProd_id()%>"><%= product.getShipment_charges() %></span>
            <input id="shippingChargesInput_<%= product.getProd_id()%>" type="text" style="display: none;">
        </td>
        <td>
            <a href="#" id="editButton_<%= product.getProd_id()%>" class="edit-button" onclick="editProduct(<%= product.getProd_id()%>)">Edit</a>
            <a href="#" id="saveButton_<%= product.getProd_id()%>" class="edit-button" style="display: none;" onclick="saveShippingCharges(<%= product.getProd_id()%>)">Save</a>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<script>
    function editProduct(productId) {
        var shippingChargesSpan = document.getElementById("shippingCharges_" + productId);
        var shippingChargesInput = document.getElementById("shippingChargesInput_" + productId);
        var editButton = document.getElementById("editButton_" + productId);
        var saveButton = document.getElementById("saveButton_" + productId);

        // Hide the span and show the input field
        shippingChargesSpan.style.display = "none";
        shippingChargesInput.style.display = "inline-block";
        shippingChargesInput.value = shippingChargesSpan.innerText;

        // Hide the edit button and show the save button
        editButton.style.display = "none";
        saveButton.style.display = "inline-block";
    }

    function saveShippingCharges(productId) {
        var shippingChargesSpan = document.getElementById("shippingCharges_" + productId);
        var shippingChargesInput = document.getElementById("shippingChargesInput_" + productId);
        var editButton = document.getElementById("editButton_" + productId);
        var saveButton = document.getElementById("saveButton_" + productId);

        // Get the updated shipping charges value
        var updatedShippingCharges = shippingChargesInput.value;

        // You can perform further validation or processing here before saving the data

        // Simulate saving the shipping charges to the server
        saveShippingChargesToServer(productId, updatedShippingCharges);

        // Update the span with the new value from the input field
        shippingChargesSpan.innerText = updatedShippingCharges;

        // Hide the input field and show the span
        shippingChargesInput.style.display = "none";
        shippingChargesSpan.style.display = "inline-block";

        // Hide the save button and show the edit button
        saveButton.style.display = "none";
        editButton.style.display = "inline-block";
    }
    function saveShippingChargesToServer(productId, shippingCharges) {
        // Replace this with your custom logic to save the shipping charges to the server
        // You can use AJAX, fetch, or any other method to send the data to the server
        // Example code using fetch:
    	$.ajax({
            url: "prodShipUpdate",
            method: 'POST',
            data:{
            	prod_id:productId,
            	shipment_charges:shippingCharges,
            },
            success: function(response) {
                console.log(response);
                // Set the response HTML as the inner HTML of the select element
                // dis();
            },
            error: function(xhr, status, error) {
                console.log('AJAX Error: ' + error);
            }
        });
    }
</script>
</body>
</html>
