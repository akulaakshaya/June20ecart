package eStoreProduct.DAO.customer;

import java.util.List;

import eStoreProduct.model.customer.output.OrdersViewModel;

public interface OrderDAOView {
	public List<OrdersViewModel> getorderProds();

	public OrdersViewModel OrdProductById(Integer productId);

	public void cancelorderbyId(Integer productId);

	public String getShipmentStatus(int orderId);

	public List<OrdersViewModel> sortProductsByPrice(List<OrdersViewModel> orderLists, String sortOrder);

	public List<OrdersViewModel> filterProductsByPriceRange(List<OrdersViewModel> productList, double minPrice,
			double maxPrice);
	// public List<OrdersViewModel> getsortbypricel_low_to_high();
}
