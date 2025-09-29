<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Movies (Admin)</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Add Movie</h2>
        <a href="adminPage.jsp" class="btn btn-outline-secondary btn-sm">← Back to Admin Panel</a>
    </div>

    <!-- Flash messages -->
    <%
        String msg = request.getParameter("msg");
        String err = request.getParameter("err");
        if (msg != null && !msg.isEmpty()) {
    %>
    <div class="alert alert-success"><%= msg %></div>
    <%
        }
        if (err != null && !err.isEmpty()) {
    %>
    <div class="alert alert-danger"><%= err %></div>
    <%
        }
    %>

    <!-- Add Movie Form -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form action="AddMovieServlet" method="post">
                <div class="form-group">
                    <label for="title">Movie Title</label>
                    <input type="text" id="title" name="title" class="form-control" placeholder="Enter movie title" required>
                </div>
                <button type="submit" class="btn btn-primary">Add Movie</button>
            </form>
        </div>
    </div>

    <!-- Movies Table -->
    <h4 class="mb-3">Movies in Database</h4>

    <%
        // DB connection settings
        String url  = "jdbc:mysql://localhost:3306/movie_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String pass = "Sethmin@123";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);

            String sql = "SELECT id, title FROM movies ORDER BY id DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
    %>

    <div class="table-responsive">
        <table class="table table-striped table-bordered bg-white">
            <thead class="thead-dark">
            <tr>
                <th style="width:90px;">ID</th>
                <th>Title</th>
                <th style="width:120px;">Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasRows = false;
                while (rs.next()) {
                    hasRows = true;
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("title") %></td>
                <td>
                    <a href="DeleteMovieServlet?id=<%= rs.getInt("id") %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this movie?');">
                        Delete
                    </a>
                </td>
            </tr>
            <%
                }
                if (!hasRows) {
            %>
            <tr>
                <td colspan="3" class="text-center text-muted">No movies added yet.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <%
    } catch (Exception e) {
    %>
    <div class="alert alert-warning">Could not load movie list: <%= e.getMessage() %></div>
    <%
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignore) {}
            try { if (ps != null) ps.close(); } catch (Exception ignore) {}
            try { if (conn != null) conn.close(); } catch (Exception ignore) {}
        }
    %>

</div>
</body>
</html>
