package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.techblog.entities.User;

public class UserDao {

	private Connection con;
	private PreparedStatement stmt;

	public UserDao(Connection con) {
		this.con = con;
	}

	// insert user to database...
	public boolean saveUser(User user) {
		boolean status = false;
		try {
			String q = "insert into user(name, email, password, gender, about) values(?, ?, ?, ?, ?)";
			stmt = con.prepareStatement(q);

			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getGender());
			stmt.setString(5, user.getAbout());

			stmt.executeUpdate();
			System.out.println(stmt);
			status = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

}
