<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Signup</title>
</head>
<body>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
    String dbUsername = "root"; // Update with your MySQL username
    String dbPassword = "aman"; // Update with your MySQL password

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // Check if parameters are present (assuming they come from a form submission)
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // SQL query to insert into admins table
        String insertSql = "INSERT INTO admins (email, phone, password) VALUES (?, ?, ?)";
        
        // Prepare the statement for insert
        pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, email);
        pstmt.setString(2, phone);
        pstmt.setString(3, password);
        
        // Execute the insert query
        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected > 0) {
            out.println("Admin record inserted successfully!");
        } else {
            out.println("Failed to insert admin record.");
        }

    } catch (ClassNotFoundException e) {
        out.println("MySQL JDBC Driver not found: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Failed to connect to database or execute query: " + e.getMessage());
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
