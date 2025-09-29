<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="movies.OfferDAO, movies.Offer, java.util.List" %>
<%
  // Protect page
  String adminUser = (String) session.getAttribute("adminUser");
  if (adminUser == null) {
    response.sendRedirect(request.getContextPath() + "/adminLogin.jsp?error=" +
            java.net.URLEncoder.encode("Please log in first", "UTF-8"));
    return;
  }

  String msg = request.getParameter("msg");
  String err = request.getParameter("err");

  List<Offer> offers = null;
  String loadError = null;
  try {
    offers = new OfferDAO().getAllOffers();
  } catch (Exception ex) { loadError = ex.getMessage(); }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Offer (Admin)</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 840px;">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="mb-0">Add Offer</h2>
    <a href="<%=request.getContextPath()%>/adminPage.jsp"
       class="btn btn-outline-secondary btn-sm">← Back to Admin Panel</a>
  </div>

  <% if (msg != null && !msg.isEmpty()) { %>
  <div class="alert alert-success"><%= msg %></div>
  <% } %>
  <% if (err != null && !err.isEmpty()) { %>
  <div class="alert alert-danger"><%= err %></div>
  <% } %>

  <!-- Add Offer Form: posts to your AddOfferServlet -->
  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <form action="<%=request.getContextPath()%>/AddOfferServlet" method="post">
        <div class="form-group">
          <label for="title">Offer Title</label>
          <input id="title" name="title" type="text" class="form-control"
                 placeholder="e.g., 20% off popcorn" required>
        </div>
        <button type="submit" class="btn btn-primary">Add Offer</button>
      </form>
    </div>
  </div>

  <h4 class="mb-3">Offers in Database</h4>

  <% if (loadError != null) { %>
  <div class="alert alert-warning">Could not load offers: <%= loadError %></div>
  <% } else { %>
  <div class="table-responsive">
    <table class="table table-striped table-bordered bg-white">
      <thead class="thead-dark">
      <tr>
        <th style="width:90px;">ID</th>
        <th>Title</th>
        <th style="width:220px;">Created</th>
        <th style="width:120px;">Action</th>
      </tr>
      </thead>
      <tbody>
      <% if (offers == null || offers.isEmpty()) { %>
      <tr><td colspan="4" class="text-center text-muted">No offers added yet.</td></tr>
      <% } else {
        for (Offer o : offers) { %>
      <tr>
        <td><%= o.getId() %></td>
        <td><%= o.getTitle() %></td>
        <td><%= o.getCreatedAt() %></td>
        <td>
          <a href="<%=request.getContextPath()%>/DeleteOfferServlet?id=<%= o.getId() %>"
             class="btn btn-danger btn-sm"
             onclick="return confirm('Delete this offer?');">Delete</a>
        </td>
      </tr>
      <%   } } %>
      </tbody>
    </table>
  </div>
  <% } %>
</div>
</body>
</html>

