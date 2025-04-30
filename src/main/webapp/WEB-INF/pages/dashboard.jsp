<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SecureTrust Bank - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
    <div class="dashboard-container">
        <!-- Header -->
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/bank-logo.png" alt="Bank Logo" class="logo" />
                <h1>Admin Panel</h1>
            </div>
            <div class="header-right">
                <div class="user-profile">
                    <img src="${pageContext.request.contextPath}/resources/profile-pictures/${admin.profileImage}" 
                         alt="Profile" class="profile-pic" />
                    <span class="username">Admin</span>
                    <i class="fas fa-chevron-down dropdown-icon"></i>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/admin/profile"><i class="fas fa-user"></i> Profile</a>
                        <a href="${pageContext.request.contextPath}/admin/settings"><i class="fas fa-cog"></i> Settings</a>
                        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="notification-count">5</span>
                </div>
            </div>
        </header>

        <!-- Sidebar Navigation -->
        <nav class="dashboard-sidebar">
            <ul class="sidebar-menu">
                <li class="active">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-home"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i>
                        <span>Manage Users</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/accounts">
                        <i class="fas fa-wallet"></i>
                        <span>Accounts</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/transactions">
                        <i class="fas fa-exchange-alt"></i>
                        <span>Transactions</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/reports">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/settings">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="dashboard-content">
            <div class="content-header">
                <h2>Admin Dashboard</h2>
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">Home</a>
                    <i class="fas fa-chevron-right"></i>
                    <span>Dashboard</span>
                </div>
            </div>

            <!-- Welcome Card -->
            <div class="welcome-card">
                <div class="welcome-content">
                    <h3>Welcome back, Admin!</h3>
                    <p>Here’s a quick overview of today’s system status.</p>
                    <div class="last-login">
                        <i class="fas fa-clock"></i>
                        Last login: Today, 9:15 AM
                    </div>
                </div>
                <div class="welcome-image">
                    <img src="${pageContext.request.contextPath}/resources/admin-welcome.png" alt="Admin Welcome" />
                </div>
            </div>

            <!-- Admin Stats -->
            <div class="quick-stats">
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(52, 152, 219, 0.1);">
                        <i class="fas fa-users" style="color: #3498db;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Total Users</h4>
                        <p>1,204</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(46, 204, 113, 0.1);">
                        <i class="fas fa-wallet" style="color: #2ecc71;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Active Accounts</h4>
                        <p>980</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(231, 76, 60, 0.1);">
                        <i class="fas fa-exchange-alt" style="color: #e74c3c;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Transactions Today</h4>
                        <p>134</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(155, 89, 182, 0.1);">
                        <i class="fas fa-bug" style="color: #9b59b6;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>System Alerts</h4>
                        <p>2</p>
                    </div>
                </div>
            </div>

            <!-- Dashboard Grid -->
            <div class="dashboard-grid">
                <!-- User Activity -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h4>Recent User Activity</h4>
                        <a href="${pageContext.request.contextPath}/admin/users" class="view-all">View All</a>
                    </div>
                    <div class="transactions-list">
                        <div class="transaction-item">
                            <div class="transaction-icon">
                                <i class="fas fa-sign-in-alt" style="color: #2ecc71;"></i>
                            </div>
                            <div class="transaction-details">
                                <div class="transaction-info">
                                    <h5>User Login - JohnDoe</h5>
                                    <p class="transaction-date">Today, 9:01 AM</p>
                                </div>
                                <div class="transaction-amount">IP: 192.168.1.15</div>
                            </div>
                        </div>
                        <div class="transaction-item">
                            <div class="transaction-icon">
                                <i class="fas fa-user-plus" style="color: #3498db;"></i>
                            </div>
                            <div class="transaction-details">
                                <div class="transaction-info">
                                    <h5>New User Registered - Alice</h5>
                                    <p class="transaction-date">Today, 8:45 AM</p>
                                </div>
                                <div class="transaction-amount">ID: #1205</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- System Reports -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h4>System Reports</h4>
                        <a href="${pageContext.request.contextPath}/admin/reports" class="view-all">Generate</a>
                    </div>
                    <div class="accounts-list">
                        <div class="account-item">
                            <div class="account-icon">
                                <i class="fas fa-chart-line" style="color: #4ca1af;"></i>
                            </div>
                            <div class="account-info">
                                <h5>Daily Report</h5>
                                <p>Transactions, Users, Revenue</p>
                            </div>
                            <div class="account-balance">Ready</div>
                        </div>
                        <div class="account-item">
                            <div class="account-icon">
                                <i class="fas fa-database" style="color: #9b59b6;"></i>
                            </div>
                            <div class="account-info">
                                <h5>Backup Status</h5>
                                <p>Last: Today, 1:00 AM</p>
                            </div>
                            <div class="account-balance">Successful</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="dashboard-footer">
            <div class="footer-content">
                <div class="footer-left">
                    <p>&copy; 2025 SecureTrust Bank Admin. All rights reserved.</p>
                </div>
                <div class="footer-right">
                    <a href="#">System Status</a>
                    <a href="#">Admin Guidelines</a>
                    <a href="#">Security</a>
                    <a href="#">Contact Support</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>
