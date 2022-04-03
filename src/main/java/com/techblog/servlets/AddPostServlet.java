package com.techblog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.DBConnectionUtil;
import com.techblog.helper.Helper;

@WebServlet("/addPost")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		int cid = Integer.parseInt(request.getParameter("cid"));
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");

		Part part = request.getPart("pPic");
		String pic = part.getSubmittedFileName();

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("current_user");

		Post post = new Post(pTitle, pContent, pCode, pic, null, cid, user.getId());

		PostDao postDao = new PostDao(DBConnectionUtil.getConnection());

		boolean st = postDao.savePost(post);

		if (st) {
			String path = request.getRealPath("/") + "post_pics" + File.separator + pic;
			Helper.saveFile(part.getInputStream(), path);
			out.println("done");

		} else {
			out.println("error");
		}

	}

}
