<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Example</title>
    <style>
       .dropdown-menu {
        display: none;
        position: absolute;
        z-index: 1;
        background-color: grey; /* Updated background color */
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        padding: 12px 16px;
    }
     .dropdown-menu.settings-dropdown {
            background-color: grey;
        }
    .dropdown.show{
        background-color: #212529;
    }
    .dropdown.show .dropdown-menu {
        display: block;
    } 
        .dashboard {
            position: fixed;
            top: 0;
            left: -200px;
            width: 300px;
            height: 100%;
            background-color: #212121;
            padding: 20px;
            transition: left 0.3s ease;
            color: #fff;
            font-family: Arial, sans-serif;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            z-index: 1;
        }
        
        .dashboard h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 22px;
            text-transform: uppercase;
        }
        
        .dashboard ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        .dashboard li {
            margin-bottom: 10px;
        }
        
        .dashboard a {
            text-decoration: none;
            color: #fff;
            transition: color 0.3s ease;
        }
        
        .dashboard a:hover {
            color: #f39c12;
        }
        
      
        .menu-icon {
            position: fixed;
            top: 20px;
            left: 20px;
            cursor: pointer;
            z-index: 2;
        }
        
        .menu-icon span {
            display: block;
            width: 25px;
            height: 3px;
            background-color: #fff;
            margin-bottom: 5px;
            transition: transform 0.3s ease;
        }
        
        .menu-icon.active span:nth-child(1) {
            transform: rotate(-45deg) translate(-5px, 5px);
        }
        
        .menu-icon.active span:nth-child(2) {
            opacity: 0;
        }
        
        .menu-icon.active span:nth-child(3) {
            transform: rotate(45deg) translate(-5px, -5px);
        }
        
   
        .content {
            margin-left: 300px;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        
        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }
        
        p {
            color: #777;
            line-height: 1.6;
        }
        
      
        .data-visualization {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
        
        .data-visualization .item {
            flex-basis: 30%;
            background-color: #f39c12;
            padding: 20px;
            color: #fff;
            border-radius: 5px;
            text-align: center;
            transition: transform 0.3s ease;
            cursor: pointer;
        }
        
        .data-visualization .item:hover {
            transform: translateY(-5px);
        }
        
        .data-visualization h3 {
            margin-top: 0;
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        .data-visualization p {
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            .dashboard {
                left: -220px;
            }
            
            .content {
                margin-left: 0;
            }
        }
        
         .sub-menu {
            display: none;
            padding-left: 20px;
        } 
    </style>

    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <script>
        // JavaScript for hamburger menu toggle
      function toggleMenu() {
            var dashboard = document.getElementById('dashboard');
            var menuIcon = document.querySelector('.menu-icon');
            
            if (dashboard.style.left === '-200px') {
                dashboard.style.left = '0';
                menuIcon.classList.add('active');
            } else {
                dashboard.style.left = '-200px';
                menuIcon.classList.remove('active');
            }
        }
        
      $(document).ready(function() {
    	    $('.Master-Entry-SubOptions').click(function(e) {
    	    	 e.preventDefault();
    	        $(this).next('.sub-menu').slideToggle();
    	    });
    	});

      $(document).ready(function() {
  	    $('.Shipments-SubOptions').click(function(e) {
  	    	 e.preventDefault();
  	        $(this).next('.sub-menu').slideToggle();
  	    });
  	});
      
      function toggleDropdown() {
          var dropdown = document.getElementById('settingsDropdown');
          dropdown.classList.toggle('show');
      }
  	
      
      
    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    
    
    
    $(document).on('click', '.payments-link', function(event) {
	    event.preventDefault();
	   console.log("entered admin profile");
	   displayPayments();
    });
    
    function displayPayments(){
    	 $.ajax({
    	      url: "viewPayments",
    	      method: 'GET',
    	      success: function(response) {
    	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
    	      },
    	      error: function(xhr, status, error) {
    	        console.log('AJAX Error: ' + error);
    	      }
    	    });
    }
    
    
    <!-- ADMIN PROFILE -->
    
    $(document).on('click', '.profile-link', function(event) {
	    event.preventDefault();
	   console.log("entered admin profile");
	   displayProfile();
    });
    
    function displayProfile(){
    	 $.ajax({
    	      url: "displayAdminProfile",
    	      method: 'GET',
    	      success: function(response) {
    	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
    	      },
    	      error: function(xhr, status, error) {
    	        console.log('AJAX Error: ' + error);
    	      }
    	    });
    }
    
  <!--OrdersLink--> 
    
    
 	
 	$(document).on('click', '.orders-link', function(event) {
	    event.preventDefault();
	   console.log("entered orders");
	    displayOrders();
    });
    
    function displayOrders(){
    	 $.ajax({
    	      url: "listOrders",
    	      method: 'GET',
    	      success: function(response) {
    	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
    	      },
    	      error: function(xhr, status, error) {
    	        console.log('AJAX Error: ' + error);
    	      }
    	    });
    }
    
    
    
	 $(document).on('click', '#red-button', function(event) {
	    event.preventDefault();
		var orderId = $(this).data('order-id'); 
	    
	    console.log('Clicked button with order ID:', orderId);
	   processOrder(orderId);
	 });
	 
	 function processOrder(orderId){
	 	 $.ajax({
		      url: "processOrders",
		      method: 'GET',
		      data: { orderId: orderId,
		    	  adminId:1 },
		      success: function(response) {
		    	  $('#content').html(response);
		    	  console.log('processed order');
		      },
		      error: function(xhr, status, error) {
		        console.log('AJAX Error: ' + error);
		      }
		    });
	 	}
	 	
	 
	 function processedStatusFilter(){
		 console.log("working filter");
	      var selectVal = $("#processedStatusFilter").val();
	      console.log('filterDate: ');
	      $.ajax({
	        url: "loadOrdersByDate",
	        method: 'GET',
	        data: { selectDateFilter: selectVal },
	        success: function(response) {
	          $('#tableData').html(response);
	        },
	        error: function(xhr, status, error) {
	          console.log('AJAX Error: ' + error);
	        }
	      });
	    
	 }
	 
	 function changeByDate(){
		 console.log("working filter");
	      var selectVal = $("#dateRangeFilter").val();
	      console.log('filterDate: ');
	      if(selectVal!=="All"){
	      $.ajax({
	        url: "loadOrdersByDate",
	        method: 'GET',
	        data: { selectDateFilter: selectVal },
	        success: function(response) {
	          $('#tableData').html(response);
	        },
	        error: function(xhr, status, error) {
	          console.log('AJAX Error: ' + error);
	        }
	      });
	      }
	      else{
	    	  $.ajax({
	    	      url: "listOrders",
	    	      method: 'GET',
	    	      success: function(response) {
	    	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
	    	      },
	    	      error: function(xhr, status, error) {
	    	        console.log('AJAX Error: ' + error);
	    	      }
	    	    });
	      }
	    
	 }
	 $(document).on('click', '.stocks-Link', function(event) {
		    event.preventDefault();
		   console.log("entered Stocks");
		    displayStocks();
	    });
	function  displayStocks(){
		 $.ajax({
   	      url: "listStock",
   	      method: 'GET',
   	      success: function(response) {
   	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
   	      },
   	      error: function(xhr, status, error) {
   	        console.log('AJAX Error: ' + error);
   	      }
   	    });
	}
	
	
	

	
 
        //MASTER ENTRY CALLSS-----------------------------------
        
       
	
	 $(document).on('click', '.Master-Entry-Link', function(event) {
		    event.preventDefault();
		   console.log("entered Master Entry");
		    displayEditableStocks();
	    });
	 
	 
	function  displayEditableStocks(){
		 $.ajax({
	      url: "showEditableStocks",
	      method: 'GET',
	      success: function(response) {
	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
	}
	
	$(document).on('click', '#edit-button', function(event) {
	    event.preventDefault();
	    
	    var prod_id = $(this).data('prod-id');
	    var prod_gstc_id = $('#prodGstcId-input').val();
	    var image_url = $('#imageUrl-input').val();
	    var prodDesc = $('#prodDesc-input').val();
	    var reorderlevel = $('#reorderlevel-input').val();
	    var prod_stock = parseFloat($('#prodStock-input').val());
	    var prod_mrp = parseFloat($('#prodMrp-input').val());
	    
	    console.log('Clicked button with gstc ID:', prod_gstc_id,prod_stock);
	    updateMasterEntry(prod_gstc_id, image_url, prod_id, reorderlevel, prod_stock, prod_mrp);
	});

	function updateMasterEntry(prod_gstc_id, image_url, prod_id, reorderlevel, prod_stock, prod_mrp) {
	    $.ajax({
	        url: "updateMasterEntryTables",
	        method: 'GET',
	        data: {
	        	hsnCode: prod_gstc_id,
	        	imageUrl: image_url,
	        	id: prod_id,
	            reorderLevel: reorderlevel,
	            stock: prod_stock,
	           	mrp: prod_mrp
	        },
	        success: function(response) {
	            $('#content').html(response);
	            console.log('In the updation of master entry function');
	        },
	        error: function(xhr, status, error) {
	            console.log('AJAX Error: ' + error);
	        }
	    });
	}
	
	
	
	 $(document).on('click', '.add-new-product-link', function(event) {
		    event.preventDefault();
		   console.log("entered add new product in master  Entry");
		   addNewProduct();
	    });
	 

		function addNewProduct() {
		    $.ajax({
		        url: "addNewProductInTheMasterEntry",
		        method: 'GET',
		        success: function(response) {
		            $('#content').html(response);
		            showCategoriesCatalog();
		            console.log('In the updation of add new product  master entry function');
		        },
		        error: function(xhr, status, error) {
		            console.log('AJAX Error: ' + error);
		        }
		    });
		}
	
	 function showCategoriesCatalog(){
		 $.ajax({
			 url: "CategoriesServlet",
		        method: 'GET',
		        success: function(response) {
		            $('#categoryDropdown').html(response);
		            console.log('Categories are brought');
		        },
		        error: function(xhr, status, error) {
		            console.log('AJAX Error: ' + error);
		        }
		 });
	 }
	
	 $(document).on('change', '#categoryDropdown', function(event) {
		    event.preventDefault();
		    var catg=document.getElementById("categoryDropdown").value;
		   console.log("selected categoryyyyyy"+ catg);
		    
	    });
	 

	 
	 $(document).on('click', '#add-new-category-link', function(event) {
		    event.preventDefault();
		   console.log("entered add new Category in master  Entry");
		   addNewCategory();
	    });
	 

		function addNewCategory() {
		    $.ajax({
		        url: "addNewCategorytInTheMasterEntry",
		        method: 'GET',
		        success: function(response) {
		            $('#content').html(response);
		            showCategoriesCatalog();
		            console.log('In the updation of add new category  master entry function');
		        },
		        error: function(xhr, status, error) {
		            console.log('AJAX Error: ' + error);
		        }
		    });
		}
	 
		
		
		
		//Settings AJAX CALLS
		
		
		
			$(document).on('click', '.Email-Configuration', function(event) {
	    event.preventDefault();
	   console.log("entered Email-Configuration");
	    displayEmailPage();
    });
 function displayEmailPage(){
	 $.ajax({
	      url: "EmailConfigurationPage",
	      method: 'GET',
	      success: function(response) {
	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
 }
	 $(document).on('click', '.Shipping-Config', function(event) {
	    event.preventDefault();
	   console.log("enteredShipping-Config");
	    displayShippingConfig();
 });
function displayShippingConfig(){
	console.log("in displayShippingConfig");
	 $.ajax({
	      url: "ShippingRedirect",
	      method: 'GET',
	      success: function(response) {
	        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
	      },
	      error: function(xhr, status, error) {
	        console.log('AJAX Error: ' + error);
	      }
	    });
}
	

$(document).on('click', '.OrderValueWise', function(event) {
    event.preventDefault();
   console.log("Entered shipemnents Space ");
    dischar();
});
function dischar(){
console.log("in viewing OrderValueWisePage");
 $.ajax({
      url: "OrderValueWisePage",
      method: 'GET',
      success: function(response) {
        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
}


$(document).on('click', '.ProductWise', function(event) {
    event.preventDefault();
   console.log("Entered shipemnents Space ");
    dispr();
});
function dispr(){
console.log("in viewing ProductWise");
 $.ajax({
      url: "productWisePage",
      method: 'GET',
      success: function(response) {
        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
}


	
<!-- Shipments Methods      -->

$(document).on('click', '.see-shipping-orders', function(event) {
    event.preventDefault();
   console.log("Entered shipemnents Space ");
    displayProcessedOrders();
});


function displayProcessedOrders(){
console.log("in viewing Orders");
 $.ajax({
      url: "displayProcessedOrdersInShipments",
      method: 'GET',
      success: function(response) {
        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
}

$(document).on('click', '.track-shipments', function(event) {
    event.preventDefault();
   console.log("Entered to see shipped orders  ");
    displayShippedOrders();
});


function displayShippedOrders(){
console.log("in viewing  shipped Orders");
 $.ajax({
      url: "displayShippedOrders",
      method: 'GET',
      success: function(response) {
        $('#content').html(response); // Set the response HTML as the inner HTML of the select element
      },
      error: function(xhr, status, error) {
        console.log('AJAX Error: ' + error);
      }
    });
}




	
    </script>
</head>
<body>
    <div class="dashboard" id="dashboard">
        <h2>Dashboard</h2>
        <ul>
            
            <li><a href="#" class="profile-link">Profile</a></li>
            <li><a href="#" class="orders-link">Orders</a></li>
			<li><a href="#" class="Shipments-SubOptions">Shipments</a>
				 <ul class="sub-menu" >
	                <li><a href="#" class="see-shipping-orders">In Progress</a></li>
	                <li><a  href="#" class="track-shipments">Shipped</a></li>
            	</ul>
			</li>
			<li><a href="#">reports</a></li>
			<li><a href="#" class="Master-Entry-SubOptions">Master Entry</a>
			  
            <ul class="sub-menu" >
                <li><a href="#" class="Master-Entry-Link">Update Stocks</a></li>
                <li><a  href=# class="add-new-product-link">Add New Product</a></li>
                <li><a href="#" id="add-new-category-link">Add New Category</a></li>
            </ul>
			</li>
			<li><a href="#" class="stocks-Link">Stocks</a></li>
            <li><a href="#" class="payments-link">payments</a></li>
             <li class="dropdown">
            <a href="#" class="dropdown-toggle" onclick="toggleDropdown()">Settings</a>
            <ul class="dropdown-menu" id="settingsDropdown" style="background-color: #212529">
                <li><a href="#" class="Email-Configuration">Email Configuration</a></li>
                <li><a href="#" class="Shipping-Config">Shipping Area Config</a></li>
                <li><a href="#" class="Master-Entry-SubOptions">shipping charges</a>
                <ul class="sub-menu" >
                <li><a href="#" class="OrderValueWise">OrderValueWise</a></li>
              
            </ul>
			</li>
            </ul>
        </li>
            <li><a href="#">Logout</a></li>
        </ul>
    </div>
    
    <div class="menu-icon" onclick="toggleMenu()">
        <span></span>
        <span></span>
        <span></span>
    </div>
    
    <div class="content" id="content">
        <h1>Welcome to the Dashboard</h1>
        <p>This is the main content area of the page. It can include various data visualizations and informative sections.</p>
        
        <div class="data-visualization">
            <div class="item">
                <h3>Orders</h3>
                <p>5 orders in progress</p>
            </div>
            <div class="item">
                <h3>Products</h3>
                <p>100 products in store</p>
            </div>
            <div class="item">
                <h3>Registered Customers</h3>
                <p>500 registered customers</p>
            </div>
        </div>
    </div>
</body>
</html>