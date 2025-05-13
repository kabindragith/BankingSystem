<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>SecureBank - Register</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/register.css" />
</head>
<body>
	<header class="header">
		<div class="header-content">
			<div class="logo">
				<span class="logo-icon">🏦</span> SecureBank
			</div>
			<nav class="nav-menu">
				<ul class="nav-list">
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/home" class="nav-link">Home</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Accounts</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Manage
							Accounts</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Loans</a></li>
					<li class="nav-item"><a href="#" class="nav-link">About Us</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Contact
							Us</a></li>
				</ul>
				<a href="${pageContext.request.contextPath}/login"
					class="cta-button">Sign in</a>
			</nav>
		</div>
	</header>

	<main class="main-container">
		<div class="register-container">
			<div class="register-header">
				<h1>Create Your Account</h1>
				<p>Fill in your information to get started with SecureBank</p>
			</div>

			<div class="steps-container">
				<div class="step-line"></div>
				<div class="step">
					<div class="step-number">1</div>
					<div class="step-title">Personal Info</div>
				</div>
				<div class="step">
					<div class="step-number">2</div>
					<div class="step-title">Account Setup</div>
				</div>
				<div class="step">
					<div class="step-number">3</div>
					<div class="step-title">Verification</div>
				</div>
				<div class="step">
					<div class="step-number">4</div>
					<div class="step-title">Completion</div>
				</div>
			</div>

			<form action="${pageContext.request.contextPath}/register"
					method="post" enctype="multipart/form-data" id="register-form">
					
					<%
					String error = (String) request.getAttribute("error");
					if (error != null) {
					%>
					<p style="color: red;"><%=error%></p>
					<%
					}
					%>
					<%
					String success = (String) request.getAttribute("success");
					if (success != null) {
					%>
					<p style="color: green;"><%=success%></p>
					<%
					}
					%>
					
				<div class="form-grid">
					<!-- Personal Information -->
					<div class="form-group">
						<label for="first-name">First Name</label> <input type="text"
							id="first-name" name="first-name" class="form-input"
							placeholder="Enter your first name" required />
					</div>

					<div class="form-group">
						<label for="last-name">Last Name</label> <input type="text"
							id="last-name" name="last-name" class="form-input"
							placeholder="Enter your last name" required />
					</div>

					<div class="form-group">
						<label>Gender</label>
						<div class="radio-group">
							<div class="radio-option">
								<input type="radio" id="male" name="gender" value="male"
									required /> <label for="male">Male</label>
							</div>
							<div class="radio-option">
								<input type="radio" id="female" name="gender" value="female" />
								<label for="female">Female</label>
							</div>
							<div class="radio-option">
								<input type="radio" id="other" name="gender" value="other" /> <label
									for="other">Other</label>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="dob">Date of Birth</label> <input type="date" id="dob" name="dob"
							class="form-input" required />
					</div>

					<div class="form-group">
						<label for="phone">Phone Number</label> <input type="tel"
							id="phone" class="form-input" name="phone"
							placeholder="Enter your phone number" required />
					</div>

					<div class="form-group">
						<label for="address">Address</label> <input type="text"
							id="address" class="form-input" name="address"
							placeholder="Enter your full address" required />
					</div>

					<div class="form-group">
						<label for="email">Email Address</label> <input type="email"
							id="email" class="form-input" name="email"
							placeholder="Enter your email address" required />
					</div>

					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							id="username" class="form-input" name="username" placeholder="Choose a username"
							required />
					</div>

					<div class="form-group">
						<label for="password">Password</label>
						<div class="password-toggle">
							<input type="password" id="password" name="password" class="form-input"
								placeholder="Create a password" required /> <span
								class="password-toggle-icon">👁️</span>
						</div>
					</div>

					<div class="form-group">
						<label for="retype-password">Retype Password</label>
						<div class="password-toggle">
							<input type="password" id="retype-password" class="form-input"
								placeholder="Confirm your password" name="rpassword" required />
							<span class="password-toggle-icon">👁️</span>
						</div>
					</div>

					<div class="form-group">
						<label for="account-type">Bank Account Type</label> <select
							id="account-type" class="account-type-select" name="account-type" required>
							<option value="" disabled selected>Select account type</option>
							<option value="savings">Savings Account</option>
							<option value="checking">Checking Account</option>
							<option value="business">Business Account</option>
							<option value="student">Student Account</option>
						</select>
					</div>

					<div class="form-group">
						<label for="initial-balance">Initial Balance ($)</label> <input
							type="number" id="initial-balance" class="form-input" name="initial-balance"
							placeholder="Minimum $100" min="100" step="0.01" required />
					</div>
					
					<div class="form-group">
						<label for="nickname">Account Nick Name</label> <input type="text"
							id="nickname" class="form-input" name="nickname" placeholder="Choose a username"
							required />
					</div>

					<div class="form-group">
						<label for="profile-picture">Upload Profile Picture</label> <input
							type="file" id="profile-picture" class="form-input" name="profileImage"
							accept="image/*" /> <span class="file-input-label">Supported
							formats: JPG, PNG. Max size: 5MB</span>
					</div>

					<div class="form-group full-width">
						<div class="terms-checkbox">
							<input type="checkbox" id="terms" required /> <label for="terms">
								I agree to the SecureBank <a href="#"
								style="color: var(--secondary-color)">Terms
									of Service</a> and <a href="#"
								style="color: var(--secondary-color)">Privacy
									Policy</a>. I also confirm that all information provided is
								accurate.
							</label>
						</div>
					</div>

					<div class="form-group full-width">
						<button type="submit" class="btn">Create Account</button>
					</div>
				</div>

				<div class="login-link">
					Already have an account? <a
						href="${pageContext.request.contextPath}/login">Sign In</a>
				</div>
			</form>
		</div>

		<div class="security-note">
			<i>🔒</i> Your information is protected with bank-level security and
			encryption
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

	<script>
      // Toggle password visibility
      document.querySelectorAll(".password-toggle-icon").forEach((icon) => {
        icon.addEventListener("click", function () {
          const passwordInput = this.previousElementSibling;
          if (passwordInput.type === "password") {
            passwordInput.type = "text";
            this.textContent = "🔒";
          } else {
            passwordInput.type = "password";
            this.textContent = "👁️";
          }
        });
      });
    </script>
</body>
</html>