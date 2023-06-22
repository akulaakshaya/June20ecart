package eStoreProduct.controller.customer;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import eStoreProduct.DAO.customer.WishlistDAO;
import eStoreProduct.model.customer.output.customerOutputModel;
import eStoreProduct.utility.ProductStockPrice;

@Controller
public class WishlistController {

	WishlistDAO wishlistdao;

	@Autowired
	public WishlistController(WishlistDAO wishlistimp) {
		wishlistdao = wishlistimp;
	}

	@GetMapping("/addToWishlist")
	@ResponseBody
	public String addToWishlist(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		System.out.println("add to wishlist called1");
		customerOutputModel cust = (customerOutputModel) session.getAttribute("customer");
		wishlistdao.addToWishlist(productId, cust.getCustId());
		return "Item added to wishlist";
	}

	@GetMapping("/removeFromWishlist")
	@ResponseBody
	public String removeFromWishlist(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		System.out.println("remove from wishlist called1");
		// ProductDAO pdao = new ProductDAO();
		System.out.println("remove from wishlist called2");
		customerOutputModel cust = (customerOutputModel) session.getAttribute("customer");
		wishlistdao.removeFromWishlist(productId, cust.getCustId());
		return "Item removed from wishlist";
	}

	@GetMapping("/wishlistItems")
	// @ResponseBody
	public String userWishlistItems(Model model, HttpSession session) throws NumberFormatException, SQLException {
		System.out.println("wishlist called1");
		customerOutputModel cust1 = (customerOutputModel) session.getAttribute("customer");
		List<ProductStockPrice> products = wishlistdao.getWishlistProds(cust1.getCustId());

		// Set the products attribute in the model
		model.addAttribute("products", products);

		// Forward to the wishlist.jsp view
		return "wishlistCatalog";
	}

}
