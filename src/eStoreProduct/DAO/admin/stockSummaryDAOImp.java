package eStoreProduct.DAO.admin;

import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.sql.DataSource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.model.admin.entities.HSNCodeModel;
import eStoreProduct.model.admin.entities.productStockModel;
import eStoreProduct.model.admin.entities.productsModel;
import eStoreProduct.model.admin.output.stockSummaryModel;

@Component
public class stockSummaryDAOImp implements stockSummaryDAO {

	@PersistenceContext
	private EntityManager entityManager;

	

	@Override
	@Transactional
	public List<stockSummaryModel> getStocks() {
		String query = "SELECT NEW eStoreProduct.model.admin.output.stockSummaryModel("
				+ "p.id, p.title, p.productCategory, p.hsnCode, p.brand, p.imageUrl, p.description, p.reorderLevel, pc.prct_title, "
				+ "hsn.sgst, hsn.igst, hsn.cgst, hsn.gst, ps.price, ps.stock, ps.mrp) "
				+ "FROM eStoreProduct.model.admin.entities.productsModel p, eStoreProduct.model.admin.entities.productCategoryModel pc, eStoreProduct.model.admin.entities.HSNCodeModel hsn, eStoreProduct.model.admin.entities.productStockModel ps "
				+ "WHERE p.id = ps.product AND p.hsnCode = hsn.hsnCode AND pc.id = p.productCategory";

		try {
			List<stockSummaryModel> l = entityManager.createQuery(query, stockSummaryModel.class).getResultList();
			for (stockSummaryModel lis : l)
				System.out.println("Inside" + lis);
			return l;
		} catch (Exception e) {
			// Handle the exception appropriately (e.g., logging, throwing custom exception, etc.)
			e.printStackTrace();
			return Collections.emptyList(); // or throw an exception if required
		}
	}

	@Override
	@Transactional
	public void updateStocks(int prodid, String imageurl, int gstcid, int reorderlevel, int stock, double mrp) {
		System.out.println("In the method: " + prodid + "gst" + gstcid);

		try {
			productsModel product = entityManager.find(productsModel.class, prodid);
			HSNCodeModel hsn = entityManager.find(HSNCodeModel.class, gstcid);
			System.out.println(gstcid + "\n dsaf");
			// productCategoryModel pc=entityManager.find(productCategoryModel.class, gstcid);

			double gstPercent = hsn.getGst();
			double updated_mrp = ((mrp * gstPercent * 0.01) + mrp);
			productStockModel psm = entityManager.find(productStockModel.class, prodid);

			if (product != null) {
				product.setReorderLevel(reorderlevel);
				product.setImageUrl(imageurl);
				product.setHsnCode(gstcid);
				entityManager.merge(product);
				System.out.println("Product updated successfully.");

			} else {
				System.out.println("Product not found.");
			}
			if (psm != null) {
				psm.setStock(stock);
				psm.setMrp(mrp);
				psm.setPrice(updated_mrp);
				entityManager.merge(psm);
				System.out.println("stock updated successfully.");

			} else {
				System.out.println("Stock not found.");
			}
		} catch (Exception e) {
			System.out.println("Error updating the product: " + e.getMessage());
			e.printStackTrace();
		}

	}

}