/*
 * package eStoreProduct.controller; import javax.servlet.http.HttpSession;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import org.springframework.stereotype.Controller;
 * import org.springframework.ui.Model; import org.springframework.validation.annotation.Validated; import
 * org.springframework.web.bind.annotation.ModelAttribute; import org.springframework.web.bind.annotation.PostMapping;
 * import org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import org.springframework.web.bind.annotation.RequestParam;
 * import org.springframework.web.bind.annotation.ResponseBody;
 * 
 * import eStoreProduct.DAO.cartDAO; import eStoreProduct.DAO.customerDAO; import eStoreProduct.model.emailSend;
 * 
 * @Controller public class ForgotController {
 * 
 * String generateotp; String finalemail; customerDAO cdao;
 * 
 * @Autowired public ForgotController(customerDAO customerdao) { cdao = customerdao; //cartdao1 = cartdao; }
 * 
 * @RequestMapping(value = "/forgotPassword", method = RequestMethod.GET) public String forgotPswd(Model model) {
 * System.out.println("mail forget Page");
 * 
 * // // call the view return "forgotPage"; }
 * 
 * @PostMapping("/otpAction")
 * 
 * @ResponseBody public String sendOTP(@RequestParam("email") String email) { finalemail = email; generateotp = (new
 * emailSend()).sendEmail(email);
 * 
 * return generateotp; // Return the generated OTP as the response }
 * 
 * @PostMapping("/validateOTP")
 * 
 * @ResponseBody public String validateOTP(@RequestParam("otp12") String otp) { System.out.print("validate"+otp);
 * 
 * if (otp.equals(generateotp)) { return "valid"; } else { // OTP is invalid return "invalid"; } }
 * 
 * @RequestMapping(value = "/updatepwd") public String usersignup(@RequestParam("psd2") String p2, Model model) {
 * cdao.updatePassword(p2, finalemail);
 * 
 * return "signIn"; } }
 */

package eStoreProduct.controller.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import eStoreProduct.DAO.customer.customerDAO;
import eStoreProduct.externalServices.emailSend;
import eStoreProduct.model.customer.entities.custCredModel;

@Controller
public class ForgotController {

	String generateotp;
	String finalemail;
	customerDAO cdao;
	custCredModel cust;
	java.time.LocalDateTime t1;// = java.time.LocalDateTime.now();

	@Autowired
	public ForgotController(customerDAO customerdao) {
		cdao = customerdao;
		// cartdao1 = cartdao;
	}

	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public String forgotPswd(Model model) {
		// System.out.println("mail forget Page");

		// // call the view
		return "forgotPage";
	}

	@PostMapping("/otpAction")
	@ResponseBody
	public String sendOTP(@RequestParam("email") String email) {
		finalemail = email;
		cust = cdao.getCustomerByEmail(email);

		generateotp = (new emailSend()).sendEmail(email);
		t1 = java.time.LocalDateTime.now();
		// System.out.println("pevious time "+t1);
		// cust=cdao.updatelastlogin(cust.getCustId());
		// System.out.println("updated time "+cust.getCustLastLoginDate());

		return generateotp; // Return the generated OTP as the response
	}

	@PostMapping("/emailValid")
	@ResponseBody
	public String verifyEmail(@RequestParam("email") String email) {
		// System.out.println("email valid method");
		finalemail = email;
		cust = cdao.getCustomerByEmail(email);
		if (cust == null)
			return "no";
		return "yes"; // Return the generated OTP as the response
	}

	@PostMapping("/validateOTP")
	@ResponseBody
	public String validateOTP(@RequestParam("otp12") String otp) {
		// System.out.println("validate" + otp);

		if (otp.equals(generateotp)) {
			// java.sql.Timestamp timestamp1 = cust.getCustLastLoginDate();
			// java.time.LocalDateTime t1 = timestamp1.toLocalDateTime();
			java.time.LocalDateTime t2 = java.time.LocalDateTime.now();
			java.time.Duration duration = java.time.Duration.between(t1, t2);
			// System.out.println("t1: " + t1);
			/// System.out.println("t2: " + t2);
			// System.out.println();
			long seconds = duration.getSeconds();
			// System.out.println("seconds: " + seconds);
			if (seconds <= 30) {
				return "valid";
			} else {
				return "no";
			}
		} else {
			// OTP is invalid
			return "invalid";
		}
	}

	@RequestMapping(value = "/updatepwd")
	public String usersignup(@RequestParam("psd2") String p2, Model model) {
		cdao.updatePassword(p2, finalemail);

		return "signIn";
	}
}