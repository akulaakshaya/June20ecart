package eStoreProduct.DAO.customer;

import java.util.List;

import eStoreProduct.utility.ProductStockPrice;

public interface WishlistDAO {

	public int addToWishlist(int productId, int customerId);

	public int removeFromWishlist(int productId, int customerId);

	public List<ProductStockPrice> getWishlistProds(int cust_id);

}