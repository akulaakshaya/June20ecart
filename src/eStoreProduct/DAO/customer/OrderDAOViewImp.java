package eStoreProduct.DAO.customer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import eStoreProduct.model.customer.output.OrdersMapper;
import eStoreProduct.model.customer.output.OrdersViewModel;

@Component
public class OrderDAOViewImp implements OrderDAOView {

	private final JdbcTemplate jdbcTemplate;
	private final RowMapper<OrdersViewModel> ordersMapper;

	public OrderDAOViewImp(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		this.ordersMapper = new OrdersMapper();
	}

	public List<OrdersViewModel> getorderProds() {
		String query = "SELECT sp.prod_id, sp.prod_title, " + "sp.image_url, sp.prod_desc, "
				+ "sps.prod_price, o.ordr_id, op.orpr_shipment_status " + "FROM slam_orders_dup o "
				+ "JOIN e_orderproducts op ON o.Ordr_id = op.Ordr_id "
				+ "JOIN slam_products sp ON op.prod_id = sp.prod_id "
				+ "JOIN slam_productstock sps ON sp.prod_id = sps.prod_id " + "WHERE o.ordr_cust_id = ?";

		return jdbcTemplate.query(query, new Object[] { 1 }, ordersMapper);
	}

	public OrdersViewModel OrdProductById(Integer productId) {
		String query = "SELECT sp.prod_id, sp.prod_title, " + "sp.image_url, sp.prod_desc, "
				+ "sps.prod_price, o.ordr_id, op.orpr_shipment_status " + "FROM slam_orders_dup o "
				+ "JOIN e_orderproducts op ON o.Ordr_id = op.Ordr_id "
				+ "JOIN slam_products sp ON op.prod_id = sp.prod_id "
				+ "JOIN slam_productstock sps ON sp.prod_id = sps.prod_id "
				+ "WHERE o.ordr_cust_id = ? AND sp.prod_id = ?";

		return jdbcTemplate.queryForObject(query, new Object[] { 1, productId }, ordersMapper);
	}

	public void cancelorderbyId(Integer productId) {
		String updateQuery = "UPDATE e_OrderProducts SET orpr_shipment_status = 'cancelled' WHERE prod_id = ?";
		jdbcTemplate.update(updateQuery, productId);

	}

	@Override
	public String getShipmentStatus(int orderId) {

		String sql = "SELECT orpr_shipment_status FROM e_orderproducts WHERE prod_id = ?";

		try {
			return jdbcTemplate.queryForObject(sql, new Object[] { orderId }, String.class);
		} catch (EmptyResultDataAccessException e) {
			return null; // Handle the case when shipment status is not found
		}

	}

	@Override
	public List<OrdersViewModel> sortProductsByPrice(List<OrdersViewModel> ordersList, String sortOrder) {
		// System.out.println("pdaoimp class sortbyprice method");

		if (sortOrder.equals("lowToHigh")) {
			Collections.sort(ordersList);
		} else if (sortOrder.equals("highToLow")) {
			Collections.sort(ordersList, Collections.reverseOrder());
		}

		return ordersList;
	}

	@Override
	public List<OrdersViewModel> filterProductsByPriceRange(List<OrdersViewModel> filteredProducts, double minPrice,
			double maxPrice) {
		List<OrdersViewModel> res = new ArrayList<>();
		for (OrdersViewModel product : filteredProducts) {
			if (product.getPrice() >= minPrice && product.getPrice() <= maxPrice) {
				System.out.println(product.getPrice() + "in filter productdao");
				res.add(product);
			}
		}
		return res;
	}

}
