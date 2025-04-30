<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SecureTrust Bank - Register</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/register.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
	<div class="container">
		<div class="branding-section">
			<div class="branding-content">
				<img
					src="${pageContext.request.contextPath}/resources/bank-logo.png"
					alt="Bank Logo" class="logo" />
				<h1>SecureTrust Bank</h1>
				<p>Create your account securely and easily.</p>
			</div>
		</div>

		<div class="register-section">
			<div class="register-box">
				<h2>Create Account</h2>

				<form action="${pageContext.request.contextPath}/register"
					method="post" enctype="multipart/form-data">


					<div class="form-grid">
						<div class="input-group">
							<label for="name"><i class="fas fa-user"></i> Full Name</label> <input
								type="text" id="name" name="name" value="${name}" required />
						</div>

						<div class="input-group">
							<label><i class="fas fa-venus-mars"></i> Sex</label><br>
							<div class="role-selection">
								<label> <input type="radio" name="sex" value="male"
									${sex == 'male' ? 'checked' : ''} required /> Male
								</label> <label> <input type="radio" name="sex" value="female"
									${sex == 'female' ? 'checked' : ''} required /> Female
								</label>
							</div>
						</div>



						<div class="input-group">
							<label for="dob"><i class="fas fa-calendar-alt"></i> Date
								of Birth</label> <input type="date" id="dob" name="dob" value="${dob}"
								required />
						</div>

						<div class="input-group">
							<label for="address"><i class="fas fa-map-marker-alt"></i>
								Address</label> <input type="text" id="address" name="address"
								value="${address}" required />
						</div>

						<div class="input-group">
							<label for="number"><i class="fas fa-phone"></i> Contact
								No.</label> <input type="tel" id="number" name="number"
								value="${number}" required />
						</div>

						<div class="input-group">
							<label for="email"><i class="fas fa-envelope"></i> Email</label>
							<input type="email" id="email" name="email" value="${email}"
								required />
						</div>

						<div class="input-group">
							<label for="password"><i class="fas fa-lock"></i>
								Password</label> <input type="password" id="password" name="password"
								required />
							<div class="password-strength"></div>
						</div>

						<div class="input-group">
							<label for="retypePassword"><i class="fas fa-lock"></i>
								Retype Password</label> <input type="password" id="retypePassword"
								name="retypePassword" required />
						</div>

						<div class="input-group">
							<label for="accountType"><i class="fas fa-building"></i>
								Account Type</label> <select id="accountType" name="accountType"
								required>
								<option value=""disabled ${emptyaccountType ? 'selected' : ''}>Select
									account type</option>
								<option value="savings"
									${accountTypeValue == 'savings' ? 'selected' : ''}>Savings
									Account</option>
								<option value="current"
									${accountTypeValue == 'current' ? 'selected' : ''}>Current
									Account</option>
								<option value="fixed-deposit"
									${accountTypeValue == 'fixed-deposit' ? 'selected' : ''}>Fixed
									Deposit</option>
								<option value="loan"
									${accountTypeValue == 'loan' ? 'selected' : ''}>Loan
									Account</option>
							</select>
						</div>




						<div class="input-group">
							<label for="balance"><i class="fas fa-wallet"></i>
								Initial Balance</label> <input type="number" id="balance" name="balance"
								value="${balance}" required />
						</div>

						<div class="input-group">
							<label for="nickname"><i class="fas fa-id-badge"></i>
								Account Nickname</label> <input type="text" id="nickname"
								name="nickname" value="${nickname}" required />
						</div>
						<div class="profile-upload-container">
							<div class="input-group">
								<label for="profileImage"><i class="fas fa-user-circle"></i>
									Profile Photo</label>
								<div class="file-upload-wrapper">
									<input type="file" id="profileImage" name="profileImage"
										accept="image/*" required /> 
								</div>
							</div>
						</div>
					</div>



					<button class="register-btn" type="submit">Register</button>

					<div class="footer-links">
						<a href="${pageContext.request.contextPath}/login">Already
							have an account? Login</a>
					</div>

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
				</form>
			</div>
		</div>
	</div>

</body>
</html>
