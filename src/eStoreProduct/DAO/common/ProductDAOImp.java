package eStoreProduct.DAO.common;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.sql.DataSource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.DAO.admin.ProdStockDAO;
import eStoreProduct.model.admin.entities.productsModel;
import eStoreProduct.model.admin.input.Category;
import eStoreProduct.model.admin.input.Product;
import eStoreProduct.utility.ProductStockPrice;

@Component
public class ProductDAOImp implements ProductDAO {

	@PersistenceContext
	private EntityManager entityManager;

	private final JdbcTemplate jdbcTemplate;

	private String get_products_by_catg = "select p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id and p.prod_prct_id = ?";
	private String products_query = "SELECT p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id";
	private String prdt_catg = "SELECT * FROM slam_ProductCategories";
	private String get_prd = "SELECT * FROM slam_Products WHERE prod_id = ?";
	private ProdStockDAO prodStockDAO;

	@Autowired
	public ProductDAOImp(DataSource dataSource, ProdStockDAO prodStockDAO) {
		jdbcTemplate = new JdbcTemplate(dataSource);
		this.prodStockDAO = prodStockDAO;
	}

	@Override
	@Transactional
	public Integer getMaxProductId() {
		String query = "SELECT MAX(p.id) FROM productsModel p";
		TypedQuery<Integer> maxIdQuery = entityManager.createQuery(query, Integer.class);
		Integer maxId = maxIdQuery.getSingleResult();
		return maxId != null ? maxId : 0;
	}

	@Override
	@Transactional
	public boolean createProduct(Product p) {
		int p_id = getMaxProductId();

		p_id = p_id + 1;
		System.out.println(p_id + "product_id\n");
		System.out.println(p.getProd_title() + " " + p.getProd_gstc_id() + " " + p.getProd_brand() + " "
				+ p.getImage_url() + " " + p.getProd_desc() + " " + p.getReorderLevel());

		productsModel productEntity = new productsModel();
		productEntity.setId(p_id);
		productEntity.setTitle(p.getProd_title());
		productEntity.setProductCategory(p.getProd_prct_id());
		productEntity.setHsnCode(p.getProd_gstc_id());
		productEntity.setBrand(p.getProd_brand());

		productEntity.setImageUrl(p.getImage_url());
		productEntity.setDescription(p.getProd_desc());
		productEntity.setReorderLevel(p.getReorderLevel());
		entityManager.merge(productEntity);

		return productEntity.getId() != null;

	}

	public List<ProductStockPrice> getProductsByCategory(Integer category_id) {

		System.out.println("in pdaoimp cid   " + category_id);
		List<ProductStockPrice> p = jdbcTemplate.query(get_products_by_catg, new ProductRowMapper(prodStockDAO),
				category_id);
		for (ProductStockPrice ps : p) {
			System.out.println("for loop      " + ps);
		}
		return p;
	}

	public List<ProductStockPrice> getAllProducts() {
		return jdbcTemplate.query(products_query, new ProductRowMapper(prodStockDAO));
	}

	public List<Category> getAllCategories() {
		return jdbcTemplate.query(prdt_catg, new CategoryRowMapper());
	}

	public ProductStockPrice getProductById(Integer productId) {
		List<ProductStockPrice> products = jdbcTemplate.query(get_prd, new ProductRowMapper(prodStockDAO), productId);
		return products.isEmpty() ? null : products.get(0);
	}

	@Override
	public List<String> getAllProductCategories() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductStockPrice> sortProductsByPrice(List<ProductStockPrice> productList, String sortOrder) {
		// System.out.println("pdaoimp class sortbyprice method");
		List<ProductStockPrice> sortedList = jdbcTemplate.query(products_query, new ProductRowMapper(prodStockDAO));

		if (sortOrder.equals("lowToHigh")) {
			Collections.sort(sortedList);
		} else if (sortOrder.equals("highToLow")) {
			Collections.sort(sortedList, Collections.reverseOrder());
		}

		return sortedList;
	}

	@Override
	public List<ProductStockPrice> filterProductsByPriceRange(double minPrice, double maxPrice) {
		List<ProductStockPrice> filteredProducts = jdbcTemplate.query(products_query,
				new ProductRowMapper(prodStockDAO));
		List<ProductStockPrice> res = new ArrayList<>();
		int flag = 0;
		for (ProductStockPrice product : filteredProducts) {
			if (product.getPrice() >= minPrice && product.getPrice() <= maxPrice) {
				res.add(product);
				flag = 1;
			}
		}
		if (flag == 0)
			return filteredProducts;
		else
			return res;
	}

	public boolean isPincodeValid(int pincode) {
		String query = "SELECT COUNT(*) FROM slam_regions WHERE ? BETWEEN region_pin_from AND region_pin_to";
		int count = jdbcTemplate.queryForObject(query, Integer.class, pincode);
		return count > 0;
	}

}
