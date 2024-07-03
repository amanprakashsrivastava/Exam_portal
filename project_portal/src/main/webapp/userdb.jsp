<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Signup</title>
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
            color: #666;
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
        .container form {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Signup</h1>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
            String dbUsername = "root"; // Update with your MySQL username
            String dbPassword = "aman"; // Update with your MySQL password

            // Retrieve form parameters
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String userPassword = request.getParameter("password");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the database connection
                conn = DriverManager.getConnection(url, dbUsername, dbPassword);

                // SQL query to insert user data into users table
                String sql = "INSERT INTO userTable (email, phone, password) VALUES (?, ?, ?)";
                
                // Prepare the statement for execution
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, phone);
                pstmt.setString(3, userPassword);

                // Execute the query
                int rowsAffected = pstmt.executeUpdate();

                // Check if insertion was successful
                if (rowsAffected > 0) {
                    out.println("<p>User signed up successfully!</p>");
                    out.println("<form action='RolesUser.jsp' method='post'>");
                    out.println("<input type='submit' value='Proceed'>");
                    out.println("</form>");
                } else {
                    out.println("<p>Failed to sign up user.</p>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error:</p>");
                out.println("<p>Go Back</p>");
                out.println("<form action='RolesUser.jsp' method='post'>");
                out.println("<input type='submit' value='Proceed'>");
                out.println("</form>");
                //out.print(e.getMessage());
            } finally {
                // Close resources in finally block
                try {
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
