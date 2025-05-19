package com.banikngapp.controller;

import com.banikngapp.model.UserModel;
import com.banikngapp.service.AdminDashboardService;
import com.banikngapp.service.ProfileService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet(urlPatterns = { "/admindashboard" })
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(AdminDashboardController.class.getName());
    private AdminDashboardService adminService;
    private ProfileService profileService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminDashboardService();
        profileService = new ProfileService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Entering doGet method for AdminDashboard");

        // Check for active session and username
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            LOGGER.warning("No active session or username");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        LOGGER.info("Fetching user details for username: " + username);

        // Fetch UserModel for the logged-in user
        UserModel user = profileService.getUserDetails(username);
        if (user != null) {
            // Set default image if imageUrl is empty
            if (user.getImageUrl() == null || user.getImageUrl().isEmpty()) {
                user.setImageUrl("default-profile.png");
            }
            request.setAttribute("user", user);
        } else {
            LOGGER.warning("No user details found for username: " + username);
            session.setAttribute("message", "Error loading user data");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch dashboard data
        List<Map<String, Object>> accounts = adminService.getAllAccounts();
        List<Map<String, Object>> users = adminService.getAllUsers();
        List<Map<String, Object>> userAccounts = adminService.getAllUserAccounts();
        Map<String, Object> stats = adminService.getDashboardStats();

        // Set dashboard attributes
        request.setAttribute("accounts", accounts);
        request.setAttribute("users", users);
        request.setAttribute("userAccounts", userAccounts);
        request.setAttribute("totalUsers", stats.get("totalUsers"));
        request.setAttribute("totalUserAccounts", stats.get("totalUserAccounts"));
        request.setAttribute("userWithMostBalance", stats.get("userWithMostBalance"));
        request.setAttribute("totalBalance", stats.get("totalBalance"));
        request.setAttribute("savingsAccounts", stats.get("savingsAccounts"));

        LOGGER.info("Forwarding to admindashboard.jsp for username: " + username);
        request.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String message = null;

        try {
            if ("deleteAccount".equals(action)) {
                String accountTypeId = request.getParameter("account_type_id");
                if (adminService.deleteAccount(accountTypeId)) {
                    message = "Account deleted successfully.";
                } else {
                    message = "Failed to delete account.";
                }
            } else if ("deleteUser".equals(action)) {
                String userId = request.getParameter("user_id");
                if (adminService.deleteUser(userId)) {
                    message = "User deleted successfully.";
                } else {
                    message = "Failed to delete user.";
                }
            } else if ("deleteUserAccount".equals(action)) {
                String userId = request.getParameter("user_id");
                String accountId = request.getParameter("account_id");
                if (adminService.deleteUserAccount(userId, accountId)) {
                    message = "User account deleted successfully.";
                } else {
                    message = "Failed to delete user account.";
                }
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing delete action: " + e.getMessage());
            message = "Error processing delete action.";
        }

        if (message != null) {
            request.getSession().setAttribute("message", message);
        }

        response.sendRedirect(request.getContextPath() + "/admindashboard");
    }
}