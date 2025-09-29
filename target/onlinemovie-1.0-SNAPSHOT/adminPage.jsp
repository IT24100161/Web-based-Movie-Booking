<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect(request.getContextPath() + "/adminLogin.jsp?error=" +
                java.net.URLEncoder.encode("Please log in first", "UTF-8"));
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body { background:#222; color:#fff; }
        h1 { margin-top:30px; }
    </style>
</head>
<body class="text-center">
<div class="container">
    <h1>🎬 Welcome, <%= adminUser %>!</h1>
    <hr style="background:#fff;">
    <div class="mt-4">
        <a href="<%= request.getContextPath() %>/addMovie.jsp"  class="btn btn-success m-2">Add Movie</a>
        <a href="<%= request.getContextPath() %>/viewBookings.jsp" class="btn btn-primary m-2">View Bookings</a>
        <!-- ✅ Link fixed to addOffer.jsp (no “s”) -->
        <a href="<%= request.getContextPath() %>/addOffer.jsp" class="btn btn-warning m-2">Add Offers</a>
        <a href="<%= request.getContextPath() %>/logout.jsp" class="btn btn-danger m-2">Logout</a>
    </div>
</div>
</body>
</html>
