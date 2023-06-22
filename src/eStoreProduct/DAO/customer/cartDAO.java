package eStoreProduct.DAO.customer;

import java.util.List;

import eStoreProduct.model.customer.entities.cartModel;
import eStoreProduct.utility.ProductStockPrice;

public interface cartDAO {
	public String addToCart(int productId, int customerId);

	public int removeFromCart(int productId, int customerId);

	public List<ProductStockPrice> getCartProds(int cust_id);

	public int updateQty(cartModel cm);

	public int updateinsert(List<ProductStockPrice> products, int cust_id);

	/*
	 * public hsnModel getHSNCodeByProductId(int prod_gstc_id);
	 * 
	 * public ServiceableRegion getRegionByPincode(int i);
	 */
}