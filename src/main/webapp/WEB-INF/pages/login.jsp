<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SecureTrust Bank - Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
	<div class="container">
		<div class="branding-section">
			<div class="branding-content">
				<img src="${pageContext.request.contextPath}/resources/bank-logo.png" alt="Bank Logo" class="logo" />
				<h1>SecureTrust Bank</h1>
				<p>Banking made easy, secure, and smart.</p>
			</div>
		</div>

		<div class="login-section">
			<div class="login-box">
				<h2>Login to your account</h2>

				<form action="login" method="POST">
					<div class="input-group">
						<label><i class="fas fa-user-tag"></i> Login As</label><br>
						<div class="role-selection">
							<label for="user"> <input type="radio" id="user"
								name="role" value="user" required /> User
							</label> <label for="admin"> <input type="radio" id="admin"
								name="role" value="admin" /> Admin
							</label>
						</div>
					</div>

					<div class="input-group">
						<label for="username"><i class="fas fa-user"></i> Username</label>
						<input type="text" id="username" name="username" required />
					</div>

					<div class="input-group">
						<label for="password"><i class="fas fa-lock"></i> Password</label>
						<input type="password" id="password" name="password" required />
					</div>

					<button class="login-btn" type="submit">Login</button>

					<div class="footer-links">
						<a href="#">Forgot password?</a> <a href="${pageContext.request.contextPath}/register">Register</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
