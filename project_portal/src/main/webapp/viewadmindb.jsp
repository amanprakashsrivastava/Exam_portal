<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Signup</title>
</head>
<body>
<%@ include file="nav.jsp" %>
<%

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
    String username = "root"; // Update with your MySQL username
    String password = "aman"; // Update with your MySQL password

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to select all columns from users table
        String sql = "SELECT * FROM admins";

        // Prepare the statement
        pstmt = conn.prepareStatement(sql);
        

        // Execute the query to retrieve data
        rs = pstmt.executeQuery();
        //out.print(rs);

        // Process the result set if needed
        while (rs.next()) {
            String userEmail = rs.getString("email");
            String userPhone = rs.getString("phone");
            // You can retrieve other columns similarly
            // Handle data as required
            out.println("Email: " + userEmail + ", Phone: " + userPhone + "<br>");
        }
    } catch (ClassNotFoundException e) {
        out.println("MySQL JDBC Driver not found: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Failed to connect to database: " + e.getMessage());
    } finally {
        // Close resources in finally block
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
</body>
</html>
