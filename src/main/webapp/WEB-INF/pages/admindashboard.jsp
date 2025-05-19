<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SecureBank - Admin Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admindashboard.css">
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

.admin-avatar img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
	border: 1px solid #ddd;
}

.admin-avatar {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 10px;
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
		<div class="admin-profile">
			<div class="admin-avatar">
				<c:choose>
					<c:when test="${not empty user and not empty user.imageUrl}">
						<img
							src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl}"
							alt="Admin Profile Image" />
					</c:when>
					<c:otherwise>
						<img
							src="${pageContext.request.contextPath}/resources/images/user/default-profile.png"
							alt="Default Avatar" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="admin-info">
				<h4>
					<c:choose>
						<c:when test="${not empty user}">
							<c:out value="${user.firstName} ${user.lastName}" />
						</c:when>
						<c:otherwise>Guest Admin</c:otherwise>
					</c:choose>
				</h4>
				<p>System Administrator</p>
			</div>
		</div>
		<nav class="nav-menu">
			<div class="nav-section">
				<h5 class="nav-section-title">Main</h5>
				<ul class="nav-list">
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/admindashboard"
						class="nav-link active"> <span class="nav-link-icon">📊</span>
							<span class="nav-link-text">Dashboard</span>
					</a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">👥</span><span class="nav-link-text">Customers</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">💰</span><span class="nav-link-text">Accounts</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">💸</span><span class="nav-link-text">Transactions</span></a></li>
				</ul>
			</div>
			<div class="nav-section">
				<h5 class="nav-section-title">Management</h5>
				<ul class="nav-list">
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">💳</span><span class="nav-link-text">Cards</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">🏛️</span><span class="nav-link-text">Loans</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">📝</span><span class="nav-link-text">Reports</span></a></li>
				</ul>
			</div>
			<div class="nav-section">
				<h5 class="nav-section-title">System</h5>
				<ul class="nav-list">
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">👨‍💼</span><span class="nav-link-text">Staff
								Users</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">⚙️</span><span class="nav-link-text">Settings</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">🔒</span><span class="nav-link-text">Security</span></a></li>
					<li class="nav-item"><a href="#" class="nav-link"><span
							class="nav-link-icon">📜</span><span class="nav-link-text">Audit
								Logs</span></a></li>
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
			<h1 class="page-title">Admin Dashboard</h1>
			<div class="header-actions">
				<div class="search-bar">
					<span class="search-icon">🔍</span> <input type="text"
						class="search-input" placeholder="Search..." />
				</div>
				<button class="notification-btn">
					🔔<span class="notification-count">5</span>
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
					<div class="stat-icon">👥</div>
					<div class="stat-info">
						<h3 class="stat-title">Total Users</h3>
						<p class="stat-value">
							<c:out value="${totalUsers != null ? totalUsers : '0'}" />
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💰</div>
					<div class="stat-info">
						<h3 class="stat-title">Total User Accounts</h3>
						<p class="stat-value">
							<c:out
								value="${totalUserAccounts != null ? totalUserAccounts : '0'}" />
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💵</div>
					<div class="stat-info">
						<h3 class="stat-title">User with Most Balance</h3>
						<p class="stat-value">
							<c:choose>
								<c:when test="${userWithMostBalance != null}">
									<c:out
										value="${userWithMostBalance.name} ($${userWithMostBalance.balance})" />
								</c:when>
								<c:otherwise>N/A</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💰</div>
					<div class="stat-info">
						<h3 class="stat-title">Total Balance</h3>
						<p class="stat-value">
							<c:choose>
								<c:when test="${totalBalance != null}">
                                    $<c:out value="${totalBalance}" />
								</c:when>
								<c:otherwise>$0.00</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">🏦</div>
					<div class="stat-info">
						<h3 class="stat-title">Savings Accounts</h3>
						<p class="stat-value">
							<c:out value="${savingsAccounts != null ? savingsAccounts : '0'}" />
						</p>
					</div>
				</div>
			</div>

			<div class="card">
				<div class="card-header">
					<h2 class="card-title">Accounts</h2>
					<div class="card-actions">
						<button class="card-action-btn">All</button>
						<button class="card-action-btn">Active</button>
						<button class="card-action-btn">Inactive</button>
					</div>
				</div>
				<div class="card-content">
					<table class="transactions-table">
						<thead>
							<tr>
								<th>Account Type ID</th>
								<th>Type</th>
								<th>Interest Rate</th>
								<th>Description</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty accounts}">
									<c:forEach var="account" items="${accounts}">
										<tr>
											<td class="transaction-id"><c:out
													value="${account.accountTypeId}" /></td>
											<td><c:out value="${account.model.accountType}" /></td>
											<td><c:out value="${account.model.interestRate}" />%</td>
											<td><c:out value="${account.model.description}" /></td>
											<td>
												<form
													action="${pageContext.request.contextPath}/admindashboard"
													method="post"
													onsubmit="return confirm('Are you sure you want to delete this account type?');">
													<input type="hidden" name="action" value="deleteAccount" />
													<input type="hidden" name="account_type_id"
														value="${account.accountTypeId}" />
													<button type="submit" class="delete-btn">🗑️</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" class="no-data">No account types found.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

			<div class="card">
				<div class="card-header">
					<h2 class="card-title">Users</h2>
					<div class="card-actions">
						<button class="card-action-btn">All</button>
						<button class="card-action-btn">Verified</button>
						<button class="card-action-btn">Pending</button>
					</div>
				</div>
				<div class="card-content">
					<table class="transactions-table">
						<thead>
							<tr>
								<th>User ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Number</th>
								<th>Username</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty users}">
									<c:forEach var="user" items="${users}">
										<tr>
											<td class="transaction-id"><c:out value="${user.userId}" /></td>
											<td><c:out
													value="${user.model.firstName} ${user.model.lastName}" /></td>
											<td><c:out value="${user.model.email}" /></td>
											<td><c:out value="${user.model.number}" /></td>
											<td><c:out value="${user.model.username}" /></td>
											<td>
												<form
													action="${pageContext.request.contextPath}/admindashboard"
													method="post"
													onsubmit="return confirm('Are you sure you want to delete this user?');">
													<input type="hidden" name="action" value="deleteUser" /> <input
														type="hidden" name="user_id" value="${user.userId}" />
													<button type="submit" class="delete-btn">🗑️</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="no-data">No users found.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

			<div class="card">
				<div class="card-header">
					<h2 class="card-title">User Accounts</h2>
					<div class="card-actions">
						<button class="card-action-btn">All</button>
						<button class="card-action-btn">Primary</button>
						<button class="card-action-btn">Joint</button>
					</div>
				</div>
				<div class="card-content">
					<table class="transactions-table">
						<thead>
							<tr>
								<th>User ID</th>
								<th>Account ID</th>
								<th>Balance</th>
								<th>Nickname</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty userAccounts}">
									<c:forEach var="userAccount" items="${userAccounts}">
										<tr>
											<td class="transaction-id"><c:out
													value="${userAccount.userId}" /></td>
											<td class="transaction-id"><c:out
													value="${userAccount.accountId}" /></td>
											<td>$<c:out value="${userAccount.model.currentBalance}" /></td>
											<td><c:out value="${userAccount.model.nickname}" /></td>
											<td>
												<form
													action="${pageContext.request.contextPath}/admindashboard"
													method="post"
													onsubmit="return confirm('Are you sure you want to delete this user account?');">
													<input type="hidden" name="action"
														value="deleteUserAccount" /> <input type="hidden"
														name="user_id" value="${userAccount.userId}" /> <input
														type="hidden" name="account_id"
														value="${userAccount.accountId}" />
													<button type="submit" class="delete-btn">🗑️</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" class="no-data">No user accounts found.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<footer class="footer">
			<div class="copyright">© 2025 SecureBank Admin Panel. All
				rights reserved.</div>
			<div class="footer-links">
				<a href="#">Privacy Policy</a> <a href="#">Terms of Service</a> <a
					href="#">Help & Support</a>
			</div>
		</footer>
	</div>

	<script>
        // DOMContentLoaded event
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