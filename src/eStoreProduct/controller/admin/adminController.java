package eStoreProduct.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import eStoreProduct.DAO.admin.adminDAO;
import eStoreProduct.model.admin.entities.adminModel;
import eStoreProduct.model.admin.input.adminLogin;

@Controller
public class adminController {
	adminDAO adao;

	@Autowired
	public adminController(adminDAO adminDAO) {
		adao = adminDAO;

	}

	@RequestMapping(value = "/adminLogin", method = RequestMethod.GET)
	public String getAdminLogin(Model model) {
		System.out.println("Admin Page");

		// call the view
		return "adminSignIn";
	}

	@RequestMapping(value = "/adminSignOk", method = RequestMethod.POST)
	public String getHomeFinal(@Validated adminLogin al, Model model, HttpSession session) {

		System.out.println("checking admin sign in");

		adminModel ad = adao.getAdmin(al.getEmail(), al.getPassword());

		System.out.println("checking sign in 1");
		if (ad != null) {
			session.setAttribute("admin", ad); // Store admin object
			System.out.println(ad.getTitle());
			model.addAttribute("admin", ad);
			System.out.println(ad.getTitle());

		} else {
			return "adminSignIn";
		}

		return "admin";
	}

}