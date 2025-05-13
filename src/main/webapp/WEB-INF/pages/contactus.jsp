<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>SecureBank - Contact Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contactus.css">
  </head>
  <body>
    <header class="header">
      <div class="header-content">
        <div class="logo">
          <span class="logo-icon">🏦</span>
          SecureBank
        </div>
        <nav class="nav-menu">
          <ul class="nav-list">
            <li class="nav-item"><a href="#" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Accounts</a></li>
            <li class="nav-item">
              <a href="#" class="nav-link">Manage Accounts</a>
            </li>
            <li class="nav-item"><a href="#" class="nav-link">Loans</a></li>
            <li class="nav-item"><a href="#" class="nav-link">About Us</a></li>
            <li class="nav-item">
              <a href="#" class="nav-link active">Contact Us</a>
            </li>
          </ul>
          <a href="#" class="cta-button">Open Account</a>
        </nav>
      </div>
    </header>

    <main class="contact-section">
      <div class="contact-info">
        <h2>Get in Touch</h2>
        <div class="contact-methods">
          <div class="contact-method">
            <div class="contact-method-icon">📞</div>
            <div class="contact-method-details">
              <h3>Phone Support</h3>
              <p>1-800-SECURE-BANK (1-800-732-8732)</p>
              <p>Mon-Fri: 8am - 8pm EST | Sat: 9am - 5pm EST</p>
            </div>
          </div>
          <div class="contact-method">
            <div class="contact-method-icon">✉️</div>
            <div class="contact-method-details">
              <h3>Email Support</h3>
              <p>support@securebank.com</p>
              <p>Customer inquiries responded within 24 hours</p>
            </div>
          </div>
          <div class="contact-method">
            <div class="contact-method-icon">📍</div>
            <div class="contact-method-details">
              <h3>Headquarters</h3>
              <p>123 Banking Street</p>
              <p>Financial District, Business Center</p>
              <p>New York, NY 10001</p>
            </div>
          </div>
          <div class="contact-method">
            <div class="contact-method-icon">💬</div>
            <div class="contact-method-details">
              <h3>Live Chat</h3>
              <p>Available on our mobile app and website</p>
              <p>Mon-Fri: 7am - 9pm EST</p>
            </div>
          </div>
        </div>
      </div>

      <div class="contact-form">
        <h2>Send Us a Message</h2>
        <form>
          <div class="form-group">
            <label for="name">Full Name</label>
            <input
              type="text"
              id="name"
              name="name"
              required
              placeholder="Enter your full name"
            />
          </div>
          <div class="form-group">
            <label for="email">Email Address</label>
            <input
              type="email"
              id="email"
              name="email"
              required
              placeholder="Enter your email"
            />
          </div>
          <div class="form-group">
            <label for="phone">Phone Number (Optional)</label>
            <input
              type="tel"
              id="phone"
              name="phone"
              placeholder="Enter your phone number"
            />
          </div>

          <div class="form-group">
            <label for="message">Your Message</label>
            <textarea
              id="message"
              name="message"
              required
              placeholder="Type your message here..."
            ></textarea>
          </div>
          <div class="form-group">
            <button type="submit" class="submit-btn">Send Message</button>
          </div>
        </form>
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
            <a href="#" class="social-icon">📱</a>
            <a href="#" class="social-icon">📘</a>
            <a href="#" class="social-icon">🐦</a>
            <a href="#" class="social-icon">📸</a>
            <a href="#" class="social-icon">🔗</a>
          </div>
        </div>
      </div>

      <div class="footer-bottom">
        <p>&copy; 2025 SecureBank. All rights reserved.</p>
        <p>
          Privacy Policy | Terms of Service | Cookie Policy | Accessibility |
          Site Map
        </p>
      </div>
    </footer>
  </body>
</html>