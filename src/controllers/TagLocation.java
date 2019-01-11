package controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Category;
import models.Location;
import models.User;

/**
 * Servlet implementation class TagLocation
 */
@WebServlet("/TagLocation")
public class TagLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TagLocation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		Location loc = new Location();
		
		String latitude = request.getParameter("inputLat");
		String longitude = request.getParameter("inputLon");
		String elevation = request.getParameter("inputAlt");
		String locationName = request.getParameter("locName");
		String category = request.getParameter("category");
		Category cat = new Category();
		int cid = cat.getCategoryID(category);
		int rating = Integer.parseInt(request.getParameter("inputRating"));
		
		String address = loc.getLocationAddress(latitude, longitude);
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String tagDate = dateFormat.format(date);
		//dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		tagDate = dateFormat.format(date);
		
		System.out.println(cid);
		User user = (User) request.getSession().getAttribute("nameBean");
		int uid = user.getId();
		
		System.out.println(user.getId());
		
		// Set all the parameters to new location object
		loc.setLat(latitude);
		loc.setLng(longitude);
		loc.setAlt(elevation);
		loc.setName(locationName);
		loc.setRating(rating);
		loc.setCid(cid);
		loc.setUid(uid);
		loc.setTagdate(tagDate);
		loc.setAddress(address);
		loc.addLocation();
		
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
