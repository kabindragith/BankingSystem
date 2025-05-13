package com.banikngapp.controller;

import com.banikngapp.service.AdminDashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(asyncSupported = true, urlPatterns = { "/admindashboard" })
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDashboardService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminDashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Map<String, Object>> accounts = adminService.getAllAccounts();
            List<Map<String, Object>> users = adminService.getAllUsers();
            List<Map<String, Object>> userAccounts = adminService.getAllUserAccounts();

            request.setAttribute("accounts", accounts);
            request.setAttribute("users", users);
            request.setAttribute("userAccounts", userAccounts);

            request.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error fetching dashboard data: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching dashboard data");
        }
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
            System.err.println("Error processing delete action: " + e.getMessage());
            e.printStackTrace();
            message = "Error processing delete action.";
        }

        // Store message in session for display
        if (message != null) {
            request.getSession().setAttribute("message", message);
        }

        response.sendRedirect(request.getContextPath() + "/admindashboard");
    }
}