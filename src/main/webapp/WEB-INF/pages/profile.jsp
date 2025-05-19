<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>SecureBank - Profile</title>

  <!-- Stylesheet -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css" />

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
    .editable-profile-image {
      position: relative;
      width: 100px;
      height: 100px;
    }

    .editable-profile-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 50%;
      border: 2px solid #ccc;
    }

    .profile-image-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      opacity: 0;
      transition: 0.3s ease-in-out;
      font-size: 0.9rem;
    }

    .editable-profile-image:hover .profile-image-overlay {
      opacity: 1;
    }

    .profile-image-upload-container {
      display: flex;
      align-items: center;
      gap: 1.5rem;
      margin-bottom: 1.5rem;
    }

    .upload-btn {
      padding: 0.5rem 1rem;
      background-color: #1e88e5;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 0.9rem;
    }

    .upload-btn:hover {
      background-color: #1565c0;
    }
  </style>
</head>
<body>
  <header class="header">
    <div class="header-content">
      <div class="logo">
        <span class="logo-icon"><i class="fas fa-university"></i></span> SecureBank
      </div>
      <nav class="nav-menu">
        <ul class="nav-list">
          <li class="nav-item"><a href="#" class="nav-link">Home</a></li>
          <li class="nav-item"><a href="#" class="nav-link">Accounts</a></li>
          <li class="nav-item"><a href="#" class="nav-link">Manage Accounts</a></li>
          <li class="nav-item"><a href="#" class="nav-link">Loans</a></li>
          <li class="nav-item"><a href="#" class="nav-link">About Us</a></li>
          <li class="nav-item"><a href="#" class="nav-link">Contact Us</a></li>
        </ul>
        <div class="user-menu" style="display:flex;">
        <a>${user.firstName}        .</a>
          <div class="user-avatar">
                  <img src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl}" alt="Profile Image" style="border-radius: 50%; width: 50px; height: 50px;"/>
                  
          </div>
          
        </div>
      </nav>
    </div>
  </header>

  <main class="main-container">
    <h1 class="page-title">My Profile</h1>

    <div class="profile-container">
      <aside class="sidebar">
        <div class="profile-summary">
          <div class="profile-image">
            <c:choose>
              <c:when test="${not empty user.imageUrl}">
                <img src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl}" alt="User Image" style="border-radius: 50%; width: 80px; height: 80px;" />
              </c:when>
              <c:otherwise>
                <span style="font-size: 2rem; font-weight: bold;">
                  ${fn:substring(user.firstName, 0, 1)}${fn:substring(user.lastName, 0, 1)}
                </span>
              </c:otherwise>
            </c:choose>
          </div>
          <h2 class="profile-name">${user.firstName} ${user.lastName}</h2>
          <p class="profile-username">@${user.username}</p>
          <span class="profile-status">Verified Account</span>
        </div>

        <ul class="profile-nav">
          <li class="profile-nav-item">
            <a href="${pageContext.request.contextPath}/transactions" class="profile-nav-link">
              <span class="profile-nav-icon"><i class="fas fa-money-check-alt"></i></span> Transactions
            </a>
          </li>
          <li class="profile-nav-item">
            <a href="${pageContext.request.contextPath}/security" class="profile-nav-link">
              <span class="profile-nav-icon"><i class="fas fa-shield-alt"></i></span> Security Settings
            </a>
          </li>
          <li class="profile-nav-item">
            <a href="${pageContext.request.contextPath}/notifications" class="profile-nav-link">
              <span class="profile-nav-icon"><i class="fas fa-bell"></i></span> Notifications
            </a>
          </li>
          <li class="profile-nav-item">
            <a href="${pageContext.request.contextPath}/account-settings" class="profile-nav-link">
              <span class="profile-nav-icon"><i class="fas fa-cog"></i></span> Account Settings
            </a>
          </li>
        </ul>
      </aside>

      <div class="content-area">
        <section class="panel">
          <div class="panel-header">
            <h2 class="panel-title">Personal Information</h2>
          </div>

          <div class="panel-content">
            <form method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">
              <!-- Profile Image Upload Section -->
              <div class="profile-image-upload-container">
                <div class="editable-profile-image">
                  <img src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl}" alt="Profile Image" />
                  <div class="profile-image-overlay">Change Photo</div>
                </div>

                <div>
                  <h3 style="margin: 0;">Profile Picture</h3>
                  <p style="margin: 0; font-size: 0.9rem; color: #777;">JPG or PNG. Max 5MB</p>
                  <label for="uploadFile" class="upload-btn">Upload New Photo</label>
                  <input type="file" id="uploadFile" name="profileImage" accept="image/jpeg, image/png" style="display: none;" />
                </div>
              </div>

              <!-- Info Fields -->
              <div class="info-grid">
                <div class="info-item">
                  <label for="firstName" class="info-label">First Name</label>
                  <input type="text" id="firstName" name="first-name" class="form-input" value="${user.firstName}" />
                </div>

                <div class="info-item">
                  <label for="lastName" class="info-label">Last Name</label>
                  <input type="text" id="lastName" name="last-name" class="form-input" value="${user.lastName}" />
                </div>

                <div class="info-item">
                  <label for="username" class="info-label">Username</label>
                  <input type="text" id="username" name="username" class="form-input" value="${user.username}" readonly />
                </div>

                <div class="info-item">
                  <label for="email" class="info-label">Email Address</label>
                  <input type="email" id="email" name="email" class="form-input" value="${user.email}" />
                </div>

                <div class="info-item">
                  <label for="phone" class="info-label">Phone Number</label>
                  <input type="tel" id="phone" name="phone" class="form-input" value="${user.number}" />
                </div>

                <div class="info-item">
                  <label for="dob" class="info-label">Date of Birth</label>
                  <input type="date" id="dob" name="dob" class="form-input" value="${user.dob}" />
                </div>

                <div class="info-item">
                  <label for="gender" class="info-label">Gender</label>
                  <select id="gender" name="gender" class="form-input">
                    <option value="male" <c:if test="${user.sex == 'male'}">selected</c:if>>Male</option>
                    <option value="female" <c:if test="${user.sex == 'female'}">selected</c:if>>Female</option>
                    <option value="other" <c:if test="${user.sex == 'other'}">selected</c:if>>Other</option>
                    <option value="prefer-not-to-say" <c:if test="${user.sex == 'prefer-not-to-say'}">selected</c:if>>Prefer not to say</option>
                  </select>
                </div>

                <div class="info-item">
                  <label for="address" class="info-label">Home Address</label>
                  <input id="address" name="address" class="form-input" value="${user.address}" />
                </div>
              </div>

              <div class="panel-footer" style="margin-top: 1rem;">
                <button type="submit" class="btn">Save Changes</button>
                <a class="btn" href="${pageContext.request.contextPath}/logout" style="background-color:red;">Log Out</a>
              </div>
            </form>
          </div>
        </section>
      </div>
    </div>
  </main>
</body>
</html>
