<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Now Showing - Movie Schedule</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Roboto', sans-serif;
      color: white;
      text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
    }

    body {
      background-image: url('https://nativespeaker.vn/uploaded/page_1601_1712215670_1713753865.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding-top: 100px;
    }

    .admin-btn {
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 1000;
    }

    .offers-btn {
      position: fixed;
      top: 20px;
      left: 20px;
      z-index: 1000;
    }

    .movie-box {
      background-color: rgba(0, 0, 0, 0.6);
      padding: 30px;
      border-radius: 15px;
      width: 80%;
      max-width: 600px;
      text-align: center;
    }

    .list-group-item {
      background-color: rgba(255, 255, 255, 0.85);
      color: black;
      font-weight: bold;
    }
  </style>
</head>
<body>

<!-- View Offers button -->
<div class="offers-btn">
  <a href="<%= request.getContextPath() %>/viewOffers.jsp" class="btn btn-info">View Offers</a>
</div>

<!-- Admin Panel button -->
<div class="admin-btn">
  <a href="<%= request.getContextPath() %>/adminLogin.jsp" class="btn btn-danger">Admin Panel</a>
</div>

<div class="movie-box">
  <h1>🎬 Now Showing</h1>
  <ul class="list-group">
    <%
      String jdbcURL = "jdbc:mysql://localhost:3306/movie_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
      String dbUser = "root";
      String dbPassword = "Sethmin@123"; // your DB password

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT title FROM movies ORDER BY id DESC")) {

          boolean any = false;
          while (rs.next()) {
            any = true;
            String title = rs.getString("title");
    %>
    <li class="list-group-item"><%= title %></li>
    <%
      }
      if (!any) {
    %>
    <li class="list-group-item text-muted">No movies available.</li>
    <%
        }
      }
    } catch (Exception e) {
    %>
    <li class="list-group-item text-danger">Error: <%= e.getMessage() %></li>
    <%
      }
    %>
  </ul>
</div>

</body>
</html>
