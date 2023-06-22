<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Example</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom Styles -->
    <style>
        .container {
            max-width: 400px;
            margin-top: 50px;
        }
        .form-group label {
            font-weight: bold;
        }
    </style>
    <script>
    $(document).on('change', '#categoryDropdown', function(event) {
        event.preventDefault();
        var ctg_id = document.getElementById("categoryDropdown").value;
        console.log(ctg_id);
        document.getElementById("prod_prct_id").value = parseInt(ctg_id);
    });
	function clear(){
		 document.getElementById("createNewProducts").reset();	
	}
    $(document).on('click', '#clr', function(event) {
    event.preventDefault();
    clear();
    });

 
</script>

</head>
<body>
    <form action="createNewProduct" id="createNewProducts" method="post">
        <div class="container mt-5">
            <div class="text-left mb-3">
                <select   id="categoryDropdown" class="form-control">
                    <!-- Options for categories -->
                </select>
            </div>
        </div>
        <div class="container">
            <div class="form-group">
                <label for="prod_title">Product Title:</label>
                <input type="text" class="form-control" id="prod_title" name="prod_title" required>
            </div>
	         <div class="form-group">
			    <label for="prod_prct_id">Product Category Id:</label>
			    <input type="number" readonly  class="form-control" id="prod_prct_id" name="prod_prct_id" required>
			</div>

            <div class="form-group">
                <label for="prod_gstc_id">HSN Code ID:</label>
                <input type="number" class="form-control" id="prod_gstc_id" name="prod_gstc_id" required>
            </div>
            <div class="form-group">
                <label for="prod_brand">Product Brand:</label>
                <input type="text" class="form-control" id="prod_brand" name="prod_brand" required>
            </div>
            <div class="form-group">
                <label for="image_url">Image URL:</label>
                <input type="text" class="form-control" id="image_url" name="image_url" required>
            </div>
            <div class="form-group">
                <label for="prod_desc">Product Description:</label>
                <textarea class="form-control" id="prod_desc" name="prod_desc" required></textarea>
            </div>
            <div class="form-group">
                <label for="reorderLevel">Reorder Level:</label>
                <input type="number" class="form-control" id="reorderLevel" name="reorderLevel" required>
            </div>
           
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Create</button>
            </div>
             <div class="form-group">
                <button id="clr" class="btn btn-secondary">Clear</button>
            </div>
        </div>
    </form>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
