<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>SecureBank - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
  </head>
  <body>
    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="sidebar-header">
        <div class="logo">
          <span class="logo-icon">🏦</span>
          <span class="logo-text">SecureBank</span>
        </div>
      </div>

      <div class="admin-profile">
        <div class="admin-avatar">👤</div>
        <div class="admin-info">
          <h4>Admin User</h4>
          <p>System Administrator</p>
        </div>
      </div>

      <nav class="nav-menu">
        <div class="nav-section">
          <h5 class="nav-section-title">Main</h5>
          <ul class="nav-list">
            <li class="nav-item">
              <a href="${pageContext.request.contextPath}/admindashboard" class="nav-link active">
                <span class="nav-link-icon">📊</span>
                <span class="nav-link-text">Dashboard</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">👥</span>
                <span class="nav-link-text">Customers</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">💰</span>
                <span class="nav-link-text">Accounts</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">💸</span>
                <span class="nav-link-text">Transactions</span>
              </a>
            </li>
          </ul>
        </div>

        <div class="nav-section">
          <h5 class="nav-section-title">Management</h5>
          <ul class="nav-list">
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">💳</span>
                <span class="nav-link-text">Cards</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">🏛️</span>
                <span class="nav-link-text">Loans</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">📝</span>
                <span class="nav-link-text">Reports</span>
              </a>
            </li>
          </ul>
        </div>

        <div class="nav-section">
          <h5 class="nav-section-title">System</h5>
          <ul class="nav-list">
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">👨‍💼</span>
                <span class="nav-link-text">Staff Users</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">⚙️</span>
                <span class="nav-link-text">Settings</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">🔒</span>
                <span class="nav-link-text">Security</span>
              </a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">
                <span class="nav-link-icon">📜</span>
                <span class="nav-link-text">Audit Logs</span>
              </a>
            </li>
          </ul>
        </div>
      </nav>

      <div class="logout-section">
        <button class="logout-btn">
          <span class="logout-icon">🚪</span>
          <span class="logout-text">Log Out</span>
        </button>
      </div>
    </aside>

    <!-- Main Content -->
    <div class="main-content">
      <!-- Header -->
      <header class="header">
        <h1 class="page-title">Admin Dashboard</h1>
        <div class="header-actions">
          <div class="search-bar">
            <span class="search-icon">🔍</span>
            <input type="text" class="search-input" placeholder="Search..." />
          </div>
          <button class="notification-btn">
            🔔
            <span class="notification-count">5</span>
          </button>
          <button class="settings-btn">⚙️</button>
        </div>
      </header>

      <!-- Message Display -->
      <c:if test="${not empty sessionScope.message}">
        <div class="message">
          <c:out value="${sessionScope.message}" />
          <% session.removeAttribute("message"); %>
        </div>
      </c:if>

      <!-- Dashboard Content -->
      <div class="dashboard-content">
        <!-- Accounts Table -->
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
                <c:forEach var="account" items="${accounts}">
                  <tr>
                    <td class="transaction-id"><c:out value="${account.accountTypeId}" /></td>
                    <td><c:out value="${account.model.accountType}" /></td>
                    <td><c:out value="${account.model.interestRate}" />%</td>
                    <td><c:out value="${account.model.description}" /></td>
                    <td>
                      <form action="${pageContext.request.contextPath}/admindashboard" method="post">
                        <input type="hidden" name="action" value="deleteAccount" />
                        <input type="hidden" name="account_type_id" value="${account.accountTypeId}" />
                        <button type="submit" class="delete-btn">🗑️</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty accounts}">
                  <tr>
                    <td colspan="5">No account types found.</td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Users Table -->
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
                <c:forEach var="user" items="${users}">
                  <tr>
                    <td class="transaction-id"><c:out value="${user.userId}" /></td>
                    <td><c:out value="${user.model.firstName} ${user.model.lastName}" /></td>
                    <td><c:out value="${user.model.email}" /></td>
                    <td><c:out value="${user.model.number}" /></td>
                    <td><c:out value="${user.model.username}" /></td>
                    <td>
                      <form action="${pageContext.request.contextPath}/admindashboard" method="post">
                        <input type="hidden" name="action" value="deleteUser" />
                        <input type="hidden" name="user_id" value="${user.userId}" />
                        <button type="submit" class="delete-btn">🗑️</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty users}">
                  <tr>
                    <td colspan="6">No users found.</td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <!-- User Accounts Table -->
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
                <c:forEach var="userAccount" items="${userAccounts}">
                  <tr>
                    <td class="transaction-id"><c:out value="${userAccount.userId}" /></td>
                    <td class="transaction-id"><c:out value="${userAccount.accountId}" /></td>
                    <td>$<c:out value="${userAccount.model.currentBalance}" /></td>
                    <td><c:out value="${userAccount.model.nickname}" /></td>
                    <td>
                      <form action="${pageContext.request.contextPath}/admindashboard" method="post">
                        <input type="hidden" name="action" value="deleteUserAccount" />
                        <input type="hidden" name="user_id" value="${userAccount.userId}" />
                        <input type="hidden" name="account_id" value="${userAccount.accountId}" />
                        <button type="submit" class="delete-btn">🗑️</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty userAccounts}">
                  <tr>
                    <td colspan="5">No user accounts found.</td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <footer class="footer">
        <div class="copyright">
          © 2025 SecureBank Admin Panel. All rights reserved.
        </div>
        <div class="footer-links">
          <a href="#">Privacy Policy</a>
          <a href="#">Terms of Service</a>
          <a href="#">Help & Support</a>
        </div>
      </footer>
    </div>

    <script>
      // Toggle active class on sidebar navigation links
      const navLinks = document.querySelectorAll(".nav-link");
      navLinks.forEach((link) => {
        link.addEventListener("click", function () {
          navLinks.forEach((item) => item.classList.remove("active"));
          this.classList.add("active");
        });
      });

      // Card action buttons functionality
      const cardActionBtns = document.querySelectorAll(".card-action-btn");
      cardActionBtns.forEach((btn) => {
        btn.addEventListener("click", function () {
          const parentActions = this.parentElement;
          parentActions.querySelectorAll(".card-action-btn").forEach((item) => {
            item.classList.remove("active");
          });
          this.classList.add("active");
        });
      });

      // Add confirmation for delete actions
      document.querySelectorAll('.delete-btn').forEach(btn => {
          btn.addEventListener('click', (e) => {
              if (!confirm('Are you sure you want to delete this record?')) {
                  e.preventDefault();
              }
          });
      });
    </script>
  </body>
</html>