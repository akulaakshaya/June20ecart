package eStoreProduct.controller.customer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// import eStoreProduct.BLL.BLLClass;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import eStoreProduct.BLL.BLL;
import eStoreProduct.DAO.common.ProductDAO;
import eStoreProduct.DAO.customer.ServicableRegionDAO;
import eStoreProduct.DAO.customer.cartDAO;
import eStoreProduct.DAO.customer.customerDAO;
import eStoreProduct.model.customer.entities.cartModel;
import eStoreProduct.model.customer.entities.custCredModel;
import eStoreProduct.model.customer.output.customerOutputModel;
import eStoreProduct.utility.ProductStockPrice;

@Controller
public class CartController {
	ServicableRegionDAO sdao;
	static boolean flag = false;
	cartDAO cartimp;
	private final ProductDAO pdaoimp;
	List<ProductStockPrice> alist = new ArrayList<>();
	customerDAO cdao;
	// ______________
	BLL BLL;

	// BLLClass obj = new BLLClass();
	@Autowired
	public CartController(cartDAO cartdao, ProductDAO productdao, customerDAO cdao, BLL b, ServicableRegionDAO sdao) {
		cartimp = cartdao;
		pdaoimp = productdao;
		this.cdao = cdao;
		this.sdao = sdao;
		BLL = b;
	}

	@GetMapping("/addToCart")
	@ResponseBody
	public String addToCart(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			return cartimp.addToCart(productId, cust1.getCustId());
		} else {
			ProductStockPrice product = pdaoimp.getProductById(productId);
			for (ProductStockPrice p : alist) {
				if (p.getProd_id() == product.getProd_id()) {
					return "Already added to cart";
				}
			}
			product.setQuantity(1);
			alist.add(product);
			model.addAttribute("alist", alist);
			return "Added to cart";

		}
	}

	@RequestMapping(value = "/cartDisplay", method = RequestMethod.GET)
	public String getSignUpPage(Model model, HttpSession session) {
		double cartt = 0;
		// ProductDAO pdao = new ProductDAO();
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			List<ProductStockPrice> products = cartimp.getCartProds(cust1.getCustId());
			model.addAttribute("products", products);
			double cartcost = BLL.getCartCost(cust1.getCustId());
			model.addAttribute("cartcost", cartcost);

			// Forward to the cart.jsp view
			return "cart";
		} else {
			// Set the products attribute in the model
			double cartcost = BLL.getCartCost(alist);
			model.addAttribute("cartcost", cartcost);
			model.addAttribute("alist", alist);
			return "cart";

		}
	}

	@RequestMapping(value = "/signOk", method = RequestMethod.GET)
	public String getHomeFinal(@Validated customerOutputModel com, Model model, HttpSession session) {
		// Retrieve the products ArrayList from the model
		customerOutputModel cust = cdao.getCustomer(com.getCustEmail(), com.getCustPassword());

		if (cust != null) {
			flag = true;
		}
		try {
			cdao.updatelastlogin(cust.getCustId());
			session.setAttribute("customer", cust);
			model.addAttribute("fl", flag);

		} catch (Exception e) {
			System.out.println(e);
		}
		if (alist != null) {
			cartimp.updateinsert(alist, cust.getCustId());
			List<ProductStockPrice> products = cartimp.getCartProds(cust.getCustId());
			model.addAttribute("products", products);
			return "home";
		}

		return "home";
	}

	@GetMapping("/removeFromCart")
	@ResponseBody
	public String removeFromCart(@RequestParam(value = "productId", required = true) int productId, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			System.out.println("remove from cart login");
			cartimp.removeFromCart(productId, cust1.getCustId());
			return "Removed from cart";
		} else {

			for (ProductStockPrice p : alist) {
				if (p.getProd_id() == productId)

					alist.remove(p);
			}

			return "Removed from cart";
		}

	}

	// @PostMapping("/updateQuantity")
	// public int updateQuantity(@RequestParam(value = "productId", required = true) int productId,
	// @RequestParam(value = "quantity", required = true) int quantity, Model model, HttpSession session)
	// throws NumberFormatException, SQLException {
	// custCredModel cust1 = (custCredModel) session.getAttribute("customer");
	// if (cust1 != null) {
	// cartModel cart = new cartModel(cust1.getCustId(), productId, quantity);
	// return cartimp.updateQty(cart);
	// } else {
	// for (ProductStockPrice product : alist) {
	// if (product.getProd_id() == productId) {
	// product.setQuantity(quantity);
	// }
	// }
	// }
	// return quantity;
	// }

	@PostMapping("/updateQuantity")
	@ResponseBody
	public String updateQuantity(@RequestParam(value = "productId", required = true) int productId,
			@RequestParam(value = "quantity", required = true) int quantity, Model model, HttpSession session)
			throws NumberFormatException, SQLException {
		double cartcost = 0.0;
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			// System.out.println("custid "+cust1.getCustId());
			cartModel cart = new cartModel(cust1.getCustId(), productId, quantity);
			cartimp.updateQty(cart);
			List<ProductStockPrice> products = cartimp.getCartProds(cust1.getCustId());
			session.setAttribute("products", products);
			cartcost = (BLL.getCartCost(cust1.getCustId()));
			String ccost = String.valueOf(cartcost);
			// model.addAttribute("cartcost",cartcost);
			System.out.println("done updating quantity");
			return ccost;
		} else {
			for (ProductStockPrice product : alist) {
				if (product.getProd_id() == productId) {
					product.setQuantity(quantity);
				}
			}
			cartcost = (BLL.getCartCost(alist));
			return String.valueOf(cartcost);
		}
	}

	@PostMapping("/updateCostOnLoad")
	@ResponseBody
	public String updateCostOnLoad(Model model, HttpSession session) throws NumberFormatException, SQLException {
		double cartcost = 0.0;
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			// System.out.println("custid "+cust1.getCustId());
			List<ProductStockPrice> products = cartimp.getCartProds(cust1.getCustId());
			session.setAttribute("products", products);
			cartcost = (BLL.getCartCost(cust1.getCustId()));
			String ccost = String.valueOf(cartcost);
			// model.addAttribute("cartcost",cartcost);
			System.out.println("done updating quantity");
			return ccost;
		} else {
			cartcost = (BLL.getCartCost(alist));
			return String.valueOf(cartcost);
		}
	}

	@PostMapping("/checkPincodeValidity")
	@ResponseBody
	public boolean checkPincodeValidity(@RequestParam(value = "pincode", required = true) String pincode, Model model,
			HttpSession session) throws NumberFormatException, SQLException {
		return sdao.getValidityOfPincode(Integer.parseInt(pincode));

	}

}
