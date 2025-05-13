<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SecureBank - Add Account</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addaccount.css">
  </head>
  <body>
    <!-- HEADER -->
    <header class="header">
      <div class="header-content">
        <div class="logo">
          <div class="logo-icon"><i class="fas fa-landmark"></i></div>
          SecureBank
        </div>
        <button class="mobile-menu-button">
          <i class="fas fa-bars"></i>
        </button>
        <nav class="nav-menu">
          <ul class="nav-list">
            <li class="nav-item"><a href="#" class="nav-link">Dashboard</a></li>
            <li class="nav-item"><a href="#" class="nav-link active">Accounts</a></li>
            <li class="nav-item">
              <a href="#" class="nav-link">Transactions</a>
            </li>
            <li class="nav-item"><a href="#" class="nav-link">Payments</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Transfers</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Tools</a></li>
          </ul>
          <div class="user-profile">
            <div class="user-avatar">JS</div>
            <span class="user-name">John Smith</span>
            <i class="fas fa-chevron-down user-dropdown"></i>
          </div>
        </nav>
      </div>
    </header>

    <!-- MAIN CONTENT -->
    <main class="container">
      <div class="page-header">
        <h1>Add New Account</h1>
        <p>Set up a new banking account to help manage your finances</p>
      </div>

      <form id="add-account-form" action="addaccount" method="POST">

        <div class="form-card">
          <div class="form-section">
            <h2 class="form-title">1. Select Account Type</h2>
            <div class="account-types">
              <div class="account-type-card" onclick="selectAccountType(this, 'Checking Account')">
                <div class="account-type-icon">
                  <i class="fas fa-credit-card"></i>
                </div>
                <div class="account-type-name">Checking</div>
                <div class="account-type-description">Everyday banking with unlimited transactions</div>
              </div>
              
              <div class="account-type-card" onclick="selectAccountType(this, 'Savings Account')">
                <div class="account-type-icon">
                  <i class="fas fa-piggy-bank"></i>
                </div>
                <div class="account-type-name">Savings</div>
                <div class="account-type-description">Earn interest on your deposits</div>
              </div>
              
              <div class="account-type-card" onclick="selectAccountType(this, 'Investment')">
                <div class="account-type-icon">
                  <i class="fas fa-chart-line"></i>
                </div>
                <div class="account-type-name">Investment</div>
                <div class="account-type-description">Grow your wealth through investments</div>
              </div>
            </div>

            <input type="hidden" name="accountType" id="accountType" value="">
          </div>

          <div class="form-section">
            <h2 class="form-title">2. Account Details</h2>
                      
            <div class="form-group">
              <label for="accountNickname">Account Nickname</label>
              <input type="text" class="form-control" id="accountNickname" name="nickname" placeholder="e.g. My Checking Account">
              <span class="form-helper">Choose a name that helps you identify this account</span>
            </div>

            <div class="form-group">
              <label for="initialBalance">Initial Deposit Amount</label>
              <div class="prepend-icon">
                <input type="number" class="form-control" id="initialBalance" name="initialBalance" placeholder="0.00" min="0" step="0.01">
                <i class="fas fa-dollar-sign"></i>
              </div>
              <span class="form-helper">Enter the amount you want to deposit to open this account</span>
            </div>
            
            <div class="form-group">
              <label>Would you like a physical debit card?</label>
              <div class="form-check">
                <input type="radio" name="debitCard" id="debitCardYes" class="form-check-input" value="yes">
                <label for="debitCardYes">Yes, send me a debit card</label>
              </div>
              <div class="form-check">
                <input type="radio" name="debitCard" id="debitCardNo" class="form-check-input" value="no" checked>
                <label for="debitCardNo">No, I don't need a debit card</label>
              </div>
            </div>
            
            <div class="form-group">
              <div class="form-check">
                <input type="checkbox" id="paperlessStatements" name="paperlessStatements" class="form-check-input" checked>
                <label for="paperlessStatements">Sign up for paperless statements</label>
              </div>
            </div>
          </div>
        </div>

        <div class="form-actions">
          <button type="button" class="btn btn-outline" onclick="history.back()">Cancel</button>
          <button type="submit" class="btn" id="submitBtn">Create Account</button>
        </div>
      </form>
    </main>

    <!-- FOOTER -->
    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3>SecureBank</h3>
          <p>Your trusted partner for secure and innovative banking solutions. Building a better financial future together.</p>
          <div class="social-links">
            <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
          </div>
        </div>
        <div class="footer-section">
          <h3>Quick Links</h3>
          <ul class="footer-links">
            <li><a href="#">About Us</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="#">Locations</a></li>
            <li><a href="#">Careers</a></li>
            <li><a href="#">Community</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h3>Products</h3>
          <ul class="footer-links">
            <li><a href="#">Checking Accounts</a></li>
            <li><a href="#">Savings Accounts</a></li>
            <li><a href="#">Credit Cards</a></li>
            <li><a href="#">Loans</a></li>
            <li><a href="#">Investments</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h3>Support</h3>
          <ul class="footer-links">
            <li><a href="#">Help Center</a></li>
            <li><a href="#">Report Fraud</a></li>
            <li><a href="#">Security</a></li>
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Terms of Service</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <p>© 2025 SecureBank. All rights reserved.</p>
        <p>
          <a href="#">Privacy Policy</a> |
          <a href="#">Terms of Service</a> |
          <a href="#">Security</a>
        </p>
      </div>
    </footer>

    <script>
      // Function to handle account type selection
      function selectAccountType(element, type) {
        // Remove selected class from all cards
        const cards = document.querySelectorAll('.account-type-card');
        cards.forEach(card => {
          card.classList.remove('selected');
        });
        
        // Add selected class to the clicked card
        element.classList.add('selected');
        
        // Set the hidden input value
        document.getElementById('accountType').value = type;
      }
      
      // Form submission handler
      document.getElementById('add-account-form').addEventListener('submit', function(event) {
        event.preventDefault();
        
        // Get form values
        const accountType = document.getElementById('accountType').value;
        const accountNickname = document.getElementById('accountNickname').value;
        const initialBalance = document.getElementById('initialBalance').value;
        
        // Validation
        if (!accountType) {
          alert('Please select an account type');
          return;
        }
        
        if (!accountNickname) {
          alert('Please enter an account nickname');
          return;
        }
        
        if (!initialBalance || parseFloat(initialBalance) < 0) {
          alert('Please enter a valid initial balance');
          return;
        }
        
        // Submit the form to the server
        this.submit();
      });
    </script>
  </body>
</html>