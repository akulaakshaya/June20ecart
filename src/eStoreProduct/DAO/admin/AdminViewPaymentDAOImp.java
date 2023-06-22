package eStoreProduct.DAO.admin;



import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import eStoreProduct.model.admin.output.AdminViewPayments;
import eStoreProduct.model.admin.entities.orderModel;

@Component
public class AdminViewPaymentDAOImp implements AdminViewPaymentDAO{

	@PersistenceContext
	private EntityManager entityManager;

	
	@Override
	@Transactional
	public List<AdminViewPayments> getPayments() {
		
	        TypedQuery<AdminViewPayments> query = entityManager.createQuery("SELECT new eStoreProduct.model.admin.output.AdminViewPayments(om.id,om.billNumber,om.orderDate,om.total, om.paymentReference)"
	        		+" FROM orderModel om", AdminViewPayments.class);
	        return query.getResultList();
	    }
		
	@Override
	@Transactional	
	public List<AdminViewPayments> getDatePayments(Timestamp date1, Timestamp date2) {
    TypedQuery<AdminViewPayments> query = entityManager.createQuery("SELECT avp FROM AdminViewPayments avp WHERE avp.paydate BETWEEN :date1 AND :date2", AdminViewPayments.class);
    query.setParameter("date1", date1);
    query.setParameter("date2", date2);
    return query.getResultList();
	}
	
	@Override
	@Transactional
	public List<AdminViewPayments> getFilterPayments(double p1, double p2) {
    TypedQuery<AdminViewPayments> query = entityManager.createQuery("SELECT avp FROM AdminViewPayments avp WHERE avp.ordertotal BETWEEN :p1 AND :p2", AdminViewPayments.class);
    query.setParameter("p1", p1);
    query.setParameter("p2", p2);
    return query.getResultList();
	}

	
	@Override
	@Transactional
	public List<AdminViewPayments> getMaxPrice(double p1) {
		    TypedQuery<AdminViewPayments> query = entityManager.createQuery("SELECT avp FROM AdminViewPayments avp WHERE avp.ordertotal > :p1", AdminViewPayments.class);
		    query.setParameter("p1", p1);
		    return query.getResultList();
		}
}