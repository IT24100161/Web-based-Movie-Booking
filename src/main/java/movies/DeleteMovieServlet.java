package movies;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/DeleteMovieServlet")
public class DeleteMovieServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        MovieDAO dao = new MovieDAO();

        if (idParam != null && dao.deleteMovie(Integer.parseInt(idParam))) {
            response.sendRedirect("addMovie.jsp?msg=" + URLEncoder.encode("Movie deleted successfully!", "UTF-8"));
        } else {
            response.sendRedirect("addMovie.jsp?err=" + URLEncoder.encode("Failed to delete movie.", "UTF-8"));
        }
    }
}
