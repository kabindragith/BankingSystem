package com.banikngapp.controller;

import com.banikngapp.model.UserAccountsModel; // Import the UserAccountsModel
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

            Map<String, Object> accountData = userAccountsService.getUserAccountsWithProfile(username);
            List<Map<String, Object>> accounts = (List<Map<String, Object>>) accountData.get("accounts");
            String imageUrl = (String) accountData.get("imageUrl");

            // Calculate summary data
            double totalBalance = 0;
            int numberOfAccounts = accounts.size();
            double savingsBalance = 0;
            double checkingBalance = 0;
            double investmentBalance = 0;
            Map<String, Object> highestValueAccountMap = null;
            UserAccountsModel highestValueAccountModel = null;

            for (Map<String, Object> accountMap : accounts) {
                UserAccountsModel userAccountModel = (UserAccountsModel) accountMap.get("model"); // Correct casting
                String accountType = (String) accountMap.get("accountType");
                double currentBalance = userAccountModel.getCurrentBalance(); // Access property directly
                totalBalance += currentBalance;

                if ("Savings Account".equalsIgnoreCase(accountType)) {
                    savingsBalance += currentBalance;
                } else if ("Checking Account".equalsIgnoreCase(accountType)) { // Corrected comparison
                    checkingBalance += currentBalance;
                } else if ("Investment".equalsIgnoreCase(accountType)) {
                    investmentBalance += currentBalance;
                }

                if (highestValueAccountModel == null || currentBalance > highestValueAccountModel.getCurrentBalance()) {
                    highestValueAccountMap = accountMap;
                    highestValueAccountModel = userAccountModel;
                }
            }
            // Set summary data as request attributes
            request.setAttribute("accountList", accounts);
            request.setAttribute("userImageUrl", imageUrl);
            request.setAttribute("totalBalance", totalBalance);
            request.setAttribute("numberOfAccounts", numberOfAccounts);
            request.setAttribute("savingsBalance", savingsBalance);
            request.setAttribute("checkingBalance", checkingBalance);
            request.setAttribute("investmentBalance", investmentBalance);
            request.setAttribute("highestValueAccount", highestValueAccountMap); // Pass the Map containing the model

            request.getRequestDispatcher("/WEB-INF/pages/useraccounts.jsp").forward(request, response);
         // Set summary data as request attributes
            System.out.println("Total Balance: " + totalBalance);
            request.setAttribute("totalBalance", totalBalance);
            System.out.println("Number of Accounts: " + numberOfAccounts);
            request.setAttribute("numberOfAccounts", numberOfAccounts);
            System.out.println("Savings Balance: " + savingsBalance);
            request.setAttribute("savingsBalance", savingsBalance);
            System.out.println("Checking Balance: " + checkingBalance);
            request.setAttribute("checkingBalance", checkingBalance);
            System.out.println("Investment Balance: " + investmentBalance);
            request.setAttribute("investmentBalance", investmentBalance);
            System.out.println("Highest Value Account Map: " + highestValueAccountMap);
            request.setAttribute("highestValueAccount", highestValueAccountMap); // Pass the Map containing the model
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