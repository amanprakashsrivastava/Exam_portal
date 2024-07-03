@WebServlet("/AdminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");

            String sql = "SELECT * FROM question_lists";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            List<QuestionList> questionLists = new ArrayList<>();
            while (rs.next()) {
                QuestionList list = new QuestionList();
                list.setId(rs.getInt("id"));
                list.setTag(rs.getString("tag"));
                list.setNumQuestions(rs.getInt("num_questions"));
                questionLists.add(list);
            }

            request.setAttribute("questionLists", questionLists);
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
            try { if (conn != null) conn.close(); } catch (SQLException e) { }
        }
    }
}
