package eStoreProduct.DAO.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.sql.DataSource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.model.admin.entities.productCategoryModel;
import eStoreProduct.model.admin.input.Category;
import eStoreProduct.model.admin.input.Product;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;


@Component
public class CategoryDAOImp implements CategoryDAO {
	

	@PersistenceContext
	private EntityManager entityManager;
	
	@PersistenceUnit
    private EntityManagerFactory entityManagerFactory;

	@Transactional
	public Integer getMaxCategoryId() {
	    String query = "SELECT MAX(c.id) FROM productCategoryModel c";
	    TypedQuery<Integer> maxIdQuery = entityManager.createQuery(query, Integer.class);
	    Integer maxId = maxIdQuery.getSingleResult();
	    return maxId != null ? maxId : 0;
	}




	
	@Override
	@Transactional
	public boolean addNewCategory(Category catg) {
		int c_id = getMaxCategoryId();
		c_id = c_id + 1;
		System.out.println(c_id + "Category_id\n");
		
		productCategoryModel categoryEntity = new productCategoryModel();
		categoryEntity.setId(c_id);
		categoryEntity.setPrct_title(catg.getPrct_title());
		categoryEntity.setDescription(catg.getPrct_desc());
	    entityManager.merge(categoryEntity);

	    return categoryEntity.getId() != null;
		
	}

	public List<String> getAllCategories() {
List<String> categories = new ArrayList<>();
        
        try {
            // Create a new EntityManager from the factory
            EntityManager entityManager = entityManagerFactory.createEntityManager();
            
            // Prepare the JPA query
            String query = "SELECT c.prct_title FROM productCategoryModel c";
            TypedQuery<String> typedQuery = entityManager.createQuery(query, String.class);
            
            // Execute the query
            List<String> results = typedQuery.getResultList();
            
            // Add the results to the categories list
            categories.addAll(results);
            
            // Close the EntityManager
            entityManager.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return categories;
    }

}