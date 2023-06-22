package eStoreProduct.DAO.common;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import eStoreProduct.model.admin.input.Category;

public class CategoryRowMapper implements RowMapper<Category> {

	@Override
	public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
		int prct_id = rs.getInt("prct_id");
		String prct_title = rs.getString("prct_title");
		String prct_desc = rs.getString("prct_desc");

		return new Category(prct_id, prct_title, prct_desc);
	}
}