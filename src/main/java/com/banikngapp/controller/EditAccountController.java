package com.banikngapp.controller;

import com.banikngapp.service.EditAccountService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(asyncSupported = true, urlPatterns = { "/editaccount" })
public class EditAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EditAccountService editAccountService;

	@Override
	public void init() throws ServletException {
		editAccountService = new EditAccountService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String username = (String) request.getSession().getAttribute("username");
			if (username == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}

			String userId = request.getParameter("user_id");
			String accountId = request.getParameter("account_id"); // Using account_id
			if (userId == null || accountId == null) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user_id or account_id");
				return;
			}

			Map<String, Object> accountDetails = editAccountService.getAccountDetails(userId, accountId); // Using
																											// account_id
			if (accountDetails.isEmpty()) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Account not found");
				return;
			}

			request.setAttribute("account", accountDetails);
			request.getRequestDispatcher("/WEB-INF/pages/editaccount.jsp").forward(request, response);
		} catch (Exception e) {
			System.err.println("Error fetching account details: " + e.getMessage());
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching account details");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		String message = null;

		try {
			String userId = request.getParameter("user_id");
			String accountId = request.getParameter("account_id"); // Using account_id
			if (userId == null || accountId == null) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user_id or account_id");
				return;
			}

			if ("closeAccount".equals(action)) {
				if (editAccountService.closeAccount(userId, accountId)) { // Using account_id
					message = "Account closed successfully.";
				} else {
					message = "Failed to close account.";
				}
			} else if ("updateDetails".equals(action)) {
				// Update account details including balance
				String newAccountType = request.getParameter("accountType");
				String nickname = request.getParameter("accountNickname");
				String currentBalanceStr = request.getParameter("currentBalance");
				double currentBalance = 0.0;
				try {
					currentBalance = Double.parseDouble(currentBalanceStr);
				} catch (NumberFormatException e) {
					message = "Invalid balance format.";
					request.getSession().setAttribute("message", message);
					response.sendRedirect(
							request.getContextPath() + "/editaccount?user_id=" + userId + "&account_id=" + accountId); // Using
																														// account_id
					return;
				}

				// Map accountType (e.g., "checking") to account_type_id
				String newAccountTypeId = getAccountTypeId(newAccountType);
				if (newAccountTypeId == null) {
					message = "Invalid account type selected.";
				} else if (editAccountService.updateAccountDetails(userId, accountId, newAccountTypeId, nickname,
						currentBalance)) { // Using account_id
					message = "Account updated successfully.";
				} else {
					message = "Failed to update account.";
				}
			}
		} catch (Exception e) {
			System.err.println("Error processing edit action: " + e.getMessage());
			e.printStackTrace();
			message = "Error processing edit action.";
		}

		if (message != null) {
			request.getSession().setAttribute("message", message);
		}

		response.sendRedirect(request.getContextPath() + "/useraccounts");
	}

	/**
	 * Maps account type name to account_type_id. This is a placeholder; in a real
	 * app, this would query the account table.
	 *
	 * @param accountType the account type name (e.g., "checking", "savings")
	 * @return the corresponding account_type_id, or null if invalid
	 */
	private String getAccountTypeId(String accountType) {
		// Placeholder mapping (query the account table in a real app)
		switch (accountType.toLowerCase()) {
		case "checking":
			return "2"; // Assumes "Checking" has account_type_id = 2
		case "savings":
			return "1"; // Assumes "Savings" has account_type_id = 1
		default:
			return null;
		}
	}
}