<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SecureBank - User Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/userdashboard.css">
<style>
.message {
	padding: 1rem;
	margin: 1rem 2rem;
	border-radius: 4px;
	background-color: rgba(22, 163, 74, 0.1);
	color: var(--success-color);
	border: 1px solid var(--success-color);
	text-align: center;
}

.message.error {
	background-color: rgba(220, 38, 38, 0.1);
	color: var(--error-color);
	border-color: var(--error-color);
}

@media ( max-width : 768px) {
	.transactions-table {
		display: block;
		overflow-x: auto;
		white-space: nowrap;
	}
}

.user-avatar img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
	border: 1px solid #ddd;
}

.user-avatar {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 10px;
}

.delete-btn {
	background: none;
	border: none;
	font-size: 1.2rem;
	cursor: pointer;
	color: #dc2626;
	transition: transform 0.2s;
}

.delete-btn:hover {
	transform: scale(1.2);
}
</style>
</head>
<body>
	<aside class="sidebar">
		<div class="sidebar-header">
			<div class="logo">
				<span class="logo-icon">🏦</span> <span class="logo-text">SecureBank</span>
			</div>
		</div>
		<div class="user-profile">
			<div class="user-avatar">
				<c:choose>
					<c:when test="${not empty user and not empty user.imageUrl}">
						<img
							src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl}"
							alt="User Profile Image" />
					</c:when>
					<c:otherwise>
						<img
							src="${pageContext.request.contextPath}/resources/images/user/default-profile.png"
							alt="Default Avatar" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="user-info">
				<h4>
					<c:choose>
						<c:when test="${not empty user}">
							<c:out value="${user.firstName} ${user.lastName}" />
						</c:when>
						<c:otherwise>Guest User</c:otherwise>
					</c:choose>
				</h4>
				<p>Account Holder</p>
			</div>
		</div>
		<nav class="nav-menu">
			<div class="nav-section">
				<h5 class="nav-section-title">Main</h5>
				<ul class="nav-list">
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/userdashboard"
						class="nav-link active"> <span class="nav-link-icon">📊</span>
							<span class="nav-link-text">Dashboard</span>
					</a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">💰</span><span class="nav-link-text">Accounts</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">💸</span><span class="nav-link-text">Transactions</span></a></li>
				</ul>
			</div>
			<div class="nav-section">
				<h5 class="nav-section-title">Services</h5>
				<ul class="nav-list">
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">💳</span><span class="nav-link-text">Cards</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">🏛️</span><span class="nav-link-text">Loans</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">📈</span><span class="nav-link-text">Investments</span></a></li>
				</ul>
			</div>
			<div class="nav-section">
				<h5 class="nav-section-title">Account</h5>
				<ul class="nav-list">
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">👤</span><span class="nav-link-text">Profile</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">⚙️</span><span class="nav-link-text">Settings</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">🔒</span><span class="nav-link-text">Security</span></a></li>
				</ul>
			</div>
		</nav>
		<div class="logout-section">
			<button class="logout-btn">
				<span class="logout-icon">🚪</span><span class="logout-text">Log
					Out</span>
			</button>
		</div>
	</aside>

	<div class="main-content">
		<header class="header">
			<h1 class="page-title">User Dashboard</h1>
			<div class="header-actions">
				<div class="search-bar">
					<span class="search-icon">🔍</span> <input type="text"
						class="search-input" placeholder="Search..." />
				</div>
				<button class="notification-btn">
					🔔<span class="notification-count">3</span>
				</button>
				<button class="settings-btn">⚙️</button>
			</div>
		</header>

		<c:if test="${not empty sessionScope.message}">
			<div
				class="message ${sessionScope.messageType == 'error' ? 'error' : ''}">
				<c:out value="${sessionScope.message}" />
				<c:remove var="message" scope="session" />
				<c:remove var="messageType" scope="session" />
			</div>
		</c:if>

		<div class="dashboard-content">
			<div class="stats-grid">
				<div class="stat-card">
					<div class="stat-icon">💰</div>
					<div class="stat-info">
						<h3 class="stat-title">Total Balance</h3>
						<p class="stat-value">
							<c:choose>
								<c:when test="${totalBalance != null}">
                                $<fmt:formatNumber
										value="${totalBalance}" type="number" minFractionDigits="2"
										maxFractionDigits="2" />
								</c:when>
								<c:otherwise>$0.00</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">🏦</div>
					<div class="stat-info">
						<h3 class="stat-title">Number of Accounts</h3>
						<p class="stat-value">
							<c:out
								value="${numberOfAccounts != null ? numberOfAccounts : '0'}" />
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💵</div>
					<div class="stat-info">
						<h3 class="stat-title">Savings Balance</h3>
						<p class="stat-value">
							<c:choose>
								<c:when test="${savingsBalance != null}">
                                $<fmt:formatNumber
										value="${savingsBalance}" type="number" minFractionDigits="2"
										maxFractionDigits="2" />
								</c:when>
								<c:otherwise>$0.00</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💸</div>
					<div class="stat-info">
						<h3 class="stat-title">Checking Balance</h3>
						<p class="stat-value">
							<c:choose>
								<c:when test="${checkingBalance != null}">
                                $<fmt:formatNumber
										value="${checkingBalance}" type="number" minFractionDigits="2"
										maxFractionDigits="2" />
								</c:when>
								<c:otherwise>$0.00</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">📈</div>
					<div class="stat-info">
						<h3 class="stat-title">Investment Balance</h3>
						<p class="stat-value">
							<c:choose>
								<c:when test="${investmentBalance != null}">
                                $<fmt:formatNumber
										value="${investmentBalance}" type="number"
										minFractionDigits="2" maxFractionDigits="2" />
								</c:when>
								<c:otherwise>$0.00</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
			</div>

			<div class="card">
				<div class="card-header">
					<h2 class="card-title">My Accounts</h2>
					<div class="card-actions">
						<button class="card-action-btn active">All</button>
						<button class="card-action-btn">Savings</button>
						<button class="card-action-btn">Checking</button>
						<button class="card-action-btn">Investment</button>
					</div>
				</div>
				<div class="card-content">
					<table class="transactions-table">
						<thead>
							<tr>
								<th>Nickname</th>
								<th>Account Type</th>
								<th>Initial Balance</th>
								<th>Current Balance</th>
								<th>Created At</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty userAccounts}">
									<c:forEach var="accountEntry" items="${userAccounts}">
										<tr>
											<td><c:out
													value="${accountEntry.userAccountModel.nickname}" /></td>
											<td><c:out
													value="${accountEntry.accountModel.accountType}" /></td>
											<td>$<fmt:formatNumber
													value="${accountEntry.userAccountModel.initialBalance}"
													type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
											<td>$<fmt:formatNumber
													value="${accountEntry.userAccountModel.currentBalance}"
													type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
											<td><fmt:formatDate
													value="${accountEntry.createdAtDate}" pattern="MM/dd/yyyy" /></td>
											<td>
												<form
													action="${pageContext.request.contextPath}/userdashboard"
													method="post"
													onsubmit="return confirm('Are you sure you want to delete this account?');">
													<input type="hidden" name="action" value="deleteAccount" />
													<input type="hidden" name="account_id"
														value="${accountEntry.userAccountModel.accountId}" />
													<button type="submit" class="delete-btn">🗑️</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="no-data">No accounts found.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<footer class="footer">
			<div class="copyright">© 2025 SecureBank User Panel. All rights
				reserved.</div>
			<div class="footer-links">
				<a href="#">Privacy Policy</a> <a href="#">Terms of Service</a> <a
					href="#">Help & Support</a>
			</div>
		</footer>
	</div>

	<script>
    document.addEventListener('DOMContentLoaded', function() {
        const navLinks = document.querySelectorAll(".nav-link");
        navLinks.forEach(link => {
            link.addEventListener("click", function() {
                navLinks.forEach(item => item.classList.remove("active"));
                this.classList.add("active");
            });
        });

        const cardActionBtns = document.querySelectorAll(".card-action-btn");
        cardActionBtns.forEach(btn => {
            btn.addEventListener("click", function() {
                const parentActions = this.parentElement;
                parentActions.querySelectorAll(".card-action-btn").forEach(item => item.classList.remove("active"));
                this.classList.add("active");
            });
        });
    });
</script>
</body>
</html>