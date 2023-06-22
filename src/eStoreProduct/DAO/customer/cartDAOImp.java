package eStoreProduct.DAO.customer;

import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import eStoreProduct.DAO.admin.ProdStockDAO;

/*
 * import eStoreProduct.model.ServiceableRegion; import eStoreProduct.model.hsnModel;
 */

import eStoreProduct.model.customer.entities.cartModel;
import eStoreProduct.model.customer.output.ServiceableRegion;
import eStoreProduct.utility.ProductStockPrice;

@Component
public class cartDAOImp implements cartDAO {
	JdbcTemplate jdbcTemplate;
	private ProdStockDAO prodStockDAO;

	@Autowired
	public cartDAOImp(DataSource dataSource, ProdStockDAO prodStockDAO) {
		jdbcTemplate = new JdbcTemplate(dataSource);
		this.prodStockDAO = prodStockDAO;
	}

	private String insert_slam_cart = "INSERT INTO slam_cart (cust_id,prod_id,quantity) VALUES (?, ?,1)";
	private String delete_slam_cart = "DELETE FROM SLAM_CART WHERE cust_id=? AND prod_id=?";
	private String select_cart_products = "SELECT pd.*,sc.* FROM slam_Products pd, slam_cart sc WHERE sc.cust_id = ? AND sc.prod_id = pd.prod_id";
	private String update_qty = "update slam_cart set quantity=? where cust_id=? and prod_id=?";
	private String insert = "insert into slam_cart values(?,?,?);";

	public String addToCart(int productId, int customerId) {
		List<ProductStockPrice> cproducts = jdbcTemplate.query(select_cart_products,
				new CartProductRowMapper(prodStockDAO), customerId);
		int r;
		int flag = 0;
		for (ProductStockPrice product : cproducts) {
			if (product.getProd_id() == productId) {
				flag = 1;
			}
		}
		if (flag == 0) {
			r = jdbcTemplate.update(insert_slam_cart, customerId, productId);
			if (r > 0) {
				System.out.println("inserted into cart");
				return "Added to cart";
			}
			return "error";
		}
		return "Already added to cart";
	}

	public int removeFromCart(int productId, int customerId) {
		int r = jdbcTemplate.update(delete_slam_cart, customerId, productId);
		if (r > 0) {
			System.out.println("deleted from  cart");
			return productId;
		} else {
			return -1;
		}
	}

	public List<ProductStockPrice> getCartProds(int cust_id) {
		System.out.println(cust_id + " from model");
		try {
			List<ProductStockPrice> cproducts = jdbcTemplate.query(select_cart_products,
					new CartProductRowMapper(prodStockDAO), cust_id);
			System.out.println(cproducts.toString());
			return cproducts;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList(); // or throw an exception if required
		}

	}

	public int updateQty(cartModel cm) {
		int r = jdbcTemplate.update(update_qty, cm.getQty(), cm.getCid(), cm.getPid());
		if (r > 0) {
			System.out.println("updated in cart");
			return r;
		} else {
			return -1;
		}
	}

	public int updateinsert(List<ProductStockPrice> products, int cust_id) {
		int r = -1;
		for (ProductStockPrice ps : products) {
			r = jdbcTemplate.update(insert, cust_id, ps.getProd_id(), ps.getQuantity());
		}
		return r;
	}

	/*
	 * public hsnModel getHSNCodeByProductId(int prodId) { String sql = "SELECT hsn_code, sgst, igst, cgst, gst " +
	 * "FROM slam_HSN_Code " + "WHERE hsn_code = ?";
	 * 
	 * return jdbcTemplate.queryForObject(sql, new Object[] { prodId }, (resultSet, rowNum) -> { hsnModel hsnCodeModel =
	 * new hsnModel(); hsnCodeModel.setHsn_code(resultSet.getInt("hsn_code"));
	 * hsnCodeModel.setSgst(resultSet.getDouble("sgst")); hsnCodeModel.setIgst(resultSet.getDouble("igst"));
	 * hsnCodeModel.setCgst(resultSet.getDouble("cgst")); hsnCodeModel.setGst(resultSet.getDouble("gst")); return
	 * hsnCodeModel; }); }
	 */
	public ServiceableRegion getRegionByPincode(int pincode) {
		String query = "SELECT * FROM slam_regions WHERE ? BETWEEN region_pin_from AND region_pin_to";

		// Define the RowMapper to map the query result to the RegionModel object
		RowMapper<ServiceableRegion> rowMapper = (rs, rowNum) -> {
			ServiceableRegion region = new ServiceableRegion();
			region.setSrrgId(rs.getInt("region_id"));
			region.setSrrgPriceSurcharge(rs.getDouble("region_surcharge"));
			region.setSrrgPriceWaiver(rs.getDouble("region_pricewaiver"));
			return region;
		};

		// Execute the query and retrieve the region based on the pincode
		List<ServiceableRegion> regions = jdbcTemplate.query(query, rowMapper, pincode);

		// Check if a region was found and return it, otherwise return null if (regions.isEmpty()) { return null; } else
		{
			return regions.get(0);
		}
	}

}