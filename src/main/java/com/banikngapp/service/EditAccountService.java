package com.banikngapp.service;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.UserAccountsModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * EditAccountService handles retrieval, updating, and deletion of a specific user account.
 */
public class EditAccountService {

    private static Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public EditAccountService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Retrieves details of a specific user account.
     *
     * @param userId    the ID of the user
     * @param accountId the ID of the account
     * @return Map containing UserAccountsModel, user_id, account_type_id, and account type name
     */
    public Map<String, Object> getAccountDetails(String userId, String accountId) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return new HashMap<>();
        }

        Map<String, Object> accountDetails = new HashMap<>();
        String selectQuery = "SELECT ua.user_id, ua.account_id, ua.account_type_id, ua.initial_balance, ua.current_balance, " +
                             "ua.created_at, ua.nickname, a.account_type " +
                             "FROM user_accounts ua " +
                             "JOIN account a ON ua.account_type_id = a.account_type_id " +
                             "WHERE ua.user_id = ? AND ua.account_id = ?"; // Using account_id in WHERE

        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery)) {
            stmt.setString(1, userId);
            stmt.setString(2, accountId); // Using account_id
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    UserAccountsModel userAccount = new UserAccountsModel();
                    userAccount.setUserId(Integer.parseInt(rs.getString("user_id")));
                    userAccount.setAccountId(Integer.parseInt(rs.getString("account_id"))); // Ensure accountId is set
                    userAccount.setInitialBalance(rs.getDouble("initial_balance"));
                    userAccount.setCurrentBalance(rs.getDouble("current_balance"));
                    userAccount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    userAccount.setNickname(rs.getString("nickname"));
                    accountDetails.put("model", userAccount);
                    accountDetails.put("userId", rs.getString("user_id"));
                    accountDetails.put("accountId", rs.getString("account_id")); // Ensure accountId is in the map
                    accountDetails.put("accountTypeId", rs.getString("account_type_id"));
                    accountDetails.put("accountType", rs.getString("account_type"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error during account details retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        return accountDetails;
    }

    /**
     * Updates the account details (nickname and current balance) in the database.
     *
     * @param userId          the ID of the user
     * @param accountId       the ID of the account to update
     * @param newAccountTypeId the new ID of the account type
     * @paramnickname        the new nickname for the account
     * @param currentBalance  the new current balance for the account
     * @return Boolean indicating the success of the operation
     */
    public Boolean updateAccountDetails(String userId, String accountId, String newAccountTypeId, String nickname, double currentBalance) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String updateQuery = "UPDATE user_accounts SET account_type_id = ?, nickname = ?, current_balance = ? " +
                             "WHERE user_id = ? AND account_id = ?"; // Using account_id in WHERE

        try (PreparedStatement stmt = dbConn.prepareStatement(updateQuery)) {
            stmt.setString(1, newAccountTypeId);
            stmt.setString(2, nickname);
            stmt.setDouble(3, currentBalance);
            stmt.setString(4, userId);
            stmt.setString(5, accountId); // Using account_id
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during account update: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a user account from the database.
     *
     * @param userId    the ID of the user
     * @param accountId the ID of the account to delete
     * @return Boolean indicating the success of the operation
     */
    public Boolean closeAccount(String userId, String accountId) { // Using accountId
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String deleteQuery = "DELETE FROM user_accounts WHERE user_id = ? AND account_id = ?"; // Using account_id in WHERE

        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setString(1, userId);
            stmt.setString(2, accountId); // Using accountId
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during account closure: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}