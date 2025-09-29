package movies;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    // ✅ Direct JDBC config (edit if needed)
    private static final String JDBC_URL =
            "jdbc:mysql://localhost:3306/movie_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "Sethmin@123";

    // Optional: load driver once (MySQL 8+ usually auto-loads, but this won’t hurt)
    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ignore) { /* auto-load will handle */ }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username") == null ? "" : request.getParameter("username").trim();
        String password = request.getParameter("password") == null ? "" : request.getParameter("password").trim();
        String ctx = request.getContextPath();

        if (username.isEmpty() || password.isEmpty()) {
            response.sendRedirect(ctx + "/adminLogin.jsp?error=" +
                    URLEncoder.encode("Username and password are required", "UTF-8"));
            return;
        }

        String sql = "SELECT id, username FROM admin WHERE username = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Debug (optional)
            System.out.println("[AdminLoginServlet] Connected to DB: " + conn.getCatalog());

            ps.setString(1, username);
            ps.setString(2, password); // NOTE: plaintext for now; hash in production

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("adminUser", rs.getString("username"));
                    session.setAttribute("adminId", rs.getInt("id"));
                    System.out.println("[AdminLoginServlet] ✅ Login OK for " + rs.getString("username")
                            + ", sessionId=" + session.getId());
                    response.sendRedirect(ctx + "/adminPage.jsp");
                } else {
                    System.out.println("[AdminLoginServlet] ❌ Invalid login for user=" + username);
                    response.sendRedirect(ctx + "/adminLogin.jsp?error=" +
                            URLEncoder.encode("Invalid username or password", "UTF-8"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(ctx + "/adminLogin.jsp?error=" +
                    URLEncoder.encode("DB error: " + e.getMessage(), "UTF-8"));
        }
    }
}
