package com.banikngapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDate;
import java.util.logging.Logger;
import java.util.logging.Level;

import com.banikngapp.model.UserModel;
import com.banikngapp.service.ProfileService;
import com.banikngapp.util.ImageUtil;
import com.banikngapp.util.PasswordUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/profile" })
@MultipartConfig
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());

	private final ProfileService profileService = new ProfileService();
	private final ImageUtil imageUtil = new ImageUtil();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LOGGER.info("Entering doGet method for Profile");

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("username") == null) {
			LOGGER.warning("No active session or username");
			response.sendRedirect("login");
			return;
		}

		String username = (String) session.getAttribute("username");
		LOGGER.info("Fetching user details for username: " + username);

		UserModel user = profileService.getUserDetails(username);

		if (user != null) {
			if (user.getImageUrl() == null || user.getImageUrl().isEmpty()) {
				user.setImageUrl("default-profile.png");
			}

			request.setAttribute("user", user);
			request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
		} else {
			LOGGER.warning("No user details found for username: " + username);
			response.sendRedirect("login");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("username") == null) {
			resp.sendRedirect("login");
			return;
		}

		String username = (String) session.getAttribute("username");

		String firstName = req.getParameter("first-name");
		String lastName = req.getParameter("last-name");
		String sex = req.getParameter("gender");
		String dobStr = req.getParameter("dob");
		LocalDate dob = LocalDate.parse(dobStr);
		String number = req.getParameter("phone");
		String address = req.getParameter("address");
		String email = req.getParameter("email");
		String dbUsername = req.getParameter("username");
		String password = req.getParameter("password");
		String decryptedPassword = PasswordUtil.decrypt(password, dbUsername);

		// Handle profile image
		Part image = req.getPart("profileImage");
		String imageUrl = imageUtil.getImageNameFromPart(image);

		if (imageUrl == null || imageUrl.isEmpty()) {
			// No new image uploaded – retain existing image
			UserModel existingUser = profileService.getUserDetails(username);
			imageUrl = (existingUser != null && existingUser.getImageUrl() != null) ? existingUser.getImageUrl()
					: "default-profile.png";
		} else {
			// Upload new image to disk
			boolean uploaded = uploadImage(req);
			if (!uploaded) {
				LOGGER.warning("Image upload failed for user: " + username);
			}
		}

		// Create updated user model
		UserModel updatedUser = new UserModel(firstName, lastName, sex, dob, number, address, email, username,
				decryptedPassword, imageUrl);

		boolean isUpdated = profileService.updateUser(updatedUser);

		// Get updated user details to reflect in JSP
		UserModel user = profileService.getUserDetails(username);
		if (user != null && (user.getImageUrl() == null || user.getImageUrl().isEmpty())) {
			user.setImageUrl("default-profile.png");
		}

		req.setAttribute("user", user);
		req.setAttribute("decryptedPassword", decryptedPassword);

		if (isUpdated) {
			req.setAttribute("message", "Profile updated successfully!");
		} else {
			req.setAttribute("message", "Failed to update profile.");
		}

		req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
	}

	private boolean uploadImage(HttpServletRequest req) throws IOException, ServletException {
		Part image = req.getPart("profileImage");
		String appPath = req.getServletContext().getRealPath("/");
		return imageUtil.uploadImage(image, appPath, "user");
	}
}
