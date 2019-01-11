package controllers;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;
import utility.LogHandler;

/**
 * Servlet implementation class SignIn
 */
@WebServlet("/SignIn")
public class SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private long modTime;
	private HashMap<String, String> sessionInfo = new HashMap<String, String>();

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
    public SignIn() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		User userSession = null;
		try {
			userSession = (User) session.getAttribute("nameBean");
		}catch(Exception e) {
			System.out.println("Session is not available.");
			e.printStackTrace();
		}
		
		User user = new User();
		String email = request.getParameter("email");
		String password = request.getParameter("psw");
		String saveme = request.getParameter("saveme");
		user.setEmail(email);
		user.setPassword(password);
		
		// Setup the cookie
		if (saveme != null) {
		    	Cookie cookie1 = new Cookie("Username", email);
			    cookie1.setMaxAge(60*60); //set its age to 1 hour
			    response.addCookie(cookie1);
			    
		    	Cookie cookie2 = new Cookie("Password", password);
		    	cookie2.setMaxAge(60*60);     //set its age to 1 hour
			    response.addCookie(cookie2);
		}
		try {
			int status = user.validateUser();
	
			if (status == -1) {	
				System.out.println("Password is wrong!");
				String message = "Your username or password is not correct!";
				request.getSession().setAttribute("dangermessage", message);
				request.getRequestDispatcher("index.jsp").forward(request, response);
				session.removeAttribute("dangermessage");
//				response.sendRedirect("InvalidUserOrPass.jsp");
				session.invalidate();
	
			} else if (status == 0) {
				System.out.println("User not exists!");
				String message = "You are not signed up yet!";
				request.getSession().setAttribute("warningmessage", message);
				//response.sendRedirect("Index.jsp");
				
				request.getRequestDispatcher("index.jsp").forward(request, response);
				session.removeAttribute("warningmessage");
				//response.getWriter().append("Served at: ").append(request.getContextPath());
				//response.getOutputStream().write("alert(You are not sign up yet)");
				//response.sendRedirect("Registration.jsp");
				session.invalidate();
			} else {
	
				String address = new String();
				String stayOnPage = new String();
				Integer accessCount = user.getAccesscount();
	
				if (userSession == null) {
					session.setAttribute("nameBean", user);
					accessCount++;
					user.setAccesscount(accessCount);
					user.updateNumOfVisits();
					user.updateLastVisit();
	
					if (status == 1) {
						System.out.println("User exists in admin");
						address = "adminhome.jsp";
						stayOnPage = "StayOnAdmin.jsp";
	
					} else {
						System.out.println("User exists in user");
						address = "userhome.jsp";
						stayOnPage = "StayOn.jsp";
					}
					sessionInfo.put(session.getId(), stayOnPage);
				} else {
					address = sessionInfo.get(session.getId());
				}
				
				response.sendRedirect(address);
			}
		}catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
			response.sendRedirect("500-error.jsp");
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
