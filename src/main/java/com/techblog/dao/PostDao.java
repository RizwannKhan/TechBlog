package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.techblog.entities.Category;
import com.techblog.entities.Post;

public class PostDao {

	private Connection con;
	private PreparedStatement stmt;

	public PostDao(Connection con) {
		this.con = con;
	}

	// getting all categories from database....
	public List<Category> getAllCategories() {
		List<Category> list = new ArrayList<>();

		try {
			String q = "select * from categories";
			stmt = con.prepareStatement(q);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				int cid = rs.getInt("cid");
				String name = rs.getString("name");
				String description = rs.getString("description");
				Category cat = new Category(cid, name, description);
				list.add(cat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// saving post to database...
	public boolean savePost(Post post) {
		boolean st = false;

		try {
			String q = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
			stmt = con.prepareStatement(q);
			stmt.setString(1, post.getpTitle());
			stmt.setString(2, post.getpContent());
			stmt.setString(3, post.getpCode());
			stmt.setString(4, post.getpPic());
			stmt.setInt(5, post.getCatId());
			stmt.setInt(6, post.getUserId());

			stmt.executeUpdate();
			System.out.println(stmt);

			st = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return st;
	}

}
