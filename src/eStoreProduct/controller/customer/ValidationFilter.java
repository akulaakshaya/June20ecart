/*
 * package eStoreProduct.controller;
 * 
 * import java.io.IOException; import eStoreProduct.model.custCredModel; import
 * eStoreProduct.DAO.*; import javax.servlet.Filter; import
 * javax.servlet.FilterChain; import javax.servlet.FilterConfig; import
 * javax.servlet.ServletException; import javax.servlet.http.HttpServletRequest;
 * import javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession; import javax.servlet.ServletRequest; import
 * javax.servlet.ServletResponse; import javax.servlet.annotation.WebFilter;
 * 
 * import org.springframework.jdbc.datasource.DriverManagerDataSource;
 * 
 * import eStoreProduct.utility.ValidationUtility;
 * 
 * @WebFilter(filterName = "validationFilter", urlPatterns = { "/signOk/*" })
 * public class ValidationFilter implements Filter { private ValidationUtility
 * validationUtility;
 * 
 * @Override public void init(FilterConfig filterConfig) throws ServletException
 * {
 * 
 * System.out.println("filter entered"); // Create a DataSource object and set
 * the database connection details DriverManagerDataSource dataSource = new
 * DriverManagerDataSource();
 * dataSource.setDriverClassName("org.postgresql.Driver");
 * dataSource.setUrl("jdbc:postgresql://192.168.110.48:5432/plf_training");
 * dataSource.setUsername("plf_training_admin");
 * dataSource.setPassword("pff123");
 * 
 * // Create an instance of customerDAOImp and pass the DataSource to its
 * constructor customerDAO custDAO = new customerDAOImp(dataSource);
 * 
 * // Initialize your ValidationUtility with the customerDAOImp instance
 * validationUtility = new ValidationUtility(custDAO); }
 * 
 * @Override public void doFilter(ServletRequest request, ServletResponse
 * response, FilterChain chain) throws IOException, ServletException {
 * 
 * HttpServletRequest httpRequest = (HttpServletRequest) request;
 * HttpServletResponse httpResponse = (HttpServletResponse) response; String
 * email = httpRequest.getParameter("em"); String psd =
 * httpRequest.getParameter("ps");
 * 
 * // Perform the validation using the ValidationUtility custCredModel customer
 * = validationUtility.validateCustomer(email, psd);
 * 
 * if (customer != null) { // Proceed to the next filter or controller
 * HttpSession session = httpRequest.getSession();
 * session.setAttribute("loginStatus", true); session.setAttribute("customer",
 * customer); chain.doFilter(request, response); } else { HttpSession session =
 * httpRequest.getSession(); session.setAttribute("loginStatus", false);
 * httpResponse.sendRedirect(httpRequest.getContextPath() + "/signIn"); } }
 * 
 * @Override public void destroy() { // Clean up any resources if needed } }
 */