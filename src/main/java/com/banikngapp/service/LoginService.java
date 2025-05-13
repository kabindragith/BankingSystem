package com.banikngapp.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.UserModel;
import com.banikngapp.util.PasswordUtil;

public class LoginService {
    private Connection conn;
    private boolean isConnectionError = false;

    public LoginService() {
        try {
            this.conn = DbConfig.getDbConnection(); // ✅ initialize connection here
        } catch (Exception e) {
            isConnectionError = true;
            e.printStackTrace();
        }
    }

    public Boolean loginUser(UserModel user) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        String query = "SELECT * FROM user WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getUsername());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return validatePassword(rs, user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return false;
    }

    private boolean validatePassword(ResultSet result, UserModel user) throws SQLException {
        String dbPassword = result.getString("password");
        String dbUsername = result.getString("username");

        String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbUsername);
        if (decryptedPassword == null) {
            // Handle the error, perhaps logging or throwing a custom exception
            throw new IllegalArgumentException("Decryption failed. The password is null.");
        }


        return decryptedPassword.equals(user.getPassword());
    }

}