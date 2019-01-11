package controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

/**
 * Servlet implementation class AddIcon
 */
@WebServlet(name = "FileUploadServlet", urlPatterns = {"/upload"})
@MultipartConfig
//@WebServlet("/FileUploadServer")
public class FileUploadServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOGGER = Logger.getLogger(FileUploadServer.class.getCanonicalName());
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadServer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//		response.setContentType("text/html;charset=UTF-8");

	    // Create path components to save the file
		/* The following should be changed according to your workspace based on opened application.
		 * For macOS is like: /Users/<user>/path to/Geotag_App/WebContent/fileupload/
		 * May be we can use getRealPath method, like following
		 * String absolutePathToIndexJSP = servletContext.getRealPath("/") + "index.jsp";
		 */
		final String path = "/Web_App/Geotag_App/WebContent/fileupload";
		final Part filePart = request.getPart("fileName");
	    final String fileName = getFileName(filePart);
	    System.out.println(fileName);
	    
	    // =========== In this section we need to implement piece of code to check the file size =============
	    double fileSize = filePart.getSize()/ 1024; // File size in kilobytes
	    if(fileSize > 50) {
	    		System.out.println("The file is too large!");
	    }
	    // ================================= End of the test file size part ==================================
	    
	    OutputStream out = null;
	    InputStream filecontent = null;

	    try {
	    		File outputFile = new File(path + File.separator + fileName);
	        out = new FileOutputStream(outputFile);
	        filecontent = filePart.getInputStream();

	        int read = 0;
	        final byte[] bytes = new byte[1024];

	        while ((read = filecontent.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        System.out.println("New file " + fileName + " created at " + path);
	        
	        //LOGGER.log(Level.INFO, "File{0}being uploaded to {1}", new Object[]{fileName, path});
	    } catch (FileNotFoundException fne) {
	        System.out.println("You either did not specify a file to upload or are "
	                + "trying to upload a file to a protected or nonexistent "
	                + "location.");

	        //LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}", new Object[]{fne.getMessage()});
	    } finally {
	        if (out != null) {
	            out.close();
	        }
	        if (filecontent != null) {
	            filecontent.close();
	        }
	        
//	        String iconPath = "./fileupload/" + fileName;
//			request.getSession().setAttribute("iconName", iconPath);
			request.getSession().setAttribute("iconName", fileName);
			
	        Timer timer = new Timer(true);
	        System.out.println("TimerTask started");
	        //cancel after sometime
	        try {
	            Thread.sleep(10000);
	        } catch (InterruptedException e) {
	            e.printStackTrace();
	        }
	        timer.cancel();
	        System.out.println("TimerTask finished");
	        
	        response.sendRedirect("addCategory.jsp");
			//request.getRequestDispatcher("adminhome.jsp").forward(request, response);
	    }
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private String getFileName(final Part part) {
	    final String partHeader = part.getHeader("content-disposition");
	    //LOGGER.log(Level.INFO, "Part Header = {0} " , partHeader);
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
		        	String fileName = content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
		        	return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
	        }
	    }
	    return null;
	}
	
}



