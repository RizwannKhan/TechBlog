package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.DBConnectionUtil;
import com.techblog.helper.PasswordEncoder;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		

		String check = request.getParameter("condition");

		if (check == null) {
			out.print("Please agree terms & conditions");
		} else {
			try {
				String name = request.getParameter("user_name");
				String email = request.getParameter("user_email");
				String password = request.getParameter("user_password");
				//encodedPassword = PasswordEncoder.encrypt(password);
				String gender = request.getParameter("gender");
				String about = request.getParameter("user_about");

				User user = new User(name, email, password, gender, about);

				UserDao dao = new UserDao(DBConnectionUtil.getConnection());
				Boolean status = dao.saveUser(user);
				if (status) {
					out.println("done");
				} else {
					out.println("error");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

}
