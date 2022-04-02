package com.techblog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.DBConnectionUtil;
import com.techblog.helper.Helper;

@WebServlet("/edit")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		String name = request.getParameter("user_name");
		String password = request.getParameter("user_password");
		String about = request.getParameter("user_about");
		Part part = request.getPart("image");
		String imageName = part.getSubmittedFileName();

		// get user from session...
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("current_user");

		user.setName(name);
		user.setPassword(password);
		user.setAbout(about);
		String oldProfile = user.getProfile();
		user.setProfile(imageName);

		// update database....
		UserDao dao = new UserDao(DBConnectionUtil.getConnection());
		boolean st = dao.updateUser(user);

		if (st) {
			// delete old profile pic....
			String oldPath = request.getRealPath("/") + "pics" + File.separator + oldProfile;
			if (!oldProfile.equals("default.png")) {
				Helper.deleteFile(oldPath);
			}

			// save new profile pic...
			String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
			if (Helper.saveFile(part.getInputStream(), path)) {
				out.print("profile updated");
				Message msg = new Message("Profile Updated !!!", "success", "alert-success");
				session.setAttribute("msg", msg);

			} else {
				Message msg = new Message("Something went wrong !!!", "error", "alert-danger");
				session.setAttribute("msg", msg);
			}

		} else

		{
			out.print("not updated");
			Message msg = new Message("Something went wrong !!!", "error", "alert-danger");
			session.setAttribute("msg", msg);
		}

		response.sendRedirect("profile");

	}

}
