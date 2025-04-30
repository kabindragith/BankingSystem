package com.banikngapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


import com.banikngapp.service.LoginService;
import com.banikngapp.util.CookieUtil;
import com.banikngapp.util.SessionUtil;
import com.banikngapp.model.UserModel;
@WebServlet(asyncSupported = true, urlPatterns = { "/login", "/" })
	public class LoginController extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    private final LoginService loginService;

	    public LoginController() {
	        this.loginService = new LoginService();
	    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Display the login page
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	    String Email = request.getParameter("username");
    	    String password = request.getParameter("password");

    	    UserModel user = new UserModel(Email, password);
    	  

    	    Boolean loginStatus = loginService.loginUser(user);
    	  

    	    if (Boolean.TRUE.equals(loginStatus)) {
    	    	SessionUtil.setAttribute(request, "Email", Email);
    			if (Email.equals("admin@gmail.com")) {
    				CookieUtil.addCookie(response, "role", "admin", 5 * 30);
    				request.setAttribute("success", "Login successful!");
    				request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
    	    } else {
				CookieUtil.addCookie(response, "role", "user", 5 * 30);
				response.sendRedirect(request.getContextPath() + "/home"); 
			}}
    			else {
    	        System.out.println("Login failed");
    	        handleLoginFailure(request, response, loginStatus);
    	    }


    	    
    	        }
 private void handleLoginFailure(HttpServletRequest req, HttpServletResponse resp, Boolean loginStatus)
			throws ServletException, IOException {
		String errorMessage;
		if (loginStatus == null) {
			errorMessage = "Our server is under maintenance. Please try again later!";
		} else {
			errorMessage = "User credential mismatch. Please try again!";
		}
		req.setAttribute("error", errorMessage);
		req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
	}
    	    }