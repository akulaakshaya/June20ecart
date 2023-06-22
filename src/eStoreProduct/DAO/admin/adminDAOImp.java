package eStoreProduct.DAO.admin;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import eStoreProduct.model.admin.entities.adminModel;

@Component
public class adminDAOImp implements adminDAO {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	@Transactional
	public adminModel getAdmin(String email, String password) {
		try {
			String query = "SELECT a FROM adminModel a WHERE a.email = :email AND a.password = :password";
			return entityManager.createQuery(query, adminModel.class).setParameter("email", email)
					.setParameter("password", password).getSingleResult();
		} catch (Exception e) {
			// Handle the exception appropriately (e.g., logging, throwing custom exception, etc.)
			e.printStackTrace();
			return null; // or throw an exception if required
		}
	}

	@Override
	@Transactional
	public void updateAdmin(adminModel admin) {
		entityManager.merge(admin);
	}
}