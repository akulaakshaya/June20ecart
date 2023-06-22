<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="eStoreProduct.model.admin.output.OrderValueWiseShippingCharge,java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Value Wise Shipping Charges</title>
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
        
        .add-button {
            margin-bottom: 10px;
        }
        
        .add-button a {
            display: inline-block;
            padding: 8px 12px;
            background-color: #4CAF50;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
        }
        
        .add-button a:hover {
            background-color: #45a049;
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
        
        .add-form {
            margin-bottom: 10px;
        }
        
        .add-form input[type="text"] {
            margin-bottom: 5px;
        }
    </style>
    <script>
        function makeEditable(row) {
            var cells = row.getElementsByTagName('td');
            
            for (var i = 0; i < cells.length - 1; i++) {
                var cell = cells[i];
                var text = cell.innerText;
                
                cell.innerHTML = '<input type="text" value="' + text + '">';
            }
            
            var editButton = row.querySelector('.edit-button');
            editButton.innerText = 'Save';
            editButton.onclick = function() {
                saveChanges(row);
            };
        }
        
        function saveChanges(row) {
            var cells = row.getElementsByTagName('td');
            var values = [];
            
            for (var i = 0; i < cells.length - 1; i++) {
                var cell = cells[i];
                var input = cell.querySelector('input');
                var text = input.value;
                
                cell.innerHTML = text;
                values.push(text);
            }
            
            var editButton = row.querySelector('.edit-button');
            editButton.innerText = 'Edit';
            editButton.onclick = function() {
                makeEditable(row);
            };
            
            // Invoke your custom function with the values as parameters
            handleSave(values);
        }
        
        function handleSave(values) {
            // Replace this with your custom logic to handle the saved values
            console.log('Saved values:', values);
            $.ajax({
                url: "updateCharge",
                method: 'POST',
                data:{
                   id:values[0],
                    From:values[1],
                   To:values[2],
                 shippingAmount:values[3]
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
        
        function addEntryForm() {
            var addForm = document.getElementById('add-form');
            addForm.style.display = 'block';
        }
        
        function submitEntryForm() {
            var ordvlFromInput = document.getElementById('ordvlFrom');
            var ordvlToInput = document.getElementById('ordvlTo');
            var ordvlShippingAmountInput = document.getElementById('ordvlShippingAmount');
            
            var ordvlFromValue = ordvlFromInput.value;
            var ordvlToValue = ordvlToInput.value;
            var ordvlShippingAmountValue = ordvlShippingAmountInput.value;
            
            $.ajax({
                url: "addCharge",
                method: 'POST',
                data:{
                    From:ordvlFromValue,
                    To:ordvlToValue,
                    shippingAmount:ordvlShippingAmountValue
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
            ordvlFromInput.value = '';
            ordvlToInput.value = '';
            ordvlShippingAmountInput.value = '';
            
            // Hide the form
            var addForm = document.getElementById('add-form');
            addForm.style.display = 'none';
        }
    </script>
</head>
<body>
<% List<OrderValueWiseShippingCharge> chargeList = (List<OrderValueWiseShippingCharge>) request.getAttribute("chargeList"); %>
<h1>Order Value Wise Shipping Charges</h1>
<div class="add-button">
    <a href="#" onclick="addEntryForm()">Add Entry</a>
</div>
<div id="add-form" class="add-form" style="display: none;">
    <form>
        <input type="text" id="ordvlFrom" placeholder="Order Value From" required><br>
        <input type="text" id="ordvlTo" placeholder="Order Value To" required><br>
        <input type="text" id="ordvlShippingAmount" placeholder="Shipping Amount" required><br>
        <button type="button" onclick="submitEntryForm()">Submit</button>
    </form>
</div>
<table>
    <thead>
        <tr>
            <th>S.No</th>
            <th>Order Value From</th>
            <th>Order Value To</th>
            <th>Shipping Amount</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <% for (OrderValueWiseShippingCharge charge : chargeList) { %>
        <tr>
            <td><%= charge.getId() %></td>
            <td><%= charge.getFrom() %></td>
            <td><%= charge.getTo()%></td>
            <td><%= charge.getShippingAmount() %></td>
            <td>
                <a href="#" class="edit-button" onclick="makeEditable(this.parentNode.parentNode)">Edit</a>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
</body>
</html>
