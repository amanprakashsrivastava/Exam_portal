@WebServlet("/Roles")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Fetch session if exists
        if (session != null) {
            session.invalidate(); // Invalidate the session
        }
        response.sendRedirect("Roles.jsp"); // Redirect to login page
    }
}
