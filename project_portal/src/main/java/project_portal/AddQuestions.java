import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import your.package.Question;
@WebServlet("/AddQuestions")
public class AddQuestionsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int listId = Integer.parseInt(request.getParameter("listId"));
        int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");

            String sql = "INSERT INTO questions (list_id, question, option1, option2, option3, option4, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            for (int i = 1; i <= numQuestions; i++) {
                pstmt.setInt(1, listId);
                pstmt.setString(2, request.getParameter("question-" + i));
                pstmt.setString(3, request.getParameter("option1-" + i));
                pstmt.setString(4, request.getParameter("option2-" + i));
                pstmt.setString(5, request.getParameter("option3-" + i));
                pstmt.setString(6, request.getParameter("option4-" + i));
                pstmt.setString(7, request.getParameter("correct-" + i));
                pstmt.addBatch();
            }

            pstmt.executeBatch();
            response.sendRedirect("AdminDashboard");

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
            try { if (conn != null) conn.close(); } catch (SQLException e) { }
        }
    }
}
