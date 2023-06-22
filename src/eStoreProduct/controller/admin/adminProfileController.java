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
public class adminProfileController {
	adminDAO adao;

	@Autowired
	public adminProfileController(adminDAO admindao) {
		adao = admindao;

	}

	@RequestMapping(value = "/displayAdminProfile", method = RequestMethod.GET)
	public String getAdminLogin(Model model, HttpSession session) {
		System.out.println("Admin Profile Page");
		adminModel am = (adminModel) session.getAttribute("admin");
		model.addAttribute("am", am);
		// call the view
		return "adminProfile";
	}

	@RequestMapping(value = "/editAdminProfile", method = RequestMethod.GET)
	public String editAdminDetails(Model model) {
		System.out.println("editable Admin Profile Page");

		// call the view
		return "editableAdminProfile";
	}

	@RequestMapping(value = "/updateAdminDetails", method = RequestMethod.GET)
	public String updateAdminDetails(@Validated adminLogin al, Model model) {
		System.out.println("updating Admin Profile Page");
		adminModel am = adao.getAdmin(al.getEmail(), al.getPassword());
		adao.updateAdmin(am);
		// call the view
		return "adminProfile";
	}

}