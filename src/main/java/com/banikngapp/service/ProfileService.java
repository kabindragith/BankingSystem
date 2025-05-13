package com.banikngapp.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.UserModel;
import com.banikngapp.util.PasswordUtil;

public class ProfileService {
    private Connection conn;
    private boolean isConnectionError = false;

    public ProfileService() {
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
        String dbPassword = result.getString("Password");
        String dbEmail = result.getString("Email");

        String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbEmail);

        return decryptedPassword.equals(user.getPassword());
    }
    public UserModel getUserDetails(String username) {
        if (isConnectionError) {
            System.out.println("Database connection error. Unable to fetch user details.");
            return null;
        }

        String query = "SELECT first_name, last_name, sex, dob, number, address, email, username, password, image_url FROM user WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                UserModel user = new UserModel();
                user.setFirstName(result.getString("first_name"));
                user.setLastName(result.getString("last_name"));
                user.setSex(result.getString("sex"));
                user.setDob(result.getDate("dob").toLocalDate());
                user.setNumber(result.getString("number"));
                user.setAddress(result.getString("address"));
                user.setEmail(result.getString("email"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setImageUrl(result.getString("image_url"));;

                return user;
            } else {
                System.out.println("No user details found for username: " + username);
            }
        } catch (SQLException e) {
            System.out.println("Database error while fetching user details: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }
    public Boolean updateUser(UserModel user) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        } else {
            System.out.println("Database connection is established.");
        }

        String updateQuery = "UPDATE user SET first_name=?, last_name=?, sex=?, dob=?, number=?, address=?, email=?, username=?, image_url=? WHERE username = ?";

        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, user.getFirstName());
            updateStmt.setString(2, user.getLastName());
            updateStmt.setString(3, user.getSex());
            updateStmt.setDate(4, Date.valueOf(user.getDob()));
            updateStmt.setString(5, user.getNumber());
            updateStmt.setString(6, user.getAddress());
            updateStmt.setString(7, user.getEmail());
            updateStmt.setString(8, user.getUsername());
           

            updateStmt.setString(9, user.getImageUrl());
            updateStmt.setString(10, user.getUsername());


            return updateStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during user update: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

			
		}