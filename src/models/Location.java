/* I tried to put comments for each method.
 * For each class, please put comments for each method and 
 * any code that is not understandable.
 */
package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;

import database.DatabaseConnector;
import utility.JSONParser;
import utility.LogHandler;


public class Location {
	
	private int id;
	private String name;
	private String lat;
	private String lng;
	private String alt;
	private String address;
	private int uid; 
	private int cid;
	private int rating;
	private String tagdate;
	
	/**
	 * class constructor
	 */
	public Location() {
		super();
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
	 * @return the lat
	 */
	public String getLat() {
		return lat;
	}

	/**
	 * @param lat the lat to set
	 */
	public void setLat(String lat) {
		this.lat = lat;
	}

	/**
	 * @return the lng
	 */
	public String getLng() {
		return lng;
	}

	/**
	 * @param lng the lng to set
	 */
	public void setLng(String lng) {
		this.lng = lng;
	}

	/**
	 * @return the alt
	 */
	public String getAlt() {
		return alt;
	}

	/**
	 * @param alt the alt to set
	 */
	public void setAlt(String alt) {
		this.alt = alt;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the uid
	 */
	public int getUid() {
		return uid;
	}

	/**
	 * @param uid the uid to set
	 */
	public void setUid(int uid) {
		this.uid = uid;
	}

	/**
	 * @return the cid
	 */
	public int getCid() {
		return cid;
	}

	/**
	 * @param cid the cid to set
	 */
	public void setCid(int cid) {
		this.cid = cid;
	}

	/**
	 * @return the rating
	 */
	public int getRating() {
		return rating;
	}

	/**
	 * @param rating the rating to set
	 */
	public void setRating(int rating) {
		this.rating = rating;
	}

	/**
	 * @return the tagdate
	 */
	public String getTagdate() {
		return tagdate;
	}

	/**
	 * @param tagdate the tagdate to set
	 */
	public void setTagdate(String tagdate) {
		this.tagdate = tagdate;
	}
	
	
	/**
	 * This method gets all locations where the user id is ...
	 * @param UID
	 * @param BoundingBox
	 * @return Array list of string arrays of locations
	 */
	public ArrayList<String[]> getUserPlaces(int UID, String[] BoundingBox){
		ArrayList<String[]> userPlaces = new ArrayList<String[]>(); 
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		// Get latitude and longitude of corners of bounding box
		double lat_NE = Double.parseDouble(BoundingBox[0]);
		double lng_NE = Double.parseDouble(BoundingBox[1]);
		
		double lat_SW = Double.parseDouble(BoundingBox[2]);
		double lng_SW = Double.parseDouble(BoundingBox[3]);
		
		String sql;
		sql = "SELECT	L.Name, L.Lat, L.Lng, L.Alt, C.name, C.Link " + 
			  "FROM 		raw_location AS L, user AS U, category AS C " + 
			  "WHERE 	U.ID = ? AND U.ID = L.UID AND C.ID = L.CID AND " + 
			  		   "L.Lat >= ? AND L.Lat <= ? " + 
			  		   "AND L.Lng <= ? AND L.Lng >= ?";
		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setInt(1, UID);
			ps.setDouble(2, lat_SW);
			ps.setDouble(3, lat_NE);
			ps.setDouble(4, lng_NE);
			ps.setDouble(5, lng_SW);
			
			System.out.println("Query =>" + ps.toString());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				String[] l = new String[6];
				l[0] = rs.getString("Name");		// Location name
				l[1] = rs.getString("Lat");
				l[2] = rs.getString("Lng");
				l[3] = rs.getString("Alt");
				l[4] = rs.getString("name");		// Category Name
				l[5] = rs.getString("Link");		// Path of icon file
				
				userPlaces.add(l);
			}

		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return userPlaces;
	}
	
	/**
	 * This method adds a new location record into the database.
	 * @return none
	 */
	public void addLocation() {
		Connection conn = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		// Insert to the Users table
		String sql;
		sql = "INSERT INTO raw_location (Name, Lat, Lng, Alt, Address, UID, CID, Rating, Tag_Date)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			
			ps.setString(1, this.getName());
			ps.setString(2, this.getLat());
			ps.setString(3, this.getLng());
			ps.setString(4, this.getAlt());
			ps.setString(5, this.getAddress());
			ps.setInt(6, this.getUid());
			ps.setInt(7, this.getCid());
			ps.setInt(8, this.getRating());
			
			String dateString = dateFormat.format(date);
			ps.setString(9, dateString);
			
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
	 * This method takes latitude and longitude of a location and find
	 * the corresponding address for this coordinates.
	 * @param lat
	 * @param lng
	 * @return a String containing the address of a location
	 */
	public String getLocationAddress(String lat, String lng) {
		/* geolocator url: http://freegeoip.net/json/ */
		String ad = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+ lat + ","+ lng + "&sensor=true";
		String address = null;
		String json = null;
		JSONObject jsonObject = null;
	    // Convert to a JSON object to print data
	    JSONParser jp = new JSONParser(); 
	    
		try {
			json = jp.readUrl(ad);
			jsonObject = new JSONObject(json);
			JSONArray JsonArray = jsonObject.getJSONArray("results");
			JSONObject jsonObj = JsonArray.getJSONObject(0);
			address = jsonObj.getString("formatted_address");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return address;
	}
	
	
	//TODO add following methods:
	/**
	 * The following method removes a location record from
	 * the database acted by an administration user.
	 * @param: location id
	 * @return: void
	 */
	// removeLocation()
	
	
	
	/**
	 * This method retrieves all the locations from the database
	 * based on the users view window. (Take a look at same 
	 * implemented method)
	 * @param: String BoundingBox
	 * @return: Array list of string arrays of locations
	 */
	// getAllTags(BoundingBox)
	public ArrayList<String[]> getAllPlaces(String[] BoundingBox){
		ArrayList<String[]> userPlaces = new ArrayList<String[]>(); 
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		conn = DatabaseConnector.connect();
		// Get latitude and longitude of corners of bounding box
		double lat_NE = Double.parseDouble(BoundingBox[0]);
		double lng_NE = Double.parseDouble(BoundingBox[1]);
		
		double lat_SW = Double.parseDouble(BoundingBox[2]);
		double lng_SW = Double.parseDouble(BoundingBox[3]);
		
		String sql;
		sql = "SELECT	DISTINCT L.Name, L.Lat, L.Lng, L.Alt, C.name, C.Link " + 
			  "FROM 		raw_location AS L, user AS U, category AS C " + 
			  "WHERE 	C.ID = L.CID AND L.Lat >= ? AND L.Lat <= ? " + 
			  		   "AND L.Lng <= ? AND L.Lng >= ?";
		try {
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setDouble(1, lat_SW);
			ps.setDouble(2, lat_NE);
			ps.setDouble(3, lng_NE);
			ps.setDouble(4, lng_SW);
			
			System.out.println("Query =>" + ps.toString());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				String[] l = new String[6];
				l[0] = rs.getString("Name");		// Location name
				l[1] = rs.getString("Lat");
				l[2] = rs.getString("Lng");
				l[3] = rs.getString("Alt");
				l[4] = rs.getString("name");		// Category Name
				l[5] = rs.getString("Link");		// Path of icon file
				
				userPlaces.add(l);
			}

		} catch (SQLException se) {
			se.printStackTrace();
			LogHandler.UserLogsSQL(se);
		} catch (Exception e) {
			e.printStackTrace();
			LogHandler.UserLogsError(e);
		}
		DatabaseConnector.closeDatabase(ps, rs, conn);
		return userPlaces;
	}
	
	// getAllTags()
		public ArrayList<String[]> getAllPlaces(){
			ArrayList<String[]> allPlaces = new ArrayList<String[]>(); 
			Connection conn = null;
			ResultSet rs = null;
			PreparedStatement ps = null;
			conn = DatabaseConnector.connect();
			
			
			String sql;
			sql = "SELECT	L.Name, L.Lat, L.Lng, L.Alt, L.Address, L.Rating, L.Tag_Date, C.name AS Cat_Name, C.Link " + 
				  "FROM 		raw_location AS L, category AS C " + 
				  "WHERE 	C.ID = L.CID";
			try {
				ps = (PreparedStatement) conn.prepareStatement(sql);
				System.out.println("Query =>" + ps.toString());
				rs = ps.executeQuery();
				
				while(rs.next()) {
					String[] l = new String[9];
					l[0] = rs.getString("Name");		// Location name
					l[1] = rs.getString("Lat");
					l[2] = rs.getString("Lng");
					l[3] = rs.getString("Alt");
					l[4] = rs.getString("Address");
					l[5] = rs.getString("Rating");
					l[6] = rs.getString("Tag_Date");
					l[7] = rs.getString("Cat_Name");		// Category Name
					l[8] = rs.getString("Link");		// Path of icon file
					
					allPlaces.add(l);
				}

			} catch (SQLException se) {
				se.printStackTrace();
				LogHandler.UserLogsSQL(se);
			} catch (Exception e) {
				e.printStackTrace();
				LogHandler.UserLogsError(e);
			}
			DatabaseConnector.closeDatabase(ps, rs, conn);
			return allPlaces;
		}
	
	
	/**
	 * This method searches for a location or similar locations 
	 * based on their names or their categories.
	 * @param: name or cid if it is set before for the object
	 * @return: Array list of string arrays of locations
	 */
	// SearchLocation()
	
	
	
	/**
	 * The following method gets a location record from database
	 * based on its id.
	 * @param: location id.
	 * @return: A string array of location info.
	 */
	// getOneLocation()
}
