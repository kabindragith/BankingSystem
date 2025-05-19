package com.banikngapp.service;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.AccountModel;
import com.banikngapp.model.UserAccountsModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class UserDashboardService {
    private static final Logger LOGGER = Logger.getLogger(UserDashboardService.class.getName());
    private static Connection dbConn;

    public UserDashboardService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.severe("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public Integer getUserIdByUsername(String username) {
        if (dbConn == null) {
            LOGGER.severe("Database connection is not available.");
            return null;
        }
        String query = "SELECT user_id FROM user WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id");
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching user ID by username: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public List<Map<String, Object>> getUserAccounts(String username) {
        Integer userId = getUserIdByUsername(username);
        if (userId == null) {
            LOGGER.warning("Could not retrieve userId for username: " + username + ". Returning empty account list.");
            return new ArrayList<>();
        }
        return getUserAccountsByUserId(userId);
    }

    private List<Map<String, Object>> getUserAccountsByUserId(int userId) {
        if (dbConn == null) {
            LOGGER.severe("Database connection is not available.");
            return new ArrayList<>();
        }

        List<Map<String, Object>> userAccounts = new ArrayList<>();
        String query = "SELECT ua.user_id, ua.account_id, ua.current_balance, ua.initial_balance, " +
                "ua.nickname, ua.created_at, a.account_type, a.interest_rate, a.description " +
                "FROM user_accounts ua " +
                "JOIN account a ON ua.account_type_id = a.account_type_id " +
                "WHERE ua.user_id = ? " +
                "ORDER BY ua.created_at DESC";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Create AccountModel for account type information
                    AccountModel accountModel = new AccountModel();
                    accountModel.setAccountType(rs.getString("account_type"));
                    accountModel.setInterestRate(rs.getDouble("interest_rate"));
                    accountModel.setDescription(rs.getString("description"));

                    // Create UserAccountsModel for user-specific account details
                    UserAccountsModel userAccountModel = new UserAccountsModel();
                    userAccountModel.setCurrentBalance(rs.getDouble("current_balance"));
                    userAccountModel.setInitialBalance(rs.getDouble("initial_balance"));
                    userAccountModel.setNickname(rs.getString("nickname"));
                    userAccountModel.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    userAccountModel.setUserId(rs.getInt("user_id"));
                    userAccountModel.setAccountId(rs.getInt("account_id"));

                    Map<String, Object> accountMap = new HashMap<>();
                    accountMap.put("accountModel", accountModel);
                    accountMap.put("userAccountModel", userAccountModel);
                    accountMap.put("createdAtDate", java.sql.Timestamp.valueOf(userAccountModel.getCreatedAt()));
                    userAccounts.add(accountMap);
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error during user accounts retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        return userAccounts;
    }

    public Map<String, Object> getUserDashboardStats(String username) {
        Integer userId = getUserIdByUsername(username);
        if (userId == null) {
            LOGGER.warning("Could not retrieve userId for username: " + username + ". Returning empty stats.");
            return new HashMap<>();
        }
        return getUserDashboardStatsByUserId(userId);
    }

    private Map<String, Object> getUserDashboardStatsByUserId(int userId) {
        if (dbConn == null) {
            LOGGER.severe("Database connection is not available.");
            return new HashMap<>();
        }

        Map<String, Object> stats = new HashMap<>();
        stats.put("numberOfAccounts", 0);
        stats.put("totalBalance", 0.0);
        stats.put("savingsBalance", 0.0);
        stats.put("checkingBalance", 0.0);
        stats.put("investmentBalance", 0.0);

        String query = "SELECT COUNT(ua.account_id) as account_count, " +
                "SUM(ua.current_balance) as total_balance, " +
                "SUM(CASE WHEN a.account_type = 'Savings Account' THEN ua.current_balance ELSE 0 END) as savings_balance, " +
                "SUM(CASE WHEN a.account_type = 'Checking Account' THEN ua.current_balance ELSE 0 END) as checking_balance, " +
                "SUM(CASE WHEN a.account_type = 'Investment' THEN ua.current_balance ELSE 0 END) as investment_balance " +
                "FROM user_accounts ua " +
                "JOIN account a ON ua.account_type_id = a.account_type_id " +
                "WHERE ua.user_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("numberOfAccounts", rs.getInt("account_count"));
                    stats.put("totalBalance", rs.getDouble("total_balance"));
                    stats.put("savingsBalance", rs.getDouble("savings_balance"));
                    stats.put("checkingBalance", rs.getDouble("checking_balance"));
                    stats.put("investmentBalance", rs.getDouble("investment_balance"));
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching user balance statistics: " + e.getMessage());
            e.printStackTrace();
        }

        // Get highest value account
        String highestValueQuery = "SELECT ua.account_id, ua.nickname, ua.current_balance, ua.initial_balance, " +
                "ua.created_at, a.account_type, a.interest_rate, a.description " +
                "FROM user_accounts ua " +
                "JOIN account a ON ua.account_type_id = a.account_type_id " +
                "WHERE ua.user_id = ? " +
                "ORDER BY ua.current_balance DESC LIMIT 1";

        try (PreparedStatement stmt = dbConn.prepareStatement(highestValueQuery)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Create AccountModel for account type information
                    AccountModel accountModel = new AccountModel();
                    accountModel.setAccountType(rs.getString("account_type"));
                    accountModel.setInterestRate(rs.getDouble("interest_rate"));
                    accountModel.setDescription(rs.getString("description"));

                    // Create UserAccountsModel for user-specific account details
                    UserAccountsModel userAccountModel = new UserAccountsModel();
                    userAccountModel.setCurrentBalance(rs.getDouble("current_balance"));
                    userAccountModel.setInitialBalance(rs.getDouble("initial_balance"));
                    userAccountModel.setNickname(rs.getString("nickname"));
                    userAccountModel.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    userAccountModel.setAccountId(rs.getInt("account_id"));
                    userAccountModel.setUserId(userId);

                    Map<String, Object> highestValueAccount = new HashMap<>();
                    highestValueAccount.put("accountModel", accountModel);
                    highestValueAccount.put("userAccountModel", userAccountModel);
                    stats.put("highestValueAccount", highestValueAccount);
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching highest value account: " + e.getMessage());
            e.printStackTrace();
        }

        // Get recent activity (using account creation dates for now)
        String recentActivityQuery = "SELECT ua.account_id, ua.user_id, ua.nickname, ua.current_balance, " +
                "ua.initial_balance, ua.created_at, a.account_type, a.interest_rate, a.description " +
                "FROM user_accounts ua " +
                "JOIN account a ON ua.account_type_id = a.account_type_id " +
                "WHERE ua.user_id = ? " +
                "ORDER BY ua.created_at DESC LIMIT 5";

        List<Map<String, Object>> recentActivity = new ArrayList<>();
        try (PreparedStatement stmt = dbConn.prepareStatement(recentActivityQuery)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Create AccountModel for account type information
                    AccountModel accountModel = new AccountModel();
                    accountModel.setAccountType(rs.getString("account_type"));
                    accountModel.setInterestRate(rs.getDouble("interest_rate"));
                    accountModel.setDescription(rs.getString("description"));

                    // Create UserAccountsModel for user-specific account details
                    UserAccountsModel userAccountModel = new UserAccountsModel();
                    userAccountModel.setCurrentBalance(rs.getDouble("current_balance"));
                    userAccountModel.setInitialBalance(rs.getDouble("initial_balance"));
                    userAccountModel.setNickname(rs.getString("nickname"));
                    userAccountModel.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    userAccountModel.setUserId(rs.getInt("user_id"));
                    userAccountModel.setAccountId(rs.getInt("account_id"));

                    Map<String, Object> activity = new HashMap<>();
                    activity.put("accountModel", accountModel);
                    activity.put("userAccountModel", userAccountModel);
                    activity.put("date", rs.getTimestamp("created_at"));
                    recentActivity.add(activity);
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching recent activity: " + e.getMessage());
            e.printStackTrace();
        }

        stats.put("recentActivity", recentActivity);
        return stats;
    }

    public boolean isAccountOwnedByUser(int accountId, int userId) {
        if (dbConn == null) {
            LOGGER.severe("Database connection is not available.");
            return false;
        }

        String query = "SELECT COUNT(*) FROM user_accounts WHERE account_id = ? AND user_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, accountId);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error verifying account ownership: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteUserAccount(int accountId) {
        if (dbConn == null) {
            LOGGER.severe("Database connection is not available.");
            return false;
        }

        String query = "DELETE FROM user_accounts WHERE account_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, accountId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error during user account deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAccountNickname(int accountId, String nickname) {
        if (dbConn == null) {
            LOGGER.severe("Database connection is not available.");
            return false;
        }

        String query = "UPDATE user_accounts SET nickname = ? WHERE account_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, nickname);
            stmt.setInt(2, accountId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error updating account nickname: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}