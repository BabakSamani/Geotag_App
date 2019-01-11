package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.MLPQ;

/**
 * Servlet implementation class MLPQgenerator
 */
@WebServlet("/MLPQgenerator")
public class MLPQgenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MLPQgenerator() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String coordinates = request.getParameter("coordinates");
		System.out.println(coordinates);
		
		String[] coords = coordinates.split(": ");
		ArrayList<String> coor = new ArrayList<String>();
		
		for(int i = 0; i < coords.length; i++) {
			coor.add(coords[i]);
		}
		
		MLPQ.Coordinate2MLPQ(coor);
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("userhome.jsp");
		reqDispatcher.forward(request,response);
//		response.sendRedirect("userhome.jsp");
//		request.getRequestDispatcher("userhome.jsp").forward(request, response);
//		response.getWriter().append("The mlpq is generated");
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
