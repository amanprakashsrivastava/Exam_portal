import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import your.package.Question;
@WebServlet("/AddQuestionList")
public class AddQuestionListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tag = request.getParameter("tag");
        int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");

            String sql = "INSERT INTO question_lists (tag, num_questions) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, tag);
            pstmt.setInt(2, numQuestions);
            pstmt.executeUpdate();

            response.sendRedirect("AdminDashboard");

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
            try { if (conn != null) conn.close(); } catch (SQLException e) { }
        }
    }
}
