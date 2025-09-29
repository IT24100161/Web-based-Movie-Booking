package movies;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/AddMovieServlet")
public class AddMovieServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        movies.MovieDAO dao = new MovieDAO();

        if (title != null && dao.addMovie(title.trim())) {
            response.sendRedirect("addMovie.jsp?msg=" + URLEncoder.encode("Movie added successfully!", "UTF-8"));
        } else {
            response.sendRedirect("addMovie.jsp?err=" + URLEncoder.encode("Failed to add movie.", "UTF-8"));
        }
    }
}
