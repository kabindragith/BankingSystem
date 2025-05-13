<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>SecureBank - About Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutus.css">
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
            <li class="nav-item">
              <a href="#" class="nav-link active">About Us</a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">Contact Us</a>
            </li>
          </ul>
          <a href="#" class="cta-button">Open Account</a>
        </nav>
      </div>
    </header>

    <section class="about-hero">
      <h1>Our Story, Our Commitment</h1>
      <p>
        Founded with a vision to transform banking, SecureBank has been
        dedicated to providing innovative, secure, and customer-centric
        financial solutions since our inception.
      </p>
    </section>

    <main class="main-content">
      <div class="content-container">
        <section class="mission-section">
          <div class="mission-image">🌉</div>
          <div class="mission-content">
            <h2>Our Mission</h2>
            <p>
              At SecureBank, we believe that banking should be more than just
              transactions. It's about building lasting relationships,
              empowering our customers, and contributing to their financial
              success.
            </p>
            <p>
              Our mission is to provide cutting-edge financial services that are
              accessible, transparent, and tailored to the unique needs of each
              individual and business we serve.
            </p>
          </div>
        </section>

        <section class="team-section">
          <h2>Meet Our Leadership Team</h2>
          <div class="team-grid">
            <div class="team-member">
              <div class="team-avatar">EC</div>
              <h3>Emily Chen</h3>
              <p>Chief Executive Officer</p>
            </div>
            <div class="team-member">
              <div class="team-avatar">MR</div>
              <h3>Michael Rodriguez</h3>
              <p>Chief Financial Officer</p>
            </div>
            <div class="team-member">
              <div class="team-avatar">LK</div>
              <h3>Lisa Kim</h3>
              <p>Chief Technology Officer</p>
            </div>
            <div class="team-member">
              <div class="team-avatar">DW</div>
              <h3>David Wong</h3>
              <p>Chief Operations Officer</p>
            </div>
          </div>
        </section>

        <section class="mission-section">
          <div class="mission-content">
            <h2>Our Values</h2>
            <p>
              We are guided by four core principles that define our approach to
              banking:
            </p>
            <ul class="values-list">
              <li>
                <strong>Integrity:</strong> We maintain the highest standards of
                ethical conduct.
              </li>
              <li>
                <strong>Innovation:</strong> We continuously evolve to meet
                changing financial needs.
              </li>
              <li>
                <strong>Customer-First:</strong> Your financial well-being is
                our top priority.
              </li>
              <li>
                <strong>Community:</strong> We are committed to making a
                positive impact.
              </li>
            </ul>
          </div>
          <div class="mission-image">🤝</div>
        </section>
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