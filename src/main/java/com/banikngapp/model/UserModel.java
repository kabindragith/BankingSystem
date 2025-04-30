package com.banikngapp.model;

import java.time.LocalDate;

public class UserModel{
	private String name;
	private String sex;
	private LocalDate dob;
	private String address;
	private String number;
	private String email;
	private String password;
	private String imageUrl;
	
	public UserModel() {}
	public UserModel(String email, String password) {
		this.email = email;
		this.password = password;
	}
	/**
	 * @param name
	 * @param sex
	 * @param dob
	 * @param address
	 * @param number
	 * @param email
	 * @param password
	 */
	public UserModel(String name, String sex, LocalDate dob, String address, String number, String email,
			String password, String imageUrl) {
		super();
		this.name = name;
		this.sex = sex;
		this.dob = dob;
		this.address = address;
		this.number = number;
		this.email = email;
		this.password = password;
		this.imageUrl = imageUrl;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	
	
}