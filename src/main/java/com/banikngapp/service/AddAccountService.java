package com.banikngapp.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.UserAccountsModel;

public class AddAccountService {

    private Connection conn;

    public AddAccountService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    public Boolean createAccount(UserAccountsModel userAccount, String username, String accountType) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        }

        String userQuery = "SELECT user_id FROM user WHERE username = ?";
        String accountQuery = "SELECT account_type_id FROM account WHERE account_type = ?";
        String insertQuery = "INSERT INTO user_accounts(user_id, account_type_id, initial_balance, current_balance, nickname) VALUES (?, ?, ?, ?, ?)";

        try (
            PreparedStatement userStmt = conn.prepareStatement(userQuery);
            PreparedStatement accountStmt = conn.prepareStatement(accountQuery);
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        ) {
            // Get user_id
            userStmt.setString(1, username);
            ResultSet userResult = userStmt.executeQuery();
            if (!userResult.next()) return false;
            int userId = userResult.getInt("user_id");

            // Get account_id
            accountStmt.setString(1, accountType);
            ResultSet accResult = accountStmt.executeQuery();
            if (!accResult.next()) return false;
            int accountId = accResult.getInt("account_type_id");

            // Insert into user_accounts
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, accountId);
            insertStmt.setDouble(3, userAccount.getInitialBalance());
            insertStmt.setDouble(4, userAccount.getCurrentBalance());
            insertStmt.setString(5, userAccount.getNickname());

            return insertStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error during account creation: " + e.getMessage());
            return false;
        }
    }
}
