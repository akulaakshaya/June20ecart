package eStoreProduct.controller.admin;



import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import eStoreProduct.DAO.admin.AdminViewPaymentDAO;
import eStoreProduct.DAO.admin.AdminViewPaymentDAOImp;
import eStoreProduct.model.admin.output.AdminViewPayments;

@Controller
public class adminViewPaymentsController {
    private final AdminViewPaymentDAO adminPayment;

    @Autowired
    public adminViewPaymentsController(AdminViewPaymentDAO adminPayment) {
        this.adminPayment = adminPayment;
    }

    // Getting all payments done
    @GetMapping("/viewPayments")
    public String showPayments(Model model) {
        System.out.println("Enter payment controller");
        List<AdminViewPayments> payments = adminPayment.getPayments();
        model.addAttribute("payments", payments);
        return "viewPayments";
    }

    // Getting payments between selected dates
    @GetMapping("/getBetweenDatesPayments")
    public String showBetweenPayments(@RequestParam("startDate") Date startDate,
                                      @RequestParam("endDate") Date endDate,
                                      Model model) {
        System.out.println("Enter payment controller for between dates");
        System.out.println("date1       "+startDate+"   end   "+endDate);
        Timestamp start = convertToTimestampWithoutTime(startDate);
        Timestamp end = convertToTimestampWithoutTime(endDate);
        System.out.println("date1       "+start+"   end   "+end);
        
        List<AdminViewPayments> payments = adminPayment.getDatePayments(start, end);
        for(AdminViewPayments a:payments)
        	System.out.println("payments    "+a);
        model.addAttribute("payments", payments);
        return "viewPayments";
    }
    private Timestamp convertToTimestampWithoutTime(Date date) {
        LocalDate localDate = date.toLocalDate();
        LocalDateTime localDateTime = LocalDateTime.of(localDate, LocalTime.MIN);
        return Timestamp.valueOf(localDateTime);
    }
    @PostMapping("/filterPayments")
    public String showFilterPayments(@RequestParam("priceRange") String priceRange,Model model) {
        System.out.println("Enter payment controller");
        List<AdminViewPayments> payments = adminPayment.getPayments();    
        double minPrice;
		double maxPrice = 0;
		// Parse the selected price range
		if (priceRange.equals("0-10000")) {
			minPrice = 0.0;
			maxPrice = 10000;
		} else if (priceRange.equals("10000-20000")) {
			minPrice = 10000;
			maxPrice = 20000;
		} else if (priceRange.equals("20000-30000")) {
			minPrice = 20000;
			maxPrice = 30000;
		} else {
			minPrice=30000;
			payments=adminPayment.getMaxPrice(minPrice);
			model.addAttribute("payments", payments);
			return "viewPayments";
		}
		System.out.println("min price  " + minPrice + "    maxprice  " + maxPrice);
		// Call the filterProductsByPriceRange() method from the DAO
		payments=adminPayment.getFilterPayments(minPrice,maxPrice);
		//List<ProductStockPrice> products = pdaoimp.filterProductsByPriceRange(minPrice, maxPrice);
		model.addAttribute("payments", payments);
        
        return "viewPayments";
    }
}