package com.banikngapp.service;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.AccountModel;
import com.banikngapp.model.UserModel;
import com.banikngapp.model.UserAccountsModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AdminDashboardService handles retrieval and deletion of accounts, users, and user accounts.
 * It manages database interactions for the admin dashboard.
 */
public class AdminDashboardService {

    private static Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public AdminDashboardService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Retrieves all account types from the database.
     *
     * @return List of Maps containing AccountModel and account_type_id
     */
    public List<Map<String, Object>> getAllAccounts() {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return new ArrayList<>();
        }

        List<Map<String, Object>> accounts = new ArrayList<>();
        String selectQuery = "SELECT account_type_id, account_type, interest_rate, description FROM account";

        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                AccountModel account = new AccountModel();
                account.setAccountType(rs.getString("account_type"));
                account.setInterestRate(rs.getDouble("interest_rate"));
                account.setDescription(rs.getString("description"));
                Map<String, Object> accountMap = new HashMap<>();
                accountMap.put("model", account);
                accountMap.put("accountTypeId", rs.getString("account_type_id"));
                accounts.add(accountMap);
            }
        } catch (SQLException e) {
            System.err.println("Error during account retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        return accounts;
    }

    /**
     * Retrieves all users from the database.
     *
     * @return List of Maps containing UserModel and user_id
     */
    public List<Map<String, Object>> getAllUsers() {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return new ArrayList<>();
        }

        List<Map<String, Object>> users = new ArrayList<>();
        String selectQuery = "SELECT user_id, first_name, last_name, email, number, username FROM user";

        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setNumber(rs.getString("number"));
                user.setUsername(rs.getString("username"));
                Map<String, Object> userMap = new HashMap<>();
                userMap.put("model", user);
                userMap.put("userId", rs.getString("user_id"));
                users.add(userMap);
            }
        } catch (SQLException e) {
            System.err.println("Error during user retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        return users;
    }

    /**
     * Retrieves all user accounts from the database.
     *
     * @return List of Maps containing UserAccountsModel, user_id, and account_id
     */
    public List<Map<String, Object>> getAllUserAccounts() {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return new ArrayList<>();
        }

        List<Map<String, Object>> userAccounts = new ArrayList<>();
        String selectQuery = "SELECT user_id, account_id, initial_balance, current_balance, created_at, nickname FROM user_accounts";

        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                UserAccountsModel userAccount = new UserAccountsModel();
                userAccount.setUserId(Integer.parseInt(rs.getString("user_id")));
                userAccount.setAccountId(Integer.parseInt(rs.getString("account_id")));
                userAccount.setInitialBalance(rs.getDouble("initial_balance"));
                userAccount.setCurrentBalance(rs.getDouble("current_balance"));
                userAccount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                userAccount.setNickname(rs.getString("nickname"));
                Map<String, Object> userAccountMap = new HashMap<>();
                userAccountMap.put("model", userAccount);
                userAccountMap.put("userId", rs.getString("user_id"));
                userAccountMap.put("accountId", rs.getString("account_id"));
                userAccounts.add(userAccountMap);
            }
        } catch (SQLException e) {
            System.err.println("Error during user accounts retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        return userAccounts;
    }

    /**
     * Deletes an account type from the database.
     *
     * @param accountTypeId the ID of the account type to delete
     * @return Boolean indicating the success of the operation
     */
    public Boolean deleteAccount(String accountTypeId) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String deleteQuery = "DELETE FROM account WHERE account_type_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setString(1, accountTypeId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during account deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a user from the database.
     *
     * @param userId the ID of the user to delete
     * @return Boolean indicating the success of the operation
     */
    public Boolean deleteUser(String userId) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String deleteQuery = "DELETE FROM user WHERE user_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setString(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during user deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a user account from the database.
     *
     * @param userId    the ID of the user
     * @param accountId the ID of the account
     * @return Boolean indicating the success of the operation
     */
    public Boolean deleteUserAccount(String userId, String accountId) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String deleteQuery = "DELETE FROM user_accounts WHERE user_id = ? AND account_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setString(1, userId);
            stmt.setString(2, accountId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during user account deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}