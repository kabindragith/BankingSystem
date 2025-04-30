package com.banikngapp.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.banikngapp.config.DbConfig;
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

//		String programQuery = "SELECT program_id FROM program WHERE name = ?";
		String insertQuery = "INSERT INTO user (name, sex, dob, address, number, email, password, image_url) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

//		try (PreparedStatement programStmt = dbConn.prepareStatement(programQuery);
		try(PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {

//			// Fetch program ID
//			programStmt.setString(1, studentModel.getProgram().getName());
//			ResultSet result = programStmt.executeQuery();
//			int programId = result.next() ? result.getInt("program_id") : 1;

			// Insert student details
			insertStmt.setString(1, userModel.getName());
			insertStmt.setString(2, userModel.getSex());
			insertStmt.setDate(3, java.sql.Date.valueOf(userModel.getDob()));
			insertStmt.setString(4, userModel.getAddress());
			insertStmt.setString(5, userModel.getNumber());
			insertStmt.setString(6, userModel.getEmail());
			insertStmt.setString(7, userModel.getPassword());
			insertStmt.setString(8, userModel.getImageUrl());

			return insertStmt.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("Error during user registration: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
	
	

}