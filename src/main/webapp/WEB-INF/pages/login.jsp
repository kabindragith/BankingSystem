<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>SecureBank - Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css"/>
</head>
<body>
	<header class="header">
		<div class="header-content">
			<div class="logo">
				<span class="logo-icon">🏦</span> SecureBank
			</div>
			<nav class="nav-menu">
				<ul class="nav-list">
					<li class="nav-item"><a href="${pageContext.request.contextPath}/home" class="nav-link">Home</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Accounts</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Manage
							Accounts</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Loans</a></li>
					<li class="nav-item"><a href="#" class="nav-link">About Us</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Contact
							Us</a></li>
				</ul>
				<a href="${pageContext.request.contextPath}/register" class="cta-button">Open Account</a>
			</nav>
		</div>
	</header>

	<main class="main-container">
		<div class="login-container">
			<div class="login-header">
				<h1>Welcome Back</h1>
				<p>Enter your credentials to access your account</p>
			</div>

			<form action="login" method="POST" id="login-form">

				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						id="username" name="username" class="form-input" placeholder="Enter your username" />
				</div>

				<div class="form-group">
					<label for="password">Password</label>
					<div class="password-toggle">
						<input type="password" id="password" name="password" class="form-input"
							placeholder="Enter your password" /> <span
							class="password-toggle-icon">👁️</span>
					</div>
				</div>

				<div class="remember-reset">
					<div class="remember-me">
						<input type="checkbox" id="remember" /> <label for="remember">Remember
							me</label>
					</div>
					<a href="#" class="forgot-password">Forgot Password?</a>
				</div>

				<button type="submit" class="btn">Sign In</button>

				<div class="register-link">
					Don't have an account? <a href="${pageContext.request.contextPath}/register">Register Now</a>
				</div>
			</form>
		</div>

		<div class="security-note">
			<i>🔒</i> Your connection to this site is secure and encrypted
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
			<p>&copy; 2025 SecureBank. All rights reserved.</p>
			<p>Privacy Policy | Terms of Service | Cookie Policy |
				Accessibility | Site Map</p>
		</div>
	</footer>
</body>
</html>
