package com.banikngapp.controller;

import com.banikngapp.service.UserAccountsService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(asyncSupported = true, urlPatterns = { "/useraccounts" })
@MultipartConfig
public class UserAccountsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserAccountsService userAccountsService;

    @Override
    public void init() throws ServletException {
        userAccountsService = new UserAccountsService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = (String) request.getSession().getAttribute("username");
            if (username == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            List<Map<String, Object>> accounts = userAccountsService.getUserAccounts(username);
            request.setAttribute("accountList", accounts);
            request.getRequestDispatcher("/WEB-INF/pages/useraccounts.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error fetching user accounts: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching user accounts");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String message = null;

        try {
            if ("deleteUserAccount".equals(action)) {
                String userId = request.getParameter("user_id");
                String accountTypeId = request.getParameter("account_type_id");
                if (userAccountsService.deleteUserAccount(userId, accountTypeId)) {
                    message = "Account deleted successfully.";
                } else {
                    message = "Failed to delete account.";
                }
            }
        } catch (Exception e) {
            System.err.println("Error processing delete action: " + e.getMessage());
            e.printStackTrace();
            message = "Error processing delete action.";
        }

        if (message != null) {
            request.getSession().setAttribute("message", message);
        }

        response.sendRedirect(request.getContextPath() + "/useraccounts");
    }
}