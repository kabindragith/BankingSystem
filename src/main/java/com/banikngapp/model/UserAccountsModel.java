package com.banikngapp.model;

import java.time.LocalDateTime;

public class UserAccountsModel {
	private Double initialBalance;
	private Double currentBalance;
	private LocalDateTime createdAt;
	private int userId;
	private int accountId;
	private String nickname;
	
	
	/**
	 * 
	 */
	public UserAccountsModel() {
		super();
	}

	/**
	 * @param initialBalance
	 * @param currentBalance
	 * @param createdAt
	 * @param userId
	 * @param accountId
	 */
	public UserAccountsModel(Double initialBalance, Double currentBalance,
			LocalDateTime createdAt, int userId, int accountId, String nickname) {
		super();
		this.initialBalance = initialBalance;
		this.currentBalance = currentBalance;
		this.createdAt = createdAt;
		this.userId = userId;
		this.accountId = accountId;
		this.nickname = nickname;
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
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	
	
}
