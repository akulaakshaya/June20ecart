package eStoreProduct.controller.customer;

import java.sql.SQLException;
import java.util.List;

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
import eStoreProduct.BLL.BLLClass2;
import eStoreProduct.DAO.common.OrderDAO;
import eStoreProduct.DAO.common.ProductDAO;
import eStoreProduct.DAO.customer.cartDAO;
import eStoreProduct.DAO.customer.customerDAO;
import eStoreProduct.model.customer.entities.custCredModel;
import eStoreProduct.model.customer.input.customerInputModel;
import eStoreProduct.model.customer.output.customerOutputModel;
import eStoreProduct.utility.ProductStockPrice;

@Controller
public class CustomerController {
	customerDAO cdao;
	// BLLClass obj;
	cartDAO cartimp;

	BLL BLL;
	BLLClass2 bl2;
	String buytype = null;
	ProductDAO pdaoimp;
	OrderDAO odao;
	List<ProductStockPrice> products = null;

	@Autowired
	public CustomerController(cartDAO cartdao, customerDAO customerdao, BLLClass2 bl2, BLL bl1, ProductDAO productdao,
			OrderDAO odao) {
		cdao = customerdao;
		cartimp = cartdao;
		this.bl2 = bl2;
		this.BLL = bl1;
		pdaoimp = productdao;
		this.odao = odao;
		// cartdao1 = cartdao;
	}

	@RequestMapping(value = "/profilePage")
	public String sendProfilePage(Model model, HttpSession session) {
		customerOutputModel cust = (customerOutputModel) session.getAttribute("customer");
		// System.out.println(cust.getCustId());
		model.addAttribute("cust", cust);
		return "profile";
	}

	// on clicking update Profile in profile page
	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public String userupdate(@Validated customerInputModel cust, Model model, HttpSession session) {

		cdao.updatecustomer(cust);
		custCredModel custt = cdao.getCustomerById(cust.getCustId());
		if (custt != null) {
			model.addAttribute("cust", custt);
		}
		return "profile";
	}

	@GetMapping("/buycartitems")
	public String confirmbuycart(Model model, HttpSession session) {

		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			System.out.println("Entered into buycartitems");
			BLL.calculateTotalfair(cust1);
			System.out.println("Entered into buycartitems1");

			products = BLL.GetQtyItems2();
			System.out.println("Entered into buycartitems2");

			model.addAttribute("products", products);
			buytype = "cartproducts";
			double amountInPaisa = (products.getPrice() * 100); // Convert amount to paisa
			String orderId = bl2.createRazorpayOrder(amountInPaisa);
			// String orderId = bl2.createRazorpayOrder(totalAmount);
			model.addAttribute("amt", amountInPaisa);
			return "paymentpreview";
		} else {
			return "signIn";
		}

	}

	@GetMapping("/done")
	public String orderCreation(Model model) {
		return "redirect:/OrderCreation";
	}

	@PostMapping("/confirmShipmentAddress")
	@ResponseBody
	public String confirm(@RequestParam(value = "mobile") String mobile,
			@RequestParam(value = "custsaddress") String custsaddress, @RequestParam(value = "spincode") int spincode,
			Model model, HttpSession session) {
		// System.out.println("confirm shipmentaddress");
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		custCredModel cust2 = new custCredModel();
		cust2.setCustMobile(mobile);
		cust2.setCustSAddress(custsaddress);
		cust2.setCustPincode(spincode);
		session.setAttribute("cust2", cust2);
		// cdao.updateshipmentaddress(cust1.getCustId(), shaddr);
		return "OK";

	}

	@PostMapping("/updateshipment")
	@ResponseBody
	public String handleFormSubmission(@RequestParam(value = "pincode") int pincode) {

		boolean isValid = pdaoimp.isPincodeValid(pincode);
		if (isValid) {

			return "Valid";
		} else {
			return "Not Valid";
		}
	}

	@PostMapping(value = "/invoice")
	public String invoice(@RequestParam("razorpay_payment_id") String id, Model model, HttpSession session) {
		System.out.println("hiiiiiiiiii invoice");
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");

		if (buytype.equals("cartproducts")) {
			products = BLL.GetQtyItems2();
		} else {
			products = (List<ProductStockPrice>) session.getAttribute("products");
		}

		// double var = bl1.GetQtyPrice(cust1.getCustId());

		// String priceString = String.valueOf(var);

		System.out.println(id);
		model.addAttribute("customer", cust1);
		model.addAttribute("payid", id);
		model.addAttribute("products", products);
		// model.addAttribute("total", priceString);

		return "invoice";
	}

	@GetMapping("/buythisproduct")
	public String buythisproduct(@RequestParam(value = "productId", required = true) int productId,
			@RequestParam(value = "qty", required = true) int qty, Model model, HttpSession session)
			throws NumberFormatException, SQLException {
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		ProductStockPrice product = BLL.individualTotalfair(cust1, productId, qty);
		// List<ProductStockPrice> products = new ArrayList<ProductStockPrice>();
		// session.setAttribute("products", products); // Store customer object in the session

		// products.add(product);
		buytype = "individual";
		// String orderId = bl2.createRazorpayOrder(Integer.parseInt(String.valueOf(product.getPrice())));
		// String orderId = bl2.createRazorpayOrder(totalAmount);
		// double cartcost=BLL.getCartCost(cust1.getCustId());
		double amountInPaisa = (product.getPrice() * 100); // Convert amount to paisa
		String orderId = bl2.createRazorpayOrder(amountInPaisa);
		model.addAttribute("products", product);
		model.addAttribute("orderId", orderId); // Pass the orderId to the view
		model.addAttribute("amt", amountInPaisa);

		return "paymentpreview";

	}

	@GetMapping("/checkloginornot")
	@ResponseBody
	public String buyproduct(Model model, HttpSession session) throws NumberFormatException, SQLException {
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if (cust1 != null) {
			return "true";
		} else {
			return "false";
		}

	}

}
