<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.output.stockSummaryModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<table id="tableData" class="table table-bordered table-hover">
    <thead class="thead-dark">
        <tr>
            <th>Product ID</th>
            <th>Product Title</th>
            <th>Product Category ID</th>
            <th>Product GST Category ID</th>
            <th>Product Brand</th>
            <th>Image URL</th>
            <th>Product Description</th>
            <th>Reorder Level</th>
            <th>Product Category Title</th>
            <th>SGST</th>
            <th>IGST</th>
            <th>CGST</th>
            <th>GST</th>
            <th>Product Price</th>
            <th>Product Stock</th>
            <th>Product MRP</th>
            <th>EDIT</th>
        </tr>
    </thead>
    <tbody>
        <% List<stockSummaryModel> stock2=(List<stockSummaryModel>)request.getAttribute("stocks1"); %>
        <% for (stockSummaryModel stock : stock2) { %>\
    
        <tr>
        
            <td name="prod_id"><%=stock.getId()%></td>
            <td><%= stock.getTitle() %></td>
            <td><%= stock.getProductCategory() %></td>
            <td>
                <input type="text" id="prodGstcId-input" name="prod_gstc_id" value="<%= stock.getHsnCode() %>">
            </td>
            <td><%= stock.getBrand() %></td>
            <td>
                <input type="text" id="imageUrl-input" name="image_url" value="<%= stock.getImageUrl() %>">
            </td>
            <td>
                <input type="text" id="prodDesc-input" name="prod_desc" value="<%= stock.getDescription() %>">
            </td>
            <td>
                <input type="text" id="reorderlevel-input" name="reorderlevel" value="<%= stock.getReorderLevel() %>">
            </td>
            <td><%= stock.getPrct_title() %></td>
            <td><%= stock.getSgst() %></td>
            <td><%= stock.getIgst() %></td>
            <td><%= stock.getCgst() %></td>
            <td><%= stock.getGst() %></td>
            <td><%= stock.getPrice() %></td>
            <td>
                <input type="text" id="prodStock-input" name="prod_stock" value="<%= stock.getStock() %>">
            </td>
            <td>
                <input type="text" id="prodMrp-input"  name="prod_mrp" value="<%= stock.getMrp() %>">
            </td>
            <td>
                <button  id="edit-button" class="btn btn-success" data-gstc-id="<%= stock.getHsnCode() %>" 
                    data-imageurl-id="<%= stock.getImageUrl() %>" data-prod-id="<%= stock.getId() %>"
                    data-reorderlevel-id="<%= stock.getReorderLevel() %>" data-stock-id="<%= stock.getStock() %>"
                    data-mrp-id="<%= stock.getMrp() %>">UPDATE</button>
            </td>
        </tr>
      
        <% } %>
    </tbody>
</table>
</div>
<script>

</script>
</body>
</html>