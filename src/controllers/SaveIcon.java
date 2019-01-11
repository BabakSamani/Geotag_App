package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Category;

/**
 * Servlet implementation class SaveIcon
 */
@WebServlet("/SaveIcon")
public class SaveIcon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveIcon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		Category categ = new Category();
		
		/* The following should be changed according to your workspace based on opened application.
		 * For macOS is like: /Users/<user>/path to/Geotag_App/WebContent/fileupload/
		 */
		String path = "/Web_App/Geotag_App/WebContent/fileupload/";
		String fileName = request.getParameter("fileName");
		String cateName = request.getParameter("categName");
		categ.setLink("./fileupload/" + fileName);
		System.out.println(cateName);
		fileName = path + fileName;
		categ.setName(cateName);

		categ.addCategory(fileName);
		response.sendRedirect("allCategories.jsp");
		
//		categ.setId(1);
//		categ.getOneCategory();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
