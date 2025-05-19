package com.banikngapp.service;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.UserAccountsModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * UserAccountsService handles retrieval and deletion of user accounts for the logged-in user.
 */
public class UserAccountsService {

    private static Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public UserAccountsService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Retrieves all accounts for the logged-in user along with their profile image URL.
     *
     * @param username the username of the logged-in user
     * @return List of Maps containing UserAccountsModel, user_id, account_type_id,
     * account type name, and user's image URL
     */
    public Map<String, Object> getUserAccountsWithProfile(String username) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return new HashMap<>();
        }

        List<Map<String, Object>> userAccounts = new ArrayList<>();
        String selectQuery = "SELECT ua.user_id, ua.account_id, ua.account_type_id, ua.initial_balance, ua.current_balance, " +
                             "ua.created_at, ua.nickname, a.account_type AS account_type, u.image_url " +
                             "FROM user_accounts ua " +
                             "JOIN user u ON ua.user_id = u.user_id " +
                             "JOIN account a ON ua.account_type_id = a.account_type_id " +
                             "WHERE u.username = ?";

        String selectUserQuery = "SELECT image_url FROM user WHERE username = ?";
        String imageUrl = null;

        try (PreparedStatement userStmt = dbConn.prepareStatement(selectUserQuery)) {
            userStmt.setString(1, username);
            try (ResultSet userRs = userStmt.executeQuery()) {
                if (userRs.next()) {
                    imageUrl = userRs.getString("image_url");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user image URL: " + e.getMessage());
            e.printStackTrace();
        }


        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserAccountsModel userAccount = new UserAccountsModel();
                    userAccount.setUserId(Integer.parseInt(rs.getString("user_id")));
                    userAccount.setAccountId(Integer.parseInt(rs.getString("account_id"))); // Added this line
                    userAccount.setInitialBalance(rs.getDouble("initial_balance"));
                    userAccount.setCurrentBalance(rs.getDouble("current_balance"));
                    userAccount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    userAccount.setNickname(rs.getString("nickname"));
                    Map<String, Object> userAccountMap = new HashMap<>();
                    userAccountMap.put("model", userAccount);
                    userAccountMap.put("userId", rs.getString("user_id"));
                    userAccountMap.put("accountId", rs.getString("account_id")); // Added this line
                    userAccountMap.put("accountTypeId", rs.getString("account_type_id"));
                    userAccountMap.put("accountType", rs.getString("account_type"));
                    userAccounts.add(userAccountMap);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error during user accounts retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        Map<String, Object> result = new HashMap<>();
        result.put("accounts", userAccounts);
        result.put("imageUrl", imageUrl);
        return result;
    }

    /**
     * Deletes a user account from the database.
     *
     * @param userId      the ID of the user
     * @param accountTypeId the ID of the account type
     * @return Boolean indicating the success of the operation
     */
    public Boolean deleteUserAccount(String userId, String accountTypeId) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String deleteQuery = "DELETE FROM user_accounts WHERE user_id = ? AND account_type_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setString(1, userId);
            stmt.setString(2, accountTypeId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during user account deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}