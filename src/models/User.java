/* I tried to put comments for each method.
 * For each class, please put comments for each method and 
 * any code that is not understandable.
 */
package models;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.sql.PreparedStatement;

import database.DatabaseConnector;
import utility.LogHandler;
import utility.PasswordUtil;

public class User {
	
	private String password;
	private String firstname;
	private String lastname;
	private String email;
	private String lastlogin;
	private int accesscount;
	private int id;
	private int type;
	
	public User() {
		super();
	}
	
	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the lastlogin
	 */
	public String getLastlogin() {
		return lastlogin;
	}

	/**
	 * @param lastlogin the lastlogin to set
	 */
	public void setLastlogin(String lastlogin) {
		this.lastlogin = lastlogin;
	}

	public int getAccesscount() {
		return accesscount;
	}

	public void setAccesscount(int accesscount) {
		this.accesscount = accesscount;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	
	/**
	 * The following method adds a user record into the database,
	 * Table user.
	 * @param
	 * @return none
	 */
	public void addUser() {

		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		// Insert to the Users table
		String sql;
		sql = "INSERT INTO user (First_Name, Last_Name, Email, Password, Account_Creation, Num_Of_Visits, Last_Login, Type)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, this.getFirstname());
			ps.setString(2, this.getLastname());
			ps.setString(3, this.getEmail());
			String cryptedPass = PasswordUtil.Cryptographer(this.getPassword());
			ps.setString(4, cryptedPass);
			String dateString = dateFormat.format(date);
			ps.setString(5, dateString);
			ps.setInt(6, 1);
			//dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dateString = dateFormat.format(date);
			ps.setString(7, dateString);
			ps.setInt(8, 2);
			
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
	 * validateUser()
	 * 
	 * status = 1 (type) means admin exists; status = 2 (type) means normal user
	 * exists; status = -1 means user password is wrong; status = 0 means user
	 * not exists.
	 * 
	 */
	public int validateUser() {

		int status = 0;

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();

		String sql = "SELECT * FROM user WHERE Email = ?";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, this.getEmail());
			rs = ps.executeQuery();

			System.out.println("Query =>" + ps.toString());

			while (rs.next()) {

				int type = rs.getInt("Type");
				String passwd = rs.getString("Password");

				if (passwd != null) {
					String cryptedPassword = PasswordUtil.Cryptographer(this.getPassword());
					if (passwd.equals(cryptedPassword)) {

						String firstname = rs.getString("First_Name");
						String lastname = rs.getString("Last_name");
						int numofvisits = rs.getInt("Num_Of_Visits");
						int id = rs.getInt("Id");

						setFirstname(firstname);
						setLastname(lastname);
						setAccesscount(numofvisits);
						setId(id);

						if (type == 1) {
							status = type;
						}
						if (type == 2) {
							status = type;
						}
						setType(type);
					} else {
						status = -1;
					}
				} else {
					status = 0;
				}
			}

		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return status;
	}
	
	/**
	 * The following method updates the last date of user login status
	 * in the database.
	 */
	public void updateLastVisit() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String dateString = dateFormat.format(date);
		dateString = dateFormat.format(date);
		
		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		String sql = "UPDATE user SET Last_Login = ? WHERE Id = ? ";
		
		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, dateString);
			ps.setInt(2, this.getId());
			
			ps.executeUpdate();
			
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		
		DatabaseConnector.closeDatabase(ps, conn);
	}
	
	
	// removeUser()
	public void removeUser(int userID) {
		
		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		String sql = "DELETE from user WHERE Id = ? ";
		
		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setInt(1, userID);
			
			ps.executeUpdate();
			
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		
		DatabaseConnector.closeDatabase(ps, conn);
	}
	
	
	// Update user's number of visits
	public void updateNumOfVisits() {

		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();

		String sql = "UPDATE user SET Num_Of_Visits = ? WHERE Id = ? ";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setInt(1, this.getAccesscount());
			ps.setInt(2, this.getId());

			ps.executeUpdate();

		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}

		DatabaseConnector.closeDatabase(ps, conn);
	}
	

	/**
	 * Get the user's ID
	 * @param firstName
	 * @param lastName
	 * @param phoneNumber
	 * @param emailAddress
	 * @return User's ID
	 */
	public Integer GetUserID(String firstName, String lastName, String phoneNumber, String emailAddress) {

		Integer ID = null;

		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;

		conn = DatabaseConnector.connect();

		String sql = "SELECT Id FROM user WHERE First_Name = ? AND Last_Name = ? AND Email = ? ";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, firstName);
			ps.setString(2, lastName);
			ps.setString(3, emailAddress);
			
			System.out.println("Query => "+ps.toString());
			rs = ps.executeQuery();

			if (rs.next()) {
				ID = rs.getInt("Id");
			}

		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return ID;
	}
	
	/**
	 * This method checks whether a user exists in the database 
	 * or not and returns True (if user exists) / False ( if user
	 * does not exist).
	 * @param oldPass
	 * @return True/False
	 */
	public boolean passExists(String oldPass){
		boolean passExist = false;
		
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();

		String sql = "SELECT * FROM user WHERE Password = ? AND Id = ?";
		
		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, oldPass);
			ps.setInt(2, this.getId());
			rs = ps.executeQuery();
			System.out.println("Query =>"+ps.toString());
			if (rs.next()) {
				passExist = true;
			}
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return passExist;
	}
	
	/**
	 * This method will reset a user's password with a new
	 * password that user enters.
	 * @param newPass
	 */
	public void changePassword(String newPass){
		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		String sql = "UPDATE user SET Password = ? WHERE Id = ? ";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1, newPass);
			ps.setInt(2, this.getId());
			ps.executeUpdate();
			System.out.println("Query =>" + ps.toString());
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}

		DatabaseConnector.closeDatabase(ps, conn);
	}
	
	/** 
	 * This method basically retrieves all users 
	 * from the database with all their info and returns 
	 * a list of users to display in the JSP page.
	 * @return ArrayList users
	 */
	public ArrayList<User> getAllUsers(){
		ArrayList<User> users = new ArrayList<User>();
		Connection conn = null;
		conn = DatabaseConnector.connect();
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		String query = null;
		query = "SELECT * FROM user ";
		try {
			ps = conn.prepareStatement(query);
			System.out.println("Query =>" + ps.toString());
			rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				
				int id = rs.getInt("id");
				String firstname = rs.getString("First_Name");
				String lastname = rs.getString("Last_Name");
				String email = rs.getString("Email");
				int NumOfVisit = rs.getInt("Num_Of_Visits");
				String lastLogin = rs.getString("Last_Login");
				int type = rs.getInt("Type");
				
				user.setId(id);
				user.setFirstname(firstname);
				user.setLastname(lastname);
				user.setEmail(email);
				user.setAccesscount(NumOfVisit);
				user.setLastlogin(lastLogin);
				user.setType(type);
				
				users.add(user);
			}
		
		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
	
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return users;
	}
	
	/**
	 * By this method administrator can search for 
	 * a user based on his/her name, last name and email
	 * address. This method will be called from a controller
	 * which calls this method and returns the result to a JSP
	 * page.
	 */
	// SearchUser()
	
}
