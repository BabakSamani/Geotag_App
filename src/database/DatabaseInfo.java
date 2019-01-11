package database;

import io.github.cdimascio.dotenv.Dotenv;

public class DatabaseInfo {
	
	private static Dotenv dotenv = Dotenv.configure()
						    .directory("../assets/")
						    .ignoreIfMalformed()
						    .ignoreIfMissing()
						    .load();
	
	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	
	
	public static String getJdbcDriver() {
		return JDBC_DRIVER;
	}

	public static String getDbUrl() {
		
		String DB_URL = dotenv.get("DB_URL");
		System.out.println(DB_URL);
		
		return DB_URL;
	}

	public static String getUser() {
		
		return dotenv.get("DB_USER");
	}

	public static String getPass() {
		
		return dotenv.get("DB_PASS");
	}


}
