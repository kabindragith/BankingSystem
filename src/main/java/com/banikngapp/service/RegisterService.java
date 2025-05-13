package com.banikngapp.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.banikngapp.config.DbConfig;
import com.banikngapp.model.UserAccountsModel;
import com.banikngapp.model.UserModel;

/**
 * RegisterService handles the registration of new students. It manages database
 * interactions for student registration.
 */
public class RegisterService {

	private static Connection dbConn;

	/**
	 * Constructor initializes the database connection.
	 */
	public RegisterService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		} catch (SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
	}

	/**
	 * Registers a new student in the database.
	 *
	 * @param studentModel the student details to be registered
	 * @return Boolean indicating the success of the operation
	 */
	public Boolean addUser(UserModel userModel) {
		if (dbConn == null) {
			System.err.println("Database connection is not available.");
			return false;
		}

		String insertQuery = "INSERT INTO user (first_name, last_name, sex, dob, number, address, email, username, password, image_url) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {

			// Insert student details
			insertStmt.setString(1, userModel.getFirstName());
			insertStmt.setString(2, userModel.getLastName());
			insertStmt.setString(3, userModel.getSex());
			insertStmt.setDate(4, java.sql.Date.valueOf(userModel.getDob()));
			insertStmt.setString(5, userModel.getNumber());
			insertStmt.setString(6, userModel.getAddress());
			insertStmt.setString(7, userModel.getEmail());
			insertStmt.setString(8, userModel.getUsername());
			insertStmt.setString(9, userModel.getPassword());
			insertStmt.setString(10, userModel.getImageUrl());

			return insertStmt.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("Error during user registration: " + e.getMessage());
			e.printStackTrace();
			return false;
		}

	}

	public Boolean addUserAccounts(UserModel userModel) {
		if (dbConn == null) {
			System.err.println("Database connection is not available.");
			return false;
		}

		String userQuery = "SELECT user_id FROM user WHERE username=?";
		String accountQuery = "SELECT account_type_id FROM account WHERE account_type=?";
		String insertQuery = "INSERT INTO user_accounts (user_id, account_type_id, initial_balance, current_balance, nickname) "
				+ "VALUES (?, ?, ?, ?, ?)";

		try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery);
				PreparedStatement userStmt = dbConn.prepareStatement(userQuery);
				PreparedStatement accountStmt = dbConn.prepareStatement(accountQuery)) {

			// Get user_id
			userStmt.setString(1, userModel.getUsername());
			ResultSet result = userStmt.executeQuery();
			int userId = result.next() ? result.getInt("user_id") : 1;

			// Get account_id
			accountStmt.setString(1, userModel.getAccountType());
			ResultSet result1 = accountStmt.executeQuery();
			int accountId = result1.next() ? result1.getInt("account_type_id") : 1;

			// Insert into user_accounts
			insertStmt.setInt(1, userId);
			insertStmt.setInt(2, accountId);
			insertStmt.setInt(3, userId); // using userId as account_number?
			insertStmt.setDouble(4, userModel.getInitialBalance());
			insertStmt.setDouble(5, userModel.getCurrentBalance());
			insertStmt.setString(6, userModel.getNickname());

			return insertStmt.executeUpdate() > 0;

		} catch (SQLException e) {
			System.err.println("Error during user_accounts insertion: " + e.getMessage());
			e.printStackTrace();
			return false;
		}

	}

}