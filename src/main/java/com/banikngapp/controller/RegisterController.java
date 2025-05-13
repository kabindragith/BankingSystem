package com.banikngapp.controller;

import java.io.IOException;
import java.time.LocalDate;

import com.banikngapp.model.UserAccountsModel;
import com.banikngapp.model.UserModel;
import com.banikngapp.service.RegisterService;
import com.banikngapp.util.ImageUtil;
import com.banikngapp.util.PasswordUtil;
import com.banikngapp.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * RegisterController handles user registration requests and processes form
 * submissions. It also manages file uploads and account creation.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ImageUtil imageUtil = new ImageUtil();
	private final RegisterService registerService = new RegisterService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// Validate and extract user model
			String validationMessage = validateRegistrationForm(req);
			if (validationMessage != null) {
				handleError(req, resp, validationMessage);
				return;
			}

			UserModel userModel = extractUserModel(req);
			Boolean isAdded = registerService.addUser(userModel);
			

			if (isAdded == null) {
				handleError(req, resp, "Our server is under maintenance. Please try again later!");
			} else if (isAdded) {
				System.out.print("addedd");
				try {
					if (uploadImage(req)) {
						handleSuccess(req, resp, "Your account is successfully created!", "/WEB-INF/pages/login.jsp");
						registerService.addUserAccounts(userModel);
					} else {
						handleError(req, resp, "Could not upload the image. Please try again later!");
					}
				} catch (IOException | ServletException e) {
					handleError(req, resp, "An error occurred while uploading the image. Please try again later!");
					e.printStackTrace(); // Log the exception
				}
			} else {
				handleError(req, resp, "Could not register your account. Please try again later!");
			}
		} catch (Exception e) {
			handleError(req, resp, "An unexpected error occurred. Please try again later!");
			e.printStackTrace(); // Log the exception
		}
	}

	private String validateRegistrationForm(HttpServletRequest req) {
		String firstName = req.getParameter("first-name");
		String lastName = req.getParameter("last-name");
		String sex = req.getParameter("gender");
		String dobStr = req.getParameter("dob");
		String number = req.getParameter("phone");
		String address = req.getParameter("address");
		String email = req.getParameter("email");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String retypePassword = req.getParameter("rpassword");
		String initialBalanceStr = req.getParameter("initial-balance");

		// Check for null or empty fields
		if (ValidationUtil.isNullOrEmpty(firstName))
			return "First Name is required.";
		if (ValidationUtil.isNullOrEmpty(lastName))
			return "Last Name is required.";
		if (ValidationUtil.isNullOrEmpty(sex))
			return "Gender is required.";
		if (ValidationUtil.isNullOrEmpty(dobStr))
			return "Date of birth is required.";
		if (ValidationUtil.isNullOrEmpty(address))
			return "Address is required.";
		if (ValidationUtil.isNullOrEmpty(number))
			return "Phone number is required.";
		if (ValidationUtil.isNullOrEmpty(email))
			return "Email is required.";
		if (ValidationUtil.isNullOrEmpty(password))
			return "Password is required.";
		if (ValidationUtil.isNullOrEmpty(retypePassword))
			return "Please retype the password.";

		// Convert date of birth
		LocalDate dob;
		try {
			dob = LocalDate.parse(dobStr);
		} catch (Exception e) {
			return "Invalid date format. Please use YYYY-MM-DD.";
		}
		double initialBalance = 0.0;
		try {
			initialBalance = Double.parseDouble(initialBalanceStr);
			if (initialBalance < 100) {
				throw new NumberFormatException();
			}
		} catch (NumberFormatException e) {
			return "Initial balance must be at least $100.";
		}

		// Validate fields
		if (!ValidationUtil.isValidGender(sex))
			return "Gender must be 'male' or 'female'.";
		if (!ValidationUtil.isValidEmail(email))
			return "Invalid email format.";
		if (!ValidationUtil.isValidPhoneNumber(number))
			return "Phone number must be 10 digits and start with 98.";
		if (!ValidationUtil.isValidPassword(password))
			return "Password must be at least 8 characters long, with 1 uppercase letter, 1 number, and 1 symbol.";
		if (!ValidationUtil.doPasswordsMatch(password, retypePassword))
			return "Passwords do not match.";

		// Check if the date of birth is at least 16 years before today
		if (!ValidationUtil.isAgeAtLeast16(dob))
			return "You must be at least 16 years old to register.";

		try {
			Part image = req.getPart("profileImage");
			if (!ValidationUtil.isValidImageExtension(image))
				return "Invalid image format. Only jpg, jpeg, png, and gif are allowed.";
		} catch (IOException | ServletException e) {
			return "Error handling image file. Please ensure the file is valid.";
		}

		return null; // All validations passed
	}

	private UserModel extractUserModel(HttpServletRequest req) throws Exception {
		String firstName = req.getParameter("first-name");
		String lastName = req.getParameter("last-name");
		String sex = req.getParameter("gender");
		String dobStr = req.getParameter("dob");
		LocalDate dob = LocalDate.parse(dobStr);
		String number = req.getParameter("phone");
		String address = req.getParameter("address");
		String email = req.getParameter("email");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		// Encrypt the password
		password = PasswordUtil.encrypt(username, password);
		String accountType = req.getParameter("account-type");
		String nickname = req.getParameter("nickname");
		String initialBalanceStr = req.getParameter("initial-balance");
		double initialBalance = 0.0;
		initialBalance = Double.parseDouble(initialBalanceStr.trim());

		Part image = req.getPart("profileImage");
		String imageUrl = imageUtil.getImageNameFromPart(image);

		return new UserModel(firstName, lastName, sex, dob, number, address, email, username, password, accountType, nickname,
				initialBalance, initialBalance, imageUrl);
	}
	

	
	
	private boolean uploadImage(HttpServletRequest req) throws IOException, ServletException {
		Part image = req.getPart("profileImage");
		return imageUtil.uploadImage(image, req.getServletContext().getRealPath("/"), "user");
	}

	private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
			throws ServletException, IOException {
		req.setAttribute("success", message);
		req.getRequestDispatcher(redirectPage).forward(req, resp);
	}

	private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
			throws ServletException, IOException {

		req.setAttribute("error", message);
		req.setAttribute("firstName", req.getParameter("first-name"));
		req.setAttribute("lastName", req.getParameter("last-name"));
		req.setAttribute("gender", req.getParameter("gender"));
		req.setAttribute("dob", req.getParameter("dob"));
		req.setAttribute("address", req.getParameter("address"));
		req.setAttribute("phone", req.getParameter("phone"));
		req.setAttribute("email", req.getParameter("email"));
		req.setAttribute("username", req.getParameter("username"));
		req.setAttribute("accountType", req.getParameter("account-type"));
		req.setAttribute("nickname", req.getParameter("nickname"));
		req.setAttribute("initialBalance", req.getParameter("initial-balance"));
		req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
	}

}
