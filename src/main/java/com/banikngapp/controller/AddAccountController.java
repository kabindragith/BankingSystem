package com.banikngapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;

import com.banikngapp.model.UserAccountsModel;
import com.banikngapp.service.AddAccountService;

@WebServlet("/addaccount")
@MultipartConfig
public class AddAccountController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddAccountController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/addaccount.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            if (username == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String accountType = request.getParameter("accountType");
            double initialBalance = Double.parseDouble(request.getParameter("initialBalance"));
            String nickname = request.getParameter("nickname");

            UserAccountsModel model = new UserAccountsModel(
                initialBalance,
                initialBalance,
                LocalDateTime.now(),
                0, // dummy userId, real one fetched in service
                0, // dummy accountId, real one fetched in service
                nickname
            );

            AddAccountService service = new AddAccountService();
            boolean success = service.createAccount(model, username, accountType);

            if (success) {
                handleSuccess(request, response, "Account added successfully!", "/WEB-INF/pages/useraccounts.jsp");
            } else {
                handleError(request, response, "Failed to add account. Please try again.");
            }

        } catch (Exception e) {
            handleError(request, response, "An unexpected error occurred.");
        }
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/addaccount.jsp").forward(req, resp);
    }

    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
            throws ServletException, IOException {
        req.setAttribute("success", message);
        req.getRequestDispatcher(redirectPage).forward(req, resp);
    }
}
