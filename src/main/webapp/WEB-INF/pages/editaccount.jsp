<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SecureBank - Edit Account</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${contextPath}/css/editaccount.css" />
    <style>
      .account-type-card.selected {
        border: 2px solid #1a73e8;
        background-color: #e8f0fe;
      }
    </style>
  </head>
  <body>
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
            <li class="nav-item">
              <a href="${contextPath}/useraccounts" class="nav-link active">Accounts</a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">Transactions</a>
            </li>
            <li class="nav-item"><a href="#" class="nav-link">Payments</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Transfers</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Tools</a></li>
          </ul>
          <div class="user-profile">
            <div class="user-avatar">${sessionScope.username != null ? sessionScope.username.substring(0, 2).toUpperCase() : 'JS'}</div>
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
          <% session.removeAttribute("message"); %>
        </div>
      </c:if>

      <div class="page-header">
        <div class="page-header-left">
          <h1>Edit Account</h1>
          <p>Update your account settings and preferences</p>
        </div>
        <div class="account-status active">
          <i class="fas fa-circle-check"></i>
          Active
        </div>
      </div>

      <form id="edit-account-form" action="${contextPath}/editaccount" method="POST">
        <input type="hidden" name="action" value="updateDetails" />
        <input type="hidden" name="user_id" value="${account.userId}" />
        <input type="hidden" name="account_id" value="${account.model.accountId}" /> <%-- Changed to access accountId from model --%>
        <input type="hidden" name="account_type_id" value="${account.accountTypeId}" />
        <div class="form-card">
          <div class="form-section">
            <h2 class="form-title">Account Summary</h2>
            <div class="account-summary">
              <div class="account-summary-item">
                <span class="account-summary-label">Account Number</span>
                <span class="account-summary-value">****${account.accountTypeId}</span>
              </div>
              <div class="account-summary-item">
                <span class="account-summary-label">Current Balance</span>
                <span class="account-summary-value balance">$<fmt:formatNumber value="${account.model.currentBalance}" pattern="#,##0.00" /></span>
              </div>
              <div class="account-summary-item">
                <span class="account-summary-label">Account Opened</span>
                <span class="account-summary-value">
                  <%-- Convert LocalDateTime to Date --%>
                  <%
                    java.time.LocalDateTime localDateTime = (java.time.LocalDateTime) ((java.util.Map) request.getAttribute("account")).get("model").getClass().getMethod("getCreatedAt").invoke(((java.util.Map) request.getAttribute("account")).get("model"));
                    java.util.Date createdAtDate = java.util.Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
                    pageContext.setAttribute("createdAtDate", createdAtDate);
                  %>
                  <fmt:formatDate value="${createdAtDate}" pattern="MMMM dd, yyyy" />
                </span>
              </div>
            </div>
          </div>

          <div class="form-section">
            <h2 class="form-title">
              1. Account Type <span class="form-title-badge">${account.accountType}</span>
            </h2>
            <div class="account-types">
              <div
                class="account-type-card ${account.accountType == 'Checking Account' ? 'selected' : ''}"
                onclick="selectAccountType(this, 'checking')"
                data-type="checking"
              >
                <div class="account-type-icon">
                  <i class="fas fa-credit-card"></i>
                </div>
                <div class="account-type-name">Checking</div>
                <div class="account-type-description">
                  Everyday banking with unlimited transactions
                </div>
              </div>

              <div
                class="account-type-card ${account.accountType == 'Savings Account' ? 'selected' : ''}"
                onclick="selectAccountType(this, 'savings')"
                data-type="savings"
              >
                <div class="account-type-icon">
                  <i class="fas fa-piggy-bank"></i>
                </div>
                <div class="account-type-name">Savings</div>
                <div class="account-type-description">
                  Earn interest on your deposits
                </div>
              </div>

              <div class="account-type-card ${account.accountType == 'Investment' ? 'selected' : ''} " data-type="investment">
                <div class="account-type-icon">
                  <i class="fas fa-chart-line"></i>
                </div>
                <div class="account-type-name">Investment</div>
                <div class="account-type-description">
                  Contact a financial advisor to open
                </div>
              </div>
            </div>

            <input
              type="hidden"
              name="accountType"
              id="accountType"
              value="${account.accountType == 'Checking Account' ? 'checking' : 'savings'}"
            />
            <span class="form-helper"
              >Changing account types may affect fees, features, and interest rates</span>
          </div>

          <div class="form-section">
            <h2 class="form-title">2. Account Details</h2>

            <div class="form-group">
              <label for="accountNickname">Account Nickname</label>
              <input
                type="text"
                class="form-control"
                id="accountNickname"
                name="accountNickname"
                value="${account.model.nickname}"
              />
              <span class="form-helper"
                >Choose a name that helps you identify this account</span>
            </div>

            <div class="form-group">
              <label for="currentBalance">Current Balance</label>
              <input
                type="number"
                class="form-control"
                id="currentBalance"
                name="currentBalance"
                value="${account.model.currentBalance}"
                step="0.01"
              />
              <span class="form-helper"
                >Edit the current balance of your account</span>
            </div>

            <div class="form-group">
              <label>Debit Card Options</label>
              <div class="form-check">
                <input
                  type="checkbox"
                  id="debitCardActive"
                  class="form-check-input"
                  checked
                  disabled
                />
                <label for="debitCardActive">Keep debit card active</label>
              </div>
              <div class="form-check">
                <input
                  type="checkbox"
                  id="internationalAccess"
                  class="form-check-input"
                  checked
                  disabled
                />
                <label for="internationalAccess">Allow international transactions</label>
              </div>
              <div class="form-check">
                <input
                  type="checkbox"
                  id="onlineTransactions"
                  class="form-check-input"
                  checked
                  disabled
                />
                <label for="onlineTransactions">Allow online transactions</label>
              </div>
            </div>

            <div class="form-group">
              <div class="form-check">
                <input
                  type="checkbox"
                  id="paperlessStatements"
                  class="form-check-input"
                  checked
                  disabled
                />
                <label for="paperlessStatements">Sign up for paperless statements</label>
              </div>
              <div class="form-check">
                <input
                  type="checkbox"
                  id="textAlerts"
                  class="form-check-input"
                  checked
                  disabled
                />
                <label for="textAlerts">Receive text alerts for large transactions</label>
              </div>
            </div>
          </div>
        </div>

        <div class="form-actions">
          <button
            type="button"
            class="btn btn-danger-outline"
            id="closeAccountBtn"
          >
            Close Account
          </button>
          <div class="form-actions-right">
            <button
              type="button"
              class="btn btn-outline"
              onclick="history.back()"
            >
              Cancel
            </button>
            <button type="submit" class="btn" id="submitBtn">
              Save Changes
            </button>
          </div>
        </div>
      </form>
    </main>

    <div class="modal-overlay" id="closeAccountModal">
      <div class="modal">
        <div class="modal-header">
          <h3 class="modal-title">Close Account</h3>
          <button class="modal-close" id="modalCloseBtn">×</button>
        </div>
        <div class="modal-body">
          <p>
            Are you sure you want to close this account? This action cannot be undone.
          </p>
          <p>
            Your current balance of <strong>$<fmt:formatNumber value="${account.model.currentBalance}" pattern="#,##0.00" /></strong> will be transferred to your linked account.
          </p>
          <form id="closeAccountForm" action="${contextPath}/editaccount" method="POST">
            <input type="hidden" name="action" value="closeAccount" />
            <input type="hidden" name="user_id" value="${account.userId}" />
            <input type="hidden" name="account_id" value="${account.model.accountId}" /> <%-- Changed to access accountId from model --%>
            <input type="hidden" name="account_type_id" value="${account.accountTypeId}" />
            <div class="form-group" style="margin-top: 1rem">
              <label for="closeReason">Please tell us why you're closing this account:</label>
              <select
                class="form-control form-select"
                id="closeReason"
                name="closeReason"
              >
                <option value="">Please select a reason</option>
                <option value="fees">Account fees</option>
                <option value="service">Customer service issues</option>
                <option value="moving">Moving to another bank</option>
                <option value="relocating">Relocating</option>
                <option value="other">Other</option>
              </select>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline" id="cancelCloseBtn">Cancel</button>
              <button type="submit" class="btn btn-danger" id="confirmCloseBtn">
                Close Account
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3>SecureBank</h3>
          <p>
            Your trusted partner for secure and innovative banking solutions.
            Building a better financial future together.
          </p>
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
          <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a> |
          <a href="#">Security</a>
        </p>
      </div>
    </footer>

    <script>
      document.addEventListener('DOMContentLoaded', function () {
        // Function to select account type
        function selectAccountType(element, type) {
          if (element.classList.contains('disabled')) return;
          document.querySelectorAll('.account-type-card').forEach(card => {
            card.classList.remove('selected');
          });
          element.classList.add('selected');
          document.getElementById('accountType').value = type;
          console.log('Selected account type: ' + type); // Debug log
        }

        // Attach event listeners to account type cards
        document.querySelectorAll('.account-type-card:not(.disabled)').forEach(card => {
          card.addEventListener('click', function () {
            selectAccountType(this, this.getAttribute('data-type'));
          });
        });

        // Initial selection based on current account type
        const initialType = '${account.accountType}'.toLowerCase() === 'checking' ? 'checking' : 'savings';
        document.querySelector(`.account-type-card[data-type="${initialType}"]`).classList.add('selected');
        document.getElementById('accountType').value = initialType;

        // Modal handling
        const closeAccountBtn = document.getElementById('closeAccountBtn');
        const closeAccountModal = document.getElementById('closeAccountModal');
        const modalCloseBtn = document.getElementById('modalCloseBtn');
        const cancelCloseBtn = document.getElementById('cancelCloseBtn');

        closeAccountBtn.addEventListener('click', () => {
          closeAccountModal.style.display = 'flex';
        });

        modalCloseBtn.addEventListener('click', () => {
          closeAccountModal.style.display = 'none';
        });

        cancelCloseBtn.addEventListener('click', () => {
          closeAccountModal.style.display = 'none';
        });

        window.addEventListener('click', (event) => {
          if (event.target === closeAccountModal) {
            closeAccountModal.style.display = 'none';
          }
        });
      });
    </script>
  </body>
</html>