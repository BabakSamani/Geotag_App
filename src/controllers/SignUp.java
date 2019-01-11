package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private long modTime;

	/**
	 * The init method is called only when the servlet is first loaded, before
	 * the first request is processed.
	 */
	public void init() throws ServletException {
		// Round to nearest second (i.e., 1000 milliseconds)
		modTime = System.currentTimeMillis() / 1000 * 1000;
	}
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		User user = new User();

		String firstname = request.getParameter("firstName");
		String lastname = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("psw");
		
		// System.out.println(firstname + ", " + lastname + ", " + email + ", " + password);
		
		user.setPassword(password);
		user.setFirstname(firstname);
		user.setLastname(lastname);
		user.setEmail(email);
		user.setId(0);

		if (user.validateUser() == 1 || user.validateUser() == 2) {

			request.setAttribute("userExist", user);
			String address = "UserExist.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
			System.out.println("User exists either in customers or clients");

		} else {

			user.addUser();
			HttpSession session = request.getSession();
			session.setAttribute("userBean", user);
			user.setFirstname(user.getFirstname());
			user.setLastname(user.getLastname());

			response.sendRedirect("index.jsp");

		}
	}
	
	/**
	 * The standard service method compares this date against any date specified
	 * in the If-Modified-Since request header. If the getLastModified date is
	 * later or if there is no If-Modified-Since header, the doGet method is
	 * called normally. But if the getLastModified date is the same or earlier,
	 * the service method sends back a 304 (Not Modified) response and does
	 * <B>not</B> call doGet. The browser should use its cached version of the
	 * page in such a case.
	 */

	public long getLastModified(HttpServletRequest request) {
		return (modTime);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
