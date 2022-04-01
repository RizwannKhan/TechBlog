package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

	// get user by email and password
	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;

		try {
			String q = "select * from user where email=? and password=?";
			stmt = con.prepareStatement(q);

			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			System.out.println(stmt);

			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setRegDate(rs.getTimestamp("reg_date"));
				user.setProfile(rs.getString("profile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

}
