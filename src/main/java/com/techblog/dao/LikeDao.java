package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {

	private Connection con;
	private PreparedStatement stmt;

	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean doLike(int pid, int uid) {
		boolean st = false;
		try {
			String q = "insert into t_like(pid, uid) values(?, ?)";
			stmt = con.prepareStatement(q);
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			stmt.executeUpdate();
			System.out.println(stmt);
			st = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return st;
	}

	public int countLikeOnPost(int pid) {
		int count = 0;

		try {
			String q = "select count(*) from t_like where pid=?";
			stmt = con.prepareStatement(q);
			stmt.setInt(1, pid);
			ResultSet rs = stmt.executeQuery();
			System.out.println(stmt);

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	public boolean isLikedByUser(int pid, int uid) {
		boolean st = false;

		try {
			String q = "select * from t_like where pid=? and uid=?";
			stmt = con.prepareStatement(q);
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			ResultSet rs = stmt.executeQuery();
			System.out.println(stmt);

			if (rs.next()) {
				st = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return st;
	}

	public boolean dislike(int pid, int uid) {
		boolean st = false;

		try {
			String q = "delete from t_like where pid=? and uid=?";
			stmt = con.prepareStatement(q);
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			stmt.executeUpdate();
			System.out.println(stmt);
			st = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return st;
	}

}
