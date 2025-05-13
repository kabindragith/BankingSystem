<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>SecureBank - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css" />
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
            <li class="nav-item"><a href="#" class="nav-link active">Home</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Accounts</a></li>
            <li class="nav-item">
              <a href="#" class="nav-link">Manage Accounts</a>
            </li>
            <li class="nav-item"><a href="#" class="nav-link">Loans</a></li>
            <li class="nav-item"><a href="#" class="nav-link">About Us</a></li>
            <li class="nav-item">
              <a href="#" class="nav-link">Contact Us</a>
            </li>
          </ul>
          <a href="${pageContext.request.contextPath}/register" class="cta-button">Open Account</a>
        </nav>
      </div>
    </header>

    <section class="hero">
      <div class="hero-content">
        <h1>Banking Made Simple, Secure, and Seamless</h1>
        <p>Experience the next generation of banking with SecureBank. Our innovative solutions are designed to help you manage your finances with confidence and ease.</p>
        <div class="hero-buttons">
          <a href="${pageContext.request.contextPath}/login" class="hero-btn">Get Started</a>
          <a href="#" class="hero-btn outlined">Learn More</a>
        </div>
      </div>
    </section>

    <main class="main-content">
      <div class="content-container">
        <section class="features">
          <div class="section-title">
            <h2>Why Choose SecureBank</h2>
            <p>We're committed to providing exceptional banking experiences through innovation, security, and personalized service.</p>
          </div>
          <div class="feature-grid">
            <div class="feature-card">
              <div class="feature-icon">🔒</div>
              <h3>Enhanced Security</h3>
              <p>Your security is our priority. We use state-of-the-art encryption and multi-factor authentication to keep your accounts safe.</p>
            </div>
            <div class="feature-card">
              <div class="feature-icon">📱</div>
              <h3>Mobile Banking</h3>
              <p>Bank on the go with our award-winning mobile app. Manage accounts, transfer funds, and deposit checks from anywhere.</p>
            </div>
            <div class="feature-card">
              <div class="feature-icon">💸</div>
              <h3>No Hidden Fees</h3>
              <p>We believe in transparency. Enjoy competitive rates with no hidden fees or surprise charges on your accounts.</p>
            </div>
          </div>
        </section>

        <section class="products">
          <div class="section-title">
            <h2>Our Products</h2>
            <p>Explore our range of financial products designed to meet your unique needs and goals.</p>
          </div>
          <div class="product-grid">
            <div class="product-card">
              <div class="product-image">
                <span>💳</span>
              </div>
              <div class="product-details">
                <h3>Checking Accounts</h3>
                <p>Everyday banking with no minimum balance and free online bill pay.</p>
                <a href="#" class="product-cta">Learn More <span>→</span></a>
              </div>
            </div>
            <div class="product-card">
              <div class="product-image">
                <span>💰</span>
              </div>
              <div class="product-details">
                <h3>Savings Accounts</h3>
                <p>Build your savings with competitive interest rates and zero fees.</p>
                <a href="#" class="product-cta">Learn More <span>→</span></a>
              </div>
            </div>
            <div class="product-card">
              <div class="product-image">
                <span>🏠</span>
              </div>
              <div class="product-details">
                <h3>Mortgage Loans</h3>
                <p>Competitive rates and flexible terms to help you finance your dream home.</p>
                <a href="#" class="product-cta">Learn More <span>→</span></a>
              </div>
            </div>
            <div class="product-card">
              <div class="product-image">
                <span>📊</span>
              </div>
              <div class="product-details">
                <h3>Investment Options</h3>
                <p>Grow your wealth with our diverse investment portfolio options.</p>
                <a href="#" class="product-cta">Learn More <span>→</span></a>
              </div>
            </div>
          </div>
        </section>

        <section class="testimonials">
          <div class="testimonial-container">
            <div class="section-title">
              <h2>What Our Customers Say</h2>
              <p>Don't just take our word for it. Here's what our satisfied customers have to say about their SecureBank experience.</p>
            </div>
            <div class="testimonial-grid">
              <div class="testimonial-card">
                <div class="testimonial-quote">"</div>
                <p class="testimonial-text">Switching to SecureBank was the best financial decision I've made. Their customer service is exceptional, and the online banking interface is intuitive and user-friendly.</p>
                <div class="testimonial-author">
                  <div class="author-avatar">JD</div>
                  <div class="author-info">
                    <h4>John Doe</h4>
                    <p>Customer since 2022</p>
                  </div>
                </div>
              </div>
              <div class="testimonial-card">
                <div class="testimonial-quote">"</div>
                <p class="testimonial-text">I've been with many banks over the years, but none compare to the level of personal attention and care I receive from SecureBank. They truly understand my financial needs.</p>
                <div class="testimonial-author">
                  <div class="author-avatar">JS</div>
                  <div class="author-info">
                    <h4>Jane Smith</h4>
                    <p>Customer since 2021</p>
                  </div>
                </div>
              </div>
              <div class="testimonial-card">
                <div class="testimonial-quote">"</div>
                <p class="testimonial-text">The mortgage process with SecureBank was seamless. Their team guided me every step of the way, making what could have been a stressful experience surprisingly pleasant.</p>
                <div class="testimonial-author">
                  <div class="author-avatar">RJ</div>
                  <div class="author-info">
                    <h4>Robert Johnson</h4>
                    <p>Customer since 2023</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section class="cta-section">
          <div class="cta-content">
            <h2>Ready to Experience Better Banking?</h2>
            <p>Join thousands of satisfied customers who have already made the switch to SecureBank. Opening an account takes just minutes.</p>
            <a href="#" class="cta-btn">Open an Account Today</a>
          </div>
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