<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.custCredModel" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice,java.time.LocalDate" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Invoice</title>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 960px;
            margin: 0 auto;
            padding: 20px;
        }

        .invoice-title {
            margin-bottom: 20px;
        }

        .invoice-title h2 {
            font-size: 28px;
        }

        .invoice-title h3 {
            font-size: 16px;
        }

        hr {
            border: 0;
            height: 1px;
            background: #ccc;
            margin-bottom: 20px;
        }

        .row {
            margin-bottom: 20px;
        }

        .col-xs-6 {
            width: 50%;
        }

        .address strong {
            font-weight: bold;
        }

        .table {
            margin-bottom: 0;
        }

        .table th,
        .table td {
            padding: 8px;
            vertical-align: top;
        }

        .table th {
            font-weight: bold;
            background-color: #f9f9f9;
        }

        .text-right {
            text-align: right;
        }
    </style>
</head>
<body>
<%
custCredModel cust = (custCredModel) request.getAttribute("customer");
List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");
String payid = (String) request.getAttribute("payid");
%>

<div class="container">
    <div class="invoice-title">
        <h2>Invoice</h2>
        <h3>#By SLAM Store</h3>
    </div>
    <hr>
    <div class="row">
        <div class="col-xs-6">
            <address>
                <strong>Billed To:</strong><br>
                <p><%=cust.getCustName()%></p>
                <p><%=cust.getCustMobile()%></p>
                <p><%=cust.getCustLocation()%></p>
            </address>
        </div>
        <div class="col-xs-6 text-right">
            <address>
                <strong>Shipped To:</strong><br>
                <p><%=cust.getCustName()%></p>
                <p><%=cust.getCustMobile()%></p>
                <p><%=cust.getCustSAddress()%></p>
                <p><%=cust.getCustSpincode()%></p>
            </address>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-6">
            <address>
                <strong>Payment Method:</strong><br>
                Online
                <p>Payment ID: <%=payid %></p>
            </address>
        </div>
        <div class="col-xs-6 text-right">
            <address>
            <% LocalDate currentDate=LocalDate.now(); %>
                <strong>Order Date: <%=currentDate%></strong><br>
                <br><br>
            </address>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>Order summary</strong></h3>
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th class="text-center"><strong>ITEM</strong></th>
                                    <th class="text-center"><strong>Quantity</strong></th>                                    
                                    <th class="text-center"><strong>SGST(Each Item)</strong></th>
                                     <th class="text-center"><strong>CGST</strong></th>
                                     <th class="text-center"><strong>IGST</strong></th>
                                     <th class="text-center"><strong>GST</strong></th>                     
                                    <th class="text-right"><strong>PRICE(Each Item)</strong></th>
                                    <th class="text-right"><strong>TOTAL_PRICE</strong></th>
                                    
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <% for(ProductStockPrice p : products) { %>
                                <tr>
                                    <td class="text-center"><%=p.getProd_title()%></td>
                                     <td class="text-center"><%=p.getQuantity() %></td>                                    
                                    <td class="text-center"><%=p.getSgst()%></td>
                                     <td class="text-center"><%=p.getCgst()%></td>
                                    <td class="text-center"><%=p.getIgst()%></td>
                                    <td class="text-center"><%=p.getGst()%></td>                                    
                                    <td class="text-right"><%=p.getPrice()%></td>
                                    <td class="text-right"><%=p.getQtyprice()%></td>
                                    
                                </tr>
                                <% } %>
                                          <tr>
    <th class="text-right" colspan="8">Shipment Charges:</th>                                    </tr>
                                <%
                                for(ProductStockPrice p : products) {
                                %>
                                <tr>
                                    <td class="text-right" colspan="8"><%=p.getShipcharge()%></td>
                                </tr>
                                <%} %>
                                    <tr>
                                    <th class="text-right" colspan="7">Total:</th>
                                    <td class="text-right" colspan="8"><%=ProductStockPrice.getTotal() %>      </td></tr>     
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div>
            
<a href="loggedIn">
    <button>OK</button>
</a>            </div>
        </div>
    </div>
</div>

</body>
</html>
