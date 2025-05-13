package com.banikngapp.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class UserModel {
	private String firstName;
	private String lastName;
	private String sex;
	private LocalDate dob;
	private String number;
	private String address;
	private String email;
	private String username;
	private String password;
	private String accountType;
	private String nickname;
	private Double initialBalance;
	private Double currentBalance;
	private String imageUrl;

	/**
	 * @param username
	 */
	public UserModel(String username) {
		super();
		this.username = username;
	}

	public UserModel() {
	}

	public UserModel(String username, String password) {
		this.username = username;
		this.password = password;
	}

	/**
	 * @param firstName
	 * @param lastName
	 * @param sex
	 * @param dob
	 * @param number
	 * @param address
	 * @param email
	 * @param username
	 * @param password
	 * @param imageUrl
	 */
	public UserModel(String firstName, String lastName, String sex, LocalDate dob, String number, String address,
			String email, String username, String password, String imageUrl) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.sex = sex;
		this.dob = dob;
		this.number = number;
		this.address = address;
		this.email = email;
		this.username = username;
		this.password = password;
		this.imageUrl = imageUrl;
	}

	/**
	 * @param firstName
	 * @param lastName
	 * @param sex
	 * @param dob
	 * @param number
	 * @param address
	 * @param email
	 * @param username
	 * @param password
	 * @param accountType
	 * @param nickname
	 * @param initialBalance
	 * @param currentBalance
	 * @param imageUrl
	 * @param createdAt
	 */
	public UserModel(String firstName, String lastName, String sex, LocalDate dob, String number, String address,
			String email, String username, String password, String accountType, String nickname, Double initialBalance,
			Double currentBalance, String imageUrl) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.sex = sex;
		this.dob = dob;
		this.number = number;
		this.address = address;
		this.email = email;
		this.username = username;
		this.password = password;
		this.accountType = accountType;
		this.nickname = nickname;
		this.initialBalance = initialBalance;
		this.currentBalance = currentBalance;
		this.imageUrl = imageUrl;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public LocalDate getDob() {
		return dob;
	}

	public void setDob(LocalDate dob) {
		this.dob = dob;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public Double getInitialBalance() {
		return initialBalance;
	}

	public void setInitialBalance(Double initialBalance) {
		this.initialBalance = initialBalance;
	}

	public Double getCurrentBalance() {
		return currentBalance;
	}

	public void setCurrentBalance(Double currentBalance) {
		this.currentBalance = currentBalance;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

}