<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Current Offers</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    /* Make offers readable against white background */
    .list-group-item {
      background-color: rgba(255, 255, 255, 0.95);
      color: #000;
      font-weight: 600;
    }
  </style>
</head>
<body class="bg-dark text-white">
<div class="container mt-4">
  <h2>🎁 Current Offers</h2>

  <%
    // DB connection
    String url  = "jdbc:mysql://localhost:3306/movie_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String user = "root";
    String pass = "Sethmin@123";

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      try (Connection conn = DriverManager.getConnection(url, user, pass);
           PreparedStatement ps = conn.prepareStatement("SELECT title FROM offers ORDER BY id DESC");
           ResultSet rs = ps.executeQuery()) {
  %>

  <ul class="list-group">
    <%
      boolean any = false;
      while (rs.next()) {
        any = true;
        String title = rs.getString("title");
    %>
    <li class="list-group-item"><%= title != null ? title : "No Title" %></li>
    <%
      }
      if (!any) {
    %>
    <li class="list-group-item text-muted">No offers available right now. Please check back later.</li>
    <%
      }
    %>
  </ul>

  <%
    }
  } catch (Exception e) {
  %>
  <div class="alert alert-danger mt-3">Error loading offers: <%= e.getMessage() %></div>
  <%
    }
  %>

  <a href="movieDisplay.jsp" class="btn btn-secondary mt-3">Back to Movies</a>
</div>
</body>
</html>
