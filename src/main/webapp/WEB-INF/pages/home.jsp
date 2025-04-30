<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SecureTrust Bank - Home</title>
    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/home.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
    <div class="dashboard-container">
        <!-- Header -->
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/bank-logo.png" alt="Bank Logo" class="logo" />
                <h1>SecureTrust Bank</h1>
            </div>
            <div class="header-right">
                <div class="user-profile">
                    <img src="${pageContext.request.contextPath}/resources/profile-pictures/${user.profileImage}" 
                         alt="Profile" class="profile-pic" />
                    <span class="username">User</span>
                    <i class="fas fa-chevron-down dropdown-icon"></i>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a>
                        <a href="${pageContext.request.contextPath}/settings"><i class="fas fa-cog"></i> Settings</a>
                        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="notification-count">3</span>
                </div>
            </div>
        </header>

        <!-- Sidebar Navigation -->
        <nav class="dashboard-sidebar">
            <ul class="sidebar-menu">
                <li class="active">
                    <a href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-home"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/accounts">
                        <i class="fas fa-wallet"></i>
                        <span>Accounts</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/transactions">
                        <i class="fas fa-exchange-alt"></i>
                        <span>Transactions</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/transfer">
                        <i class="fas fa-paper-plane"></i>
                        <span>Send Money</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/profile">
                        <i class="fas fa-user"></i>
                        <span>Profile</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/support">
                        <i class="fas fa-headset"></i>
                        <span>Support</span>
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="dashboard-content">
            <div class="content-header">
                <h2>Dashboard</h2>
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/dashboard">Home</a>
                    <i class="fas fa-chevron-right"></i>
                    <span>Dashboard</span>
                </div>
            </div>

            <!-- Welcome Card -->
            <div class="welcome-card">
                <div class="welcome-content">
                    <h3>Welcome back, User!</h3>
                    <p>Here's what's happening with your accounts today.</p>
                    <div class="last-login">
                        <i class="fas fa-clock"></i>
                        Last login:
                    </div>
                </div>
                <div class="welcome-image">
                    <img src="${pageContext.request.contextPath}/resources/dashboard-welcome.png" alt="Welcome" />
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="quick-stats">
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(76, 161, 175, 0.1);">
                        <i class="fas fa-wallet" style="color: #4ca1af;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Total Balance</h4>
                        <p>$7593450</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(52, 152, 219, 0.1);">
                        <i class="fas fa-exchange-alt" style="color: #3498db;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Transactions</h4>
                        <p>69</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(46, 204, 113, 0.1);">
                        <i class="fas fa-piggy-bank" style="color: #2ecc71;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Savings</h4>
                        <p>$89000</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: rgba(231, 76, 60, 0.1);">
                        <i class="fas fa-credit-card" style="color: #e74c3c;"></i>
                    </div>
                    <div class="stat-info">
                        <h4>Due Payments</h4>
                        <p>0</p>
                    </div>
                </div>
            </div>

            <!-- Dashboard Grid -->
            <div class="dashboard-grid">
                <!-- Recent Transactions -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h4>Recent Transactions</h4>
                        <a href="${pageContext.request.contextPath}/transactions" class="view-all">View All</a>
                    </div>
                    <div class="transactions-list">
                        <div class="transaction-item">
                            <div class="transaction-icon">
                                <i class="fas fa-arrow-down" style="color: #2ecc71;"></i>
                            </div>
                            <div class="transaction-details">
                                <div class="transaction-info">
                                    <h5>Salary Deposit</h5>
                                    <p class="transaction-date">Today, 10:45 AM</p>
                                </div>
                                <div class="transaction-amount positive">
                                    +$3,250.00
                                </div>
                            </div>
                        </div>
                        <div class="transaction-item">
                            <div class="transaction-icon">
                                <i class="fas fa-arrow-up" style="color: #e74c3c;"></i>
                            </div>
                            <div class="transaction-details">
                                <div class="transaction-info">
                                    <h5>Grocery Store</h5>
                                    <p class="transaction-date">Yesterday, 5:30 PM</p>
                                </div>
                                <div class="transaction-amount negative">
                                    -$86.45
                                </div>
                            </div>
                        </div>
                        <div class="transaction-item">
                            <div class="transaction-icon">
                                <i class="fas fa-exchange-alt" style="color: #3498db;"></i>
                            </div>
                            <div class="transaction-details">
                                <div class="transaction-info">
                                    <h5>Transfer to John</h5>
                                    <p class="transaction-date">Yesterday, 2:15 PM</p>
                                </div>
                                <div class="transaction-amount negative">
                                    -$200.00
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Accounts Summary -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h4>Your Accounts</h4>
                        <a href="${pageContext.request.contextPath}/accounts" class="view-all">View All</a>
                    </div>
                    <div class="accounts-list">
                        <div class="account-item">
                            <div class="account-icon">
                                <i class="fas fa-wallet" style="color: #4ca1af;"></i>
                            </div>
                            <div class="account-info">
                                <h5>Main Account</h5>
                                <p>•••• 4567</p>
                            </div>
                            <div class="account-balance">
                                $8,245.50
                            </div>
                        </div>
                        <div class="account-item">
                            <div class="account-icon">
                                <i class="fas fa-piggy-bank" style="color: #2ecc71;"></i>
                            </div>
                            <div class="account-info">
                                <h5>Savings</h5>
                                <p>•••• 8912</p>
                            </div>
                            <div class="account-balance">
                                $12,500.00
                            </div>
                        </div>
                        <div class="account-item">
                            <div class="account-icon">
                                <i class="fas fa-dollar-sign" style="color: #3498db;"></i>
                            </div>
                            <div class="account-info">
                                <h5>Investment</h5>
                                <p>•••• 3456</p>
                            </div>
                            <div class="account-balance">
                                $25,340.75
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="dashboard-card quick-actions">
                    <div class="card-header">
                        <h4>Quick Actions</h4>
                    </div>
                    <div class="actions-grid">
                        <a href="${pageContext.request.contextPath}/transfer" class="action-card">
                            <div class="action-icon" style="background: rgba(76, 161, 175, 0.1);">
                                <i class="fas fa-paper-plane" style="color: #4ca1af;"></i>
                            </div>
                            <h5>Send Money</h5>
                        </a>
                        <a href="#" class="action-card">
                            <div class="action-icon" style="background: rgba(46, 204, 113, 0.1);">
                                <i class="fas fa-mobile-alt" style="color: #2ecc71;"></i>
                            </div>
                            <h5>Pay Bills</h5>
                        </a>
                        <a href="#" class="action-card">
                            <div class="action-icon" style="background: rgba(155, 89, 182, 0.1);">
                                <i class="fas fa-chart-line" style="color: #9b59b6;"></i>
                            </div>
                            <h5>Investments</h5>
                        </a>
                        <a href="#" class="action-card">
                            <div class="action-icon" style="background: rgba(52, 152, 219, 0.1);">
                                <i class="fas fa-credit-card" style="color: #3498db;"></i>
                            </div>
                            <h5>Cards</h5>
                        </a>
                    </div>
                </div>

                <!-- Spending Overview -->
                <div class="dashboard-card spending-overview">
                    <div class="card-header">
                        <h4>Spending Overview</h4>
                        <div class="time-filter">
                            <select>
                                <option>This Month</option>
                                <option>Last Month</option>
                                <option>Last 3 Months</option>
                            </select>
                        </div>
                    </div>
                    <div class="spending-chart">
                        <!-- Chart would be implemented with Chart.js or similar -->
                        <div class="chart-placeholder">
                            <img src="${pageContext.request.contextPath}/resources/spending-chart.png" alt="Spending Chart" />
                        </div>
                        <div class="spending-categories">
                            <div class="category">
                                <span class="color-dot" style="background: #4ca1af;"></span>
                                <span>Food & Dining</span>
                                <span>$420.50</span>
                            </div>
                            <div class="category">
                                <span class="color-dot" style="background: #2ecc71;"></span>
                                <span>Shopping</span>
                                <span>$320.00</span>
                            </div>
                            <div class="category">
                                <span class="color-dot" style="background: #3498db;"></span>
                                <span>Transportation</span>
                                <span>$150.75</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="dashboard-footer">
            <div class="footer-content">
                <div class="footer-left">
                    <p>&copy; 2025 SecureTrust Bank. All rights reserved.</p>
                </div>
                <div class="footer-right">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Security</a>
                    <a href="#">Contact Us</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>