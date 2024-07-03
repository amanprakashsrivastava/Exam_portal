<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        .container h1 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }
        .container p {
            font-size: 16px;
            color: #333;
        }
        .container form {
            margin-top: 20px;
        }
        .container input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #28a745;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .container input[type="submit"]:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Login</h1>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
            String dbUsername = "root"; // Update with your MySQL Username
            String dbPassword = "aman"; // Update with your MySQL password

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Retrieve form parameters
                String Username = request.getParameter("username");
                String password = request.getParameter("password");

                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                conn = DriverManager.getConnection(url, dbUsername, dbPassword);

                // SQL query to check if the User exists
                String sql = "SELECT * FROM userTable WHERE email = ? AND password = ?";

                // Prepare the statement for execution
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, Username);
                pstmt.setString(2, password);

                // Execute the query
                rs = pstmt.executeQuery();

                // Check if a record was found
                if (rs.next()) {
                    // Store username in session
                    session.setAttribute("username", Username);

                    out.println("<p>Login successful. Welcome, " + Username + "!</p>");
                    out.println("<form action='selectLanguage.jsp' method='post'>");
                    out.println("<input type='submit' value='Proceed'>");
                    out.println("</form>");
                } else {
                    out.println("<p class='error'>Invalid Username or password.</p>");
                    out.println("<form action='RolesUser.jsp' method='post'>");
                    out.println("<input type='submit' value='Try Again!'>");
                    out.println("</form>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources in finally block
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p class='error'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
