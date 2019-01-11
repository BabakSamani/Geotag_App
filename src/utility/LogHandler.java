package utility;

import java.sql.SQLException;
import org.apache.log4j.Logger;

import models.User;

public class LogHandler {
	private static org.apache.log4j.Logger usersLogHandler = Logger.getLogger(User.class);
	
	//Logs for errors exceptions in Users classes
	public static void UserLogsError(Exception e){
		usersLogHandler.fatal("This is a fatal message from Users class: ", e);
		usersLogHandler.error("This is an error message from Users class: ", e);
		usersLogHandler.warn("This is a warn message from Users class: ", e);
		usersLogHandler.info("This is an info message from Users class: ", e);
		usersLogHandler.debug("This is a debug message from Users class: ", e);
		usersLogHandler.trace("This is a trace message from Users class: ", e);
	}
	
	// Logs for SQL exceptions in Hotels, Users and Reservations classes
	public static void UserLogsSQL(SQLException se){
		usersLogHandler.fatal("This is a SQL fatal message from Users class: ", se);
		usersLogHandler.error("This is a SQL error message from Users class: ", se);
		usersLogHandler.warn("This is a SQL warn message from Users class: ", se);
		usersLogHandler.info("This is a SQL info message from Users class: ", se);
		usersLogHandler.debug("This is a SQL debug message from Users class: ", se);
		usersLogHandler.trace("This is a SQL trace message from Users class: ", se);
	}
}
