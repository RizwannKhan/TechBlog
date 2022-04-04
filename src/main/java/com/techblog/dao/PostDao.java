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

	// get all posts...
	public List<Post> getAllPosts() {
		List<Post> list = new ArrayList<>();

		try {
			String q = "select * from posts order by pid desc";
			stmt = con.prepareStatement(q);
			ResultSet rs = stmt.executeQuery();
			System.out.println(stmt);
			while (rs.next()) {
				Post p = new Post();
				p.setpId(rs.getInt("pid"));
				p.setpTitle(rs.getString("pTitle"));
				p.setpContent(rs.getString("pContent"));
				p.setpCode(rs.getString("pCode"));
				p.setpPic(rs.getString("pPic"));
				p.setpDate(rs.getTimestamp("pDate"));
				p.setCatId(rs.getInt("catId"));
				p.setUserId(rs.getInt("userId"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// get posts by category
	public List<Post> getPostByCatId(int catId) {
		List<Post> list = new ArrayList<>();

		try {
			String q = "select * from posts where catId=?";
			stmt = con.prepareStatement(q);
			stmt.setInt(1, catId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Post p = new Post();
				p.setpId(rs.getInt("pid"));
				p.setpTitle(rs.getString("pTitle"));
				p.setpContent(rs.getString("pContent"));
				p.setpCode(rs.getString("pCode"));
				p.setpPic(rs.getString("pPic"));
				p.setpDate(rs.getTimestamp("pDate"));
				p.setCatId(rs.getInt("catId"));
				p.setUserId(rs.getInt("userId"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// get post by post id...
	public Post getPostById(int postId) {
		Post p = null;

		try {
			String q = "select * from posts where pid=?";
			stmt = con.prepareStatement(q);
			stmt.setInt(1, postId);
			ResultSet rs = stmt.executeQuery();
			System.out.println(stmt);

			if (rs.next()) {
				p = new Post();
				p.setpId(rs.getInt("pid"));
				p.setpTitle(rs.getString("pTitle"));
				p.setpContent(rs.getString("pContent"));
				p.setpCode(rs.getString("pCode"));
				p.setpPic(rs.getString("pPic"));
				p.setpDate(rs.getTimestamp("pDate"));
				p.setCatId(rs.getInt("catId"));
				p.setUserId(rs.getInt("userId"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p;
	}

}
