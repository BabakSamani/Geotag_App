/* I tried to put comments for each method.
 * For each class, please put comments for each method and 
 * any code that is not understandable.
 */
package models;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.sql.PreparedStatement;

import database.DatabaseConnector;
import utility.LogHandler;

public class Category {
	private int id;
	private String name;
	private String link;
	
	public Category() {
		super();
	}
	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the link
	 */
	public String getLink() {
		return link;
	}

	/**
	 * @param link the link to set
	 */
	public void setLink(String link) {
		this.link = link;
	}

	
	/**
	 * This method adds a new category with given name 
	 * and image into the database.
	 * @param fileName
	 */
	public void addCategory(String fileName) {
		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		File imgfile = new File(fileName);
		FileInputStream fin = null;
		try {
			fin = new FileInputStream(imgfile);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// Insert into the category table
		String sql;
		sql = "INSERT INTO category (Name, icon, NumOfUse, Link) VALUES (?, ?, ?, ?)";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, this.getName());
			ps.setBinaryStream(2,(InputStream)fin,(int)imgfile.length());
			ps.setInt(3, 0);
			ps.setString(4, this.getLink());
			ps.executeUpdate();

			System.out.println("Query =>" + ps.toString());
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
			throw new RuntimeException(se);
		}
		DatabaseConnector.closeDatabase(ps, conn);
	}
	
	
	/** 
	 * This method get a specific category form the
	 * database based on its ID and then returns the 
	 * name and icon of the category. 
	 * @throws IOException 
	 */
	public void getOneCategory() throws IOException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		// Retrieve an icon from category table
		String sql;
		sql = "SELECT * FROM category WHERE id=?";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setInt(1, this.getId());
			
			System.out.println("Query => "+ps.toString());
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
//				int id = rs.getInt("id");
				String iconName = rs.getString("name");
				System.out.println(iconName);
				InputStream in = rs.getBinaryStream("icon");
				OutputStream f = new FileOutputStream(new File("test"+ i +".png"));
				i++;
				int c = 0;
				while ((c = in.read()) > -1) {
					f.write(c);
				}
				f.close();
				in.close();
			}
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
			throw new RuntimeException(se);
		}
		DatabaseConnector.closeDatabase(ps, conn);
	}
	
	/** 
	 * This method retrieves all categories, 
	 * their names and icons, from the database.
	 */
	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> categories = new ArrayList<Category>();
		Connection conn = null;
		conn = DatabaseConnector.connect();
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		String query = null;
		query = "SELECT * FROM category";
		
		try {
			ps = conn.prepareStatement(query);
			System.out.println("Query =>" + ps.toString());
			rs = ps.executeQuery();
			while (rs.next()) {
				Category category = new Category();
				
				int id = rs.getInt("id");
				String name = rs.getString("Name");
				String link = rs.getString("Link");
				category.setId(id);
				category.setName(name);
				category.setLink(link);
				categories.add(category);
			}
		
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
	
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return categories;
	}
	
	
	public int getCategoryID(String catName) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		String sql;
		sql = "SELECT ID FROM category WHERE name LIKE ?";
		
		int id = 0;
		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, "%" + catName + "%");
			
			System.out.println("Query => " + ps.toString());
			rs = ps.executeQuery();
			
			while (rs.next()) {
				id = rs.getInt("id");
			}
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
			throw new RuntimeException(se);
		}
		DatabaseConnector.closeDatabase(ps, conn);
		
		return id;
	}
	
	// TODO add following methods:
	/**
	 * This method gets name of all categories from
	 * database and returns an array of strings.
	 */
	public void getAllCategoryNames() {
		
	}
	
	
	/** 
	 * This method deletes a record from category table
	 * on the database based on its ID number. 
	 */
	public void removeCategory(int id) {
		
	}
}
