package movies;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OfferDAO {

    // ✅ Adjust these to match your DB credentials (same as MovieDAO)
    private static final String URL  = "jdbc:mysql://localhost:3306/movie_system";
    private static final String USER = "root";
    private static final String PASS = "Sethmin@123";

    static {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); }
        catch (ClassNotFoundException e) { throw new RuntimeException(e); }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public void addOffer(String title) throws Exception {
        String sql = "INSERT INTO offers (title) VALUES (?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.executeUpdate();
        }
    }

    public List<Offer> getAllOffers() throws Exception {
        String sql = "SELECT id, title, created_at FROM offers ORDER BY created_at DESC";
        List<Offer> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Offer o = new Offer();
                o.setId(rs.getInt("id"));
                o.setTitle(rs.getString("title"));
                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) o.setCreatedAt(ts.toLocalDateTime());
                list.add(o);
            }
        }
        return list;
    }

    public void deleteOffer(int id) throws Exception {
        String sql = "DELETE FROM offers WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
