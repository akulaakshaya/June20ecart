package eStoreProduct.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import eStoreProduct.DAO.customer.OrderDAOView;
import eStoreProduct.model.customer.output.OrdersViewModel;

@Controller
public class customerOrderController {
	// @Autowired
	// private ProductDAO pdaoimp;

	@Autowired
	private OrderDAOView orderdaov;

	@RequestMapping("/CustomerOrdersProfile")
	public String showOrders(Model model) {
		System.out.println("inshow");
		List<OrdersViewModel> orderProducts = orderdaov.getorderProds();
		model.addAttribute("orderProducts", orderProducts);
		return "orders";
	}

	@GetMapping("/productDetails")
	public String getProductDetails(@RequestParam("id") int productId, Model model) {
		// Use your product DAO implementation to fetch the product details by ID
		OrdersViewModel product = orderdaov.OrdProductById(productId);
		model.addAttribute("product", product);
		return "OrdProDetails";
	}

	@PostMapping("/cancelOrder")
	@ResponseBody
	public String cancelOrder(@RequestParam("orderproId") Integer productId) {
		orderdaov.cancelorderbyId(productId);

		return "Order with ID " + productId + " has been cancelled.";
	}

	@RequestMapping(value = "/trackOrder", method = RequestMethod.GET)
	@ResponseBody
	public String trackOrder(@RequestParam("orderproId") int orderId) {
		// Retrieve the shipment status for the given order ID
		String shipmentStatus = orderdaov.getShipmentStatus(orderId);

		return shipmentStatus;
	}

	@RequestMapping(value = "/sortorders", method = RequestMethod.POST)
	public String sortProducts(@RequestParam("sortOrder") String sortOrder, Model model) {
		// Sort the products based on the selected sorting option
		List<OrdersViewModel> ordersList = orderdaov.getorderProds();

		if (sortOrder.equals("lowToHigh") || sortOrder.equals("highToLow")) {
			ordersList = orderdaov.sortProductsByPrice(ordersList, sortOrder);
			model.addAttribute("orderProducts", ordersList);
		}
		// Return the view
		return "orders";
	}

	@RequestMapping(value = "/filterorderProducts", method = RequestMethod.POST)
	public String getFilteredProducts(@RequestParam("priceRange") String priceRange, Model model) {
		double minPrice;
		double maxPrice;
		List<OrdersViewModel> productList = orderdaov.getorderProds();

		// Parse the selected price range
		if (priceRange.equals("0-500")) {
			minPrice = 0.0;
			maxPrice = 500.0;
		} else if (priceRange.equals("500-1000")) {
			minPrice = 500.0;
			maxPrice = 1000.0;
		} else if (priceRange.equals("1000-2000")) {
			minPrice = 1000.0;
			maxPrice = 2000.0;
		} else if (priceRange.equals("2000-4000")) {
			minPrice = 2000.0;
			maxPrice = 4000.0;
		} else {
			// Default range or invalid option selected
			model.addAttribute("orderProducts", productList);
			return "orders";
		}
		System.out.println("min price  " + minPrice + "    maxprice  " + maxPrice);
		// Call the filterProductsByPriceRange() method from the DAO
		List<OrdersViewModel> filteredList = orderdaov.filterProductsByPriceRange(productList, minPrice, maxPrice);
		model.addAttribute("orderProducts", filteredList);
		System.out.println(filteredList + "in filterProducts");
		return "orders";
	}

}
