package movies;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteOfferServlet")
public class DeleteOfferServlet extends HttpServlet {

    private static final String URL  = "jdbc:mysql://localhost:3306/movie_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "Sethmin@123"; // change if needed

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/addOffer.jsp?err=Missing+offer+id");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement("DELETE FROM offers WHERE id = ?")) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }
            response.sendRedirect(request.getContextPath() + "/addOffer.jsp?msg=Offer+deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/addOffer.jsp?err=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
