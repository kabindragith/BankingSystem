package com.banikngapp.service;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.AccountModel;
import com.banikngapp.model.UserModel;
import com.banikngapp.model.UserAccountsModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDashboardService {

    private static Connection dbConn;

    public AdminDashboardService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

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

    public List<Map<String, Object>> getAllUserAccounts() {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return new ArrayList<>();
        }

        List<Map<String, Object>> userAccounts = new ArrayList<>();
        String selectQuery = "SELECT ua.user_id, ua.account_id, ua.initial_balance, ua.current_balance, " +
                            "ua.created_at, ua.nickname, u.first_name, u.last_name, a.account_type " +
                            "FROM user_accounts ua " +
                            "JOIN user u ON ua.user_id = u.user_id " +
                            "JOIN account a ON ua.account_type_id = a.account_type_id";

        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                UserAccountsModel userAccount = new UserAccountsModel();
                userAccount.setUserId(rs.getInt("user_id"));
                userAccount.setAccountId(rs.getInt("account_id"));
                userAccount.setInitialBalance(rs.getDouble("initial_balance"));
                userAccount.setCurrentBalance(rs.getDouble("current_balance"));
                userAccount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                userAccount.setNickname(rs.getString("nickname"));
                Map<String, Object> userAccountMap = new HashMap<>();
                userAccountMap.put("model", userAccount);
                userAccountMap.put("userId", rs.getString("user_id"));
                userAccountMap.put("accountId", rs.getString("account_id"));
                userAccountMap.put("userName", rs.getString("first_name") + " " + rs.getString("last_name"));
                userAccountMap.put("accountType", rs.getString("account_type"));
                userAccounts.add(userAccountMap);
            }
        } catch (SQLException e) {
            System.err.println("Error during user accounts retrieval: " + e.getMessage());
            e.printStackTrace();
        }

        return userAccounts;
    }

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        // Total Users
        String userCountQuery = "SELECT COUNT(*) AS total FROM user";
        try (PreparedStatement stmt = dbConn.prepareStatement(userCountQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("totalUsers", rs.getInt("total"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total users: " + e.getMessage());
            stats.put("totalUsers", 0);
        }

        // Total User Accounts
        String accountCountQuery = "SELECT COUNT(*) AS total FROM user_accounts";
        try (PreparedStatement stmt = dbConn.prepareStatement(accountCountQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("totalUserAccounts", rs.getInt("total"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total user accounts: " + e.getMessage());
            stats.put("totalUserAccounts", 0);
        }

        // User with Most Balance
        String maxBalanceQuery = "SELECT u.user_id, u.first_name, u.last_name, ua.current_balance " +
                               "FROM user u JOIN user_accounts ua ON u.user_id = ua.user_id " +
                               "WHERE ua.current_balance = (SELECT MAX(current_balance) FROM user_accounts)";
        try (PreparedStatement stmt = dbConn.prepareStatement(maxBalanceQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                Map<String, Object> userBalance = new HashMap<>();
                userBalance.put("name", rs.getString("first_name") + " " + rs.getString("last_name"));
                userBalance.put("balance", rs.getDouble("current_balance"));
                stats.put("userWithMostBalance", userBalance);
            } else {
                stats.put("userWithMostBalance", null);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user with most balance: " + e.getMessage());
            stats.put("userWithMostBalance", null);
        }

        // Total Balance
        String totalBalanceQuery = "SELECT SUM(current_balance) AS total FROM user_accounts";
        try (PreparedStatement stmt = dbConn.prepareStatement(totalBalanceQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("totalBalance", rs.getDouble("total"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total balance: " + e.getMessage());
            stats.put("totalBalance", 0.0);
        }

        // Savings Accounts
        String savingsAccountsQuery = "SELECT COUNT(*) AS total FROM user_accounts ua " +
                                     "JOIN account a ON ua.account_type_id = a.account_type_id " +
                                     "WHERE TRIM(LOWER(a.account_type)) = 'savings account'";
        try (PreparedStatement stmt = dbConn.prepareStatement(savingsAccountsQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt("total");
                stats.put("savingsAccounts", count);
                System.out.println("Savings accounts count: " + count);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching savings accounts count: " + e.getMessage());
            e.printStackTrace();
            stats.put("savingsAccounts", 0);
        }

        // Debug: Log all account types and their IDs
        String debugAccountTypesQuery = "SELECT account_type_id, account_type FROM account";
        try (PreparedStatement stmt = dbConn.prepareStatement(debugAccountTypesQuery);
             ResultSet rs = stmt.executeQuery()) {
            System.out.println("Available account types:");
            while (rs.next()) {
                System.out.println("- account_type_id: " + rs.getString("account_type_id") +
                                  ", account_type: '" + rs.getString("account_type") + "'");
            }
        } catch (SQLException e) {
            System.err.println("Error fetching account types debug info: " + e.getMessage());
        }

        // Debug: Log user_accounts and their corresponding account types
        String debugJoinQuery = "SELECT ua.account_id, a.account_type " +
                              "FROM user_accounts ua " +
                              "LEFT JOIN account a ON ua.account_type_id = a.account_type_id";
        try (PreparedStatement stmt = dbConn.prepareStatement(debugJoinQuery);
             ResultSet rs = stmt.executeQuery()) {
            System.out.println("User accounts and their account types:");
            while (rs.next()) {
                System.out.println("- account_id: " + rs.getString("account_id") +
                                  ", account_type: '" + rs.getString("account_type") + "'");
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user accounts debug info: " + e.getMessage());
        }

        return stats;
    }

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

    public Boolean deleteUser(String userId) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String deleteQuery = "DELETE FROM user WHERE user_id = ?";
        String deleteQuery2 = "DELETE FROM user_accounts WHERE user_id = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery);
             PreparedStatement stmt2 = dbConn.prepareStatement(deleteQuery2)) {
            stmt.setString(1, userId);
            stmt2.setString(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during user deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

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