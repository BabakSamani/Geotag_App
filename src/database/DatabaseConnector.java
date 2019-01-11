package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseConnector {

	public static Connection connect(){
		try {
			// Check whether the driver is available to make an instance from it
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			System.out.println("InstantiationException: ");
			e.printStackTrace();
			throw new RuntimeException(e);
		} catch (IllegalAccessException e) {
			System.out.println("IllegalAccessException: ");
			e.printStackTrace();
			throw new RuntimeException(e);
		} catch (ClassNotFoundException e) {
			System.out.println("ClassNotFoundException: ");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		Connection conn = null;

		try {
			conn = DriverManager.getConnection(DatabaseInfo.getDbUrl(), DatabaseInfo.getUser(), DatabaseInfo.getPass());
		} catch (SQLException e) {
			System.out.println("SQLException: ");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		return conn;
	}

	public static void closeDatabase(PreparedStatement ps, ResultSet rs, Connection conn)
	{
		try {
			if(rs != null)
				rs.close();
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		} catch (SQLException e) {
			System.out.println("SQLException: ");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public static void closeDatabase(PreparedStatement ps, Connection conn)
	{
		try {
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		} catch (SQLException e) {
			System.out.println("SQLException: ");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
