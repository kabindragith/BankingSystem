package com.banikngapp.controller;

import com.banikngapp.model.UserModel;
import com.banikngapp.service.ProfileService;
import com.banikngapp.service.UserDashboardService;
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

/**
 * Servlet for handling user dashboard functionality.
 * Manages GET requests to display dashboard data and POST requests for account actions.
 */
@WebServlet(urlPatterns = {"/userdashboard"})
public class UserDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UserDashboardController.class.getName());
    private UserDashboardService userService;
    private ProfileService profileService;

    /**
     * Initializes the servlet, creating instances of required services.
     */
    @Override
    public void init() throws ServletException {
        userService = new UserDashboardService();
        profileService = new ProfileService();
    }

    /**
     * Handles GET requests to display the user dashboard.
     * Fetches user details and dashboard statistics, then forwards to the JSP.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Entering doGet method for UserDashboard");

        // Check for active session and username
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            LOGGER.warning("No active session or username found");
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

            // Fetch dashboard data using the username to get userId
            List<Map<String, Object>> userAccounts = userService.getUserAccounts(username);
            Map<String, Object> stats = userService.getUserDashboardStats(username);

            // Set dashboard attributes for JSP
            request.setAttribute("userAccounts", userAccounts);
            request.setAttribute("numberOfAccounts", stats.get("numberOfAccounts"));
            request.setAttribute("totalBalance", stats.get("totalBalance"));
            request.setAttribute("savingsBalance", stats.get("savingsBalance"));
            request.setAttribute("checkingBalance", stats.get("checkingBalance"));
            request.setAttribute("investmentBalance", stats.get("investmentBalance"));
            request.setAttribute("highestValueAccount", stats.get("highestValueAccount"));
            request.setAttribute("recentActivity", stats.get("recentActivity"));

            LOGGER.info("Forwarding to userdashboard.jsp for username: " + username);
            request.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp").forward(request, response);

        } else {
            LOGGER.warning("No user details found for username: " + username);
            session.setAttribute("message", "Error loading user data");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
    }

    /**
     * Handles POST requests for user account actions (e.g., delete account, update nickname).
     * Validates user ownership and processes the requested action.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Entering doPost method for UserDashboard");

        // Check for active session and username
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            LOGGER.warning("No active session or username found");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        UserModel user = profileService.getUserDetails(username);
        if (user == null) {
            LOGGER.warning("No user details found for username: " + username);
            session.setAttribute("message", "Error loading user data");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String message = null;

        try {
            // Get userId from the username using the userService
            Integer userId = userService.getUserIdByUsername(username);
            if (userId == null) {
                LOGGER.warning("Could not retrieve userId for username: " + username);
                session.setAttribute("message", "Error processing request. User ID not found.");
                session.setAttribute("messageType", "error");
                response.sendRedirect("userdashboard");
                return;
            }

            if ("deleteAccount".equals(action)) {
                String accountIdStr = request.getParameter("account_id");
                int accountId = Integer.parseInt(accountIdStr);
                if (!userService.isAccountOwnedByUser(accountId, userId)) {
                    message = "You do not have permission to delete this account";
                    LOGGER.warning("Unauthorized delete attempt of account " + accountId + " by user " + username + " (ID: " + userId + ")");
                } else if (userService.deleteUserAccount(accountId)) {
                    message = "Account deleted successfully";
                } else {
                    message = "Failed to delete account";
                }
            } else if ("updateAccountNickname".equals(action)) {
                String accountIdStr = request.getParameter("account_id");
                int accountId = Integer.parseInt(accountIdStr);
                String nickname = request.getParameter("nickname");
                if (!userService.isAccountOwnedByUser(accountId, userId)) {
                    message = "You do not have permission to update this account";
                    LOGGER.warning("Unauthorized update attempt of account " + accountId + " by user " + username + " (ID: " + userId + ")");
                } else if (userService.updateAccountNickname(accountId, nickname)) {
                    message = "Account nickname updated successfully";
                } else {
                    message = "Failed to update account nickname";
                }
            } else {
                message = "Invalid action specified";
                LOGGER.warning("Invalid action: " + action + " by user " + username + " (ID: " + userId + ")");
            }
        } catch (NumberFormatException e) {
            LOGGER.severe("Invalid account ID format: " + e.getMessage());
            message = "Invalid account ID provided";
        } catch (Exception e) {
            LOGGER.severe("Error processing action: " + e.getMessage());
            message = "An error occurred while processing your request";
        }

        if (message != null) {
            session.setAttribute("message", message);
            session.setAttribute("messageType", (message.contains("successfully")) ? "success" : "error");
        }
        response.sendRedirect("userdashboard");
    }
}