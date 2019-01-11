package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.PropertyConfigurator;

import models.User;

/**
 * Servlet implementation class DisplayUsers
 */
@WebServlet("/DisplayUsers")
public class DisplayUsers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayUsers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Setup the log file functionality
		ServletContext sc = this.getServletContext();
		String propFilePath = sc.getRealPath("/WEB-INF/lib/log4j.properties");
		PropertyConfigurator.configure(propFilePath);
		
		User user = new User();
		ArrayList<User> UserList = user.getAllUsers();
		request.getSession().setAttribute("userList", UserList);
		System.out.println("DisplayUsers is being called");
		response.sendRedirect("allUsers.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
