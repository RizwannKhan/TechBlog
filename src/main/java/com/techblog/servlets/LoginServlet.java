package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.DBConnectionUtil;
import com.techblog.helper.PasswordEncoder;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		// String encodedPassword = null;
		try {
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_password");
			// encodedPassword = PasswordEncoder.encrypt(password);
			UserDao dao = new UserDao(DBConnectionUtil.getConnection());

			User user = dao.getUserByEmailAndPassword(email, password);

			if (user == null) {
				// user not exists
				Message msg = new Message("Invalid email or password !!!", "error", "alert-danger");
				response.sendRedirect("login_page");
				HttpSession session = request.getSession();
				session.setAttribute("msg", msg);

			} else {
				// login successful
				HttpSession session = request.getSession();
				session.setAttribute("current_user", user);
				response.sendRedirect("profile");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
