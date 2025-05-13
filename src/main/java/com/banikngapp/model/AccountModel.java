package com.banikngapp.model;

public class AccountModel {
	private String accountType;
	private Double interestRate;
	private String description;
	
	
	
	/**
	 * 
	 */
	public AccountModel() {
		super();
	}

	/**
	 * @param accountType
	 */
	public AccountModel(String accountType) {
		super();
		this.accountType = accountType;
	}

	/**
	 * @param accountType
	 * @param interestRate
	 * @param description
	 */
	public AccountModel(String accountType, Double interestRate, String description) {
		super();
		this.accountType = accountType;
		this.interestRate = interestRate;
		this.description = description;
	}
	
	public String getAccountType() {
		return accountType;
	}
	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}
	public Double getInterestRate() {
		return interestRate;
	}
	public void setInterestRate(Double interestRate) {
		this.interestRate = interestRate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	

}
