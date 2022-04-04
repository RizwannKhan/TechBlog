package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techblog.dao.LikeDao;
import com.techblog.helper.DBConnectionUtil;

@WebServlet("/like")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		String operation = request.getParameter("operation");
		int uid = Integer.parseInt(request.getParameter("uid"));
		int pid = Integer.parseInt(request.getParameter("pid"));

//		out.print("Data from server : " + uid + ", " + pid + ", " + operation);
		
		LikeDao lDao = new LikeDao(DBConnectionUtil.getConnection());
		if(operation.equals("like")) {
			Boolean like = lDao.doLike(pid, uid);			
			out.print(like);
		}

	}

}
