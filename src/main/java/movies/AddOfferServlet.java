package movies;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddOfferServlet")
public class AddOfferServlet extends HttpServlet {

    private static final String URL  = "jdbc:mysql://localhost:3306/movie_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "Sethmin@123"; // change if yours is different

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        if (title == null || title.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/addOffer.jsp?err=Offer+title+cannot+be+empty");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement("INSERT INTO offers (title) VALUES (?)")) {
                ps.setString(1, title.trim());
                ps.executeUpdate();
            }
            response.sendRedirect(request.getContextPath() + "/addOffer.jsp?msg=Offer+added+successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/addOffer.jsp?err=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
