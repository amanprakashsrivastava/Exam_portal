<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        /* Same CSS as provided */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            color: #333;
        }
        .btn, .submit-btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn:hover, .submit-btn:hover {
            background-color: #45a049;
        }
        form {
            display: block;
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"], input[type="tel"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
    <div class="container">
        <h2>Admin Login</h2>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
            String dbUsername = "root"; // Update with your MySQL username
            String dbPassword = "aman"; // Update with your MySQL password

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Retrieve form parameters
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String ADMid = request.getParameter("ADMid");

                // Check if ADMid matches
                if (!"adm12345".equals(ADMid)) {
                    out.println("<p>Invalid ADMid.</p>");
                } else {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish the connection
                    conn = DriverManager.getConnection(url, dbUsername, dbPassword);

                    // SQL query to check if the user exists
                    String sql = "SELECT * FROM admins WHERE email = ? AND password = ?";
                    
                    // Prepare the statement for execution
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);

                    // Execute the query
                    rs = pstmt.executeQuery();

                    // Check if a record was found
                    if (rs.next()) {
                        out.println("<p>Login successful. Welcome, " + username + "!</p>");
                        %>
                        <form action="adminDash.jsp">
                            <input type="submit" class="submit-btn" value="Go to Dashboard">
                        </form>
                        <%
                    } else {
                        out.println("<p>Invalid username or password.</p>");
                        %>
                        <form action="RolesAdmin.jsp">
                            <input type="submit" class="submit-btn" value="Go Back">
                        </form>
                        <%
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources in finally block
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
