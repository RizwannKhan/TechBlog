package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnectionUtil {

	private static Connection con = null;
	private final static String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
	private final static String DB_URL = "jdbc:mysql://localhost:3306/techblog_app?useSSL=false";
	private final static String DB_USER = "root";
	private final static String DB_PASS = "1234";

	public static Connection getConnection() {
		try {
			if (con == null) {
				System.out.println("Connecting to database");
				Class.forName(DB_DRIVER);
				con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
				System.out.println("Connected to Database successfully");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

}
