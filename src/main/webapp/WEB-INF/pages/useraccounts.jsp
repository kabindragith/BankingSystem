<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecureBank - My Accounts</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<link rel="stylesheet" href="${contextPath}/css/useraccounts.css" />
<style>
.user-avatar-img {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	object-fit: cover;
	margin-right: 0.75rem;
}
</style>
</head>
<body>
	<header class="header">
		<div class="header-content">
			<div class="logo">
				<div class="logo-icon">
					<i class="fas fa-landmark"></i>
				</div>
				SecureBank
			</div>
			<button class="mobile-menu-button">
				<i class="fas fa-bars"></i>
			</button>
			<nav class="nav-menu">
				<ul class="nav-list">
					<li class="nav-item"><a href="#" class="nav-link">Dashboard</a></li>
					<li class="nav-item"><a href="${contextPath}/useraccounts"
						class="nav-link active">Accounts</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Transactions</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Payments</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Transfers</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Tools</a></li>
				</ul>
				<div class="user-profile">
					<c:choose>
						<c:when test="${not empty userImageUrl}">
							<img src="${contextPath}/resources/images/user/${userImageUrl}"
								alt="User Profile" class="user-avatar-img" />
						</c:when>
						<c:otherwise>
							<div class="user-avatar">${sessionScope.username != null ? sessionScope.username.substring(0, 2).toUpperCase() : 'JS'}</div>
						</c:otherwise>
					</c:choose>
					<span class="user-name">${sessionScope.username != null ? sessionScope.username : 'John Smith'}</span>
					<i class="fas fa-chevron-down user-dropdown"></i>
				</div>
			</nav>
		</div>
	</header>

	<main class="container">
		<c:if test="${not empty sessionScope.message}">
			<div class="message">
				<c:out value="${sessionScope.message}" />
				<%
				session.removeAttribute("message");
				%>
			</div>
		</c:if>

		<div class="page-header">
			<div class="page-header-left">
				<h1>My Accounts</h1>
				<p>View and manage all your bank accounts in one place</p>
			</div>
			<div class="page-header-right">
				<a href="${contextPath}/add-account" class="btn"> <i
					class="fas fa-plus"></i> Add New Account
				</a>
			</div>
		</div>


		<div class="account-summary-card">
			<div class="summary-header">
				<div class="summary-title">Financial Overview</div>
			</div>
			<div class="summary-stats">
				<div class="stat-card">
					<div class="stat-icon">💰</div>
					<div class="stat-label">Total Balance</div>
					<div class="stat-value">
						<c:if test="${totalBalance != null}">
                    $<fmt:formatNumber value="${totalBalance}"
								type="number" minFractionDigits="2" maxFractionDigits="2" />
						</c:if>
						<c:if test="${totalBalance == null}">
                    $0.00
                </c:if>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">🏦</div>
					<div class="stat-label"># of Accounts</div>
					<div class="stat-value">${numberOfAccounts}</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💵</div>
					<div class="stat-label">Savings Balance</div>
					<div class="stat-value">
						<c:if test="${savingsBalance != null}">
                    $<fmt:formatNumber value="${savingsBalance}"
								type="number" minFractionDigits="2" maxFractionDigits="2" />
						</c:if>
						<c:if test="${savingsBalance == null}">
                    $0.00
                </c:if>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">💸</div>
					<div class="stat-label">Checking Balance</div>
					<div class="stat-value">
						<c:if test="${checkingBalance != null}">
                    $<fmt:formatNumber value="${checkingBalance}"
								type="number" minFractionDigits="2" maxFractionDigits="2" />
						</c:if>
						<c:if test="${checkingBalance == null}">
                    $0.00
                </c:if>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">📈</div>
					<div class="stat-label">Investment Balance</div>
					<div class="stat-value">
						<c:if test="${investmentBalance != null}">
                    $<fmt:formatNumber value="${investmentBalance}"
								type="number" minFractionDigits="2" maxFractionDigits="2" />
						</c:if>
						<c:if test="${investmentBalance == null}">
                    $0.00
                </c:if>
					</div>
				</div>
				<c:if test="${not empty highestValueAccount}">
					<div class="stat-card">
						<div class="stat-label">Highest Value Account</div>
						<div class="stat-value">
							$
							<fmt:formatNumber
								value="${highestValueAccount.model.currentBalance}"
								type="number" minFractionDigits="2" maxFractionDigits="2" />
						</div>
						<div class="stat-label" style="font-size: 0.75rem;">(${highestValueAccount.model.nickname})</div>
					</div>
				</c:if>
			</div>
		</div>

		<div class="accounts-table-card">
			<div class="table-header">
				<div class="table-title">All Accounts</div>
				<div class="table-actions">
					<select class="table-filter" id="accountTypeFilter">
						<option value="all">All Types</option>
						<option value="checking">Checking</option>
						<option value="savings">Savings</option>
						<option value="investment">Investment</option>
						<option value="credit">Credit Card</option>
					</select> <select class="table-filter" id="accountStatusFilter">
						<option value="all">All Statuses</option>
						<option value="active">Active</option>
						<option value="inactive">Inactive</option>
						<option value="pending">Pending</option>
					</select>
				</div>
			</div>

			<div class="accounts-wrapper">
				<table>
					<thead>
						<tr>
							<th class="sortable">Account Name</th>
							<th class="sortable">Account ID</th>
							<th>Account Type</th>
							<th class="sortable sort-desc">Balance</th>
							<th>Status</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="accountEntry" items="${accountList}">
							<tr>
								<td><c:out value="${accountEntry.model.nickname}" /></td>
								<td><c:out value="${accountEntry.accountTypeId}" /></td>
								<td><c:out value="${accountEntry.accountType}" /></td>
								<td>$<fmt:formatNumber
										value="${accountEntry.model.currentBalance}"
										pattern="#,##0.00" /></td>
								<td>Active</td>
								<td>
									<div class="action-buttons">
										<form action="${contextPath}/useraccounts" method="post"
											style="display: inline;">
											<input type="hidden" name="action" value="deleteUserAccount" />
											<input type="hidden" name="user_id"
												value="${accountEntry.userId}" />
											<input type="hidden" name="account_type_id" value="${accountEntry.accountTypeId}" />
											<button type="submit" class="action-btn"
												title="Delete Account"
												onclick="return confirm('Are you sure you want to delete this account?');">
												<i class="fas fa-trash"></i>
											</button>
										</form>
										<a
											href="${contextPath}/editaccount?user_id=${accountEntry.userId}&account_id=${accountEntry.model.accountId}"
											class="action-btn" title="Manage Account"> <i
											class="fas fa-edit"></i>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty accountList}">
							<tr>
								<td colspan="6">No accounts found.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</main>

	<footer class="footer">
		<div class="footer-content">
			<div class="footer-section">
				<h3>Quick Links</h3>
				<ul class="footer-links">
					<li><a href="#">Home</a></li>
					<li><a href="#">Online Banking</a></li>
					<li><a href="#">Accounts</a></li>
					<li><a href="#">Credit Cards</a></li>
					<li><a href="#">Mortgages</a></li>
				</ul>
			</div>

			<div class="footer-section">
				<h3>Resources</h3>
				<ul class="footer-links">
					<li><a href="#">Help Center</a></li>
					<li><a href="#">Security Tips</a></li>
					<li><a href="#">Financial Tools</a></li>
					<li><a href="#">Rates & Fees</a></li>
					<li><a href="#">FAQs</a></li>
				</ul>
			</div>

			<div class="footer-section">
				<h3>About Us</h3>
				<ul class="footer-links">
					<li><a href="#">Our Story</a></li>
					<li><a href="#">Careers</a></li>
					<li><a href="#">Press Room</a></li>
					<li><a href="#">Community Involvement</a></li>
					<li><a href="#">Locations</a></li>
				</ul>
			</div>

			<div class="footer-section">
				<h3>Contact Us</h3>
				<ul class="footer-links">
					<li>1-800-SECURE-BANK</li>
					<li>support@securebank.com</li>
					<li>123 Banking Street, Financial District</li>
				</ul>
				<div class="social-links">
					<a href="#" class="social-icon">📱</a> <a href="#"
						class="social-icon">📘</a> <a href="#" class="social-icon">🐦</a>
					<a href="#" class="social-icon">📸</a> <a href="#"
						class="social-icon">🔗</a>
				</div>
			</div>
		</div>

		<div class="footer-bottom">
			<p>© 2025 SecureBank. All rights reserved.</p>
			<p>Privacy Policy | Terms of Service | Cookie Policy |
				Accessibility | Site Map</p>
		</div>
	</footer>

	<script>
      // Toggle mobile menu
      const mobileMenuButton = document.querySelector('.mobile-menu-button');
      const navMenu = document.querySelector('.nav-menu');
      mobileMenuButton.addEventListener('click', () => {
        navMenu.classList.toggle('active');
      });

      // Sorting functionality
      document.querySelectorAll('.sortable').forEach(header => {
        header.addEventListener('click', () => {
          const table = header.closest('table');
          const index = Array.from(header.parentElement.children).indexOf(header);
          const isAscending = !header.classList.contains('sort-asc');

          Array.from(table.querySelectorAll('tbody tr')).sort((a, b) => {
            const aText = a.children[index].textContent.trim();
            const bText = b.children[index].textContent.trim();
            return isAscending
              ? aText.localeCompare(bText, undefined, {numeric: true})
              : bText.localeCompare(aText, undefined, {numeric: true});
          }).forEach(row => table.querySelector('tbody').appendChild(row));

          document.querySelectorAll('.sortable').forEach(h => {
            h.classList.remove('sort-asc', 'sort-desc');
          });
          header.classList.add(isAscending ? 'sort-asc' : 'sort-desc');
        });
      });
    </script>
</body>
</html>