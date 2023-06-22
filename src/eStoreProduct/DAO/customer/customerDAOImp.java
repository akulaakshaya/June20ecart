package eStoreProduct.DAO.customer;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import eStoreProduct.model.customer.entities.custCredModel;
import eStoreProduct.model.customer.input.customerInputModel;
import eStoreProduct.model.customer.output.customerOutputModel;

@Component
public class customerDAOImp implements customerDAO {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	@Transactional
	public void persist(custCredModel ccm) {
		entityManager.persist(ccm);
	}

	@Override
	@Transactional
	public boolean createCustomer(customerInputModel cim) {
		try {
			custCredModel ccm = new custCredModel(cim);
			// Get the highest cust_id from slam_customers
			String maxIdQuery = "SELECT MAX(c.custId) FROM custCredModel c";
			Integer maxId = entityManager.createQuery(maxIdQuery, Integer.class).getSingleResult();

			// Increment the cust_id for the new customer
			int newCustId = (maxId != null) ? maxId + 1 : 1;
			ccm.setCustId(newCustId);

			// Persist the new customer
			entityManager.persist(ccm);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	@Transactional
	public void updatecustomer(customerInputModel customer) {
		custCredModel ccm = new custCredModel(customer);
		entityManager.merge(ccm);
	}

	@Override
	@Transactional
	public customerOutputModel getCustomerById(int id) {
		return entityManager.find(customerOutputModel.class, id);
	}

	@Override
	@Transactional
	public void updatelastlogin(int cid) {
		String updateQuery = "UPDATE custCredModel SET custLastLoginDate = CURRENT_TIMESTAMP WHERE custId = :cid";
		entityManager.createQuery(updateQuery).setParameter("cid", cid).executeUpdate();
	}

	@Override
	@Transactional
	public customerOutputModel getCustomer(String custEmail, String custPassword) {
		try {
			String query = "SELECT NEW eStoreProduct.model.customer.output.customerOutputModel(c.custId, c.custEmail, c.custPassword) FROM custCredModel c WHERE c.custEmail = :custEmail AND c.custPassword = :custPassword";
			TypedQuery<customerOutputModel> typedQuery = entityManager.createQuery(query, customerOutputModel.class);
			typedQuery.setParameter("custEmail", custEmail);
			typedQuery.setParameter("custPassword", custPassword);
			List<customerOutputModel> results = typedQuery.getResultList();
			if (results.isEmpty()) {
				return null;
			}
			return results.get(0);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	@Transactional
	public void updatePassword(String password, String email) {
		try {
			String query = "UPDATE custCredModel SET custPassword = :password WHERE custEmail = :email";
			entityManager.createQuery(query).setParameter("password", password).setParameter("email", email)
					.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	@Transactional
	public customerOutputModel getCustomerByEmail(String email) {
		try {
			String query = "SELECT c FROM custCredModel c WHERE c.custEmail = :email";
			return entityManager.createQuery(query, customerOutputModel.class).setParameter("email", email)
					.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}