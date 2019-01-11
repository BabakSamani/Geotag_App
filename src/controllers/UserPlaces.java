package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Location;
import models.User;

/**
 * Servlet implementation class UserPlaces
 */
@WebServlet("/UserPlaces")
public class UserPlaces extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPlaces() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("nameBean");
		int UID = user.getId();
		Location loc = new Location();
		
		String BBox = request.getParameter("BoundingBox");
		String[] BoundingBox = BBox.split(",");
		ArrayList<String[]> userplaces = loc.getUserPlaces(UID, BoundingBox);
		session.setAttribute("userplaces", userplaces);
		// Check the output of the "getUserPlaces" method
		System.out.println(userplaces);
		response.sendRedirect("userhome.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
