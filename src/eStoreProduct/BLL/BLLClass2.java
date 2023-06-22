package eStoreProduct.BLL;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

@Component
public class BLLClass2 {

	public String createRazorpayOrder(double amt) {
		System.out.println("amount in razorpay  " + amt);
		long amountInPaise = (long) (amt * 100);
		String orderId = null;
		try {
			RazorpayClient razorpayClient = new RazorpayClient("rzp_test_Eu94k5nuplVQzA", "iC6DFpPEkTIq0UGGQalJir6s");
			JSONObject obj = new JSONObject();
			obj.put("amount", amountInPaise);
			obj.put("currency", "INR");
			obj.put("receipt", "hello123");
			obj.put("payment_capture", true);
			Order order = razorpayClient.orders.create(obj);
			orderId = order.get("id");
			System.out.println(order.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderId;
	}
}
