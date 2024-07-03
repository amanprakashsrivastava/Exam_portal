<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Question</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
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
        }
        .container h1 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }
        .container label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        .container input[type="text"],
        .container input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .container input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 20px;
            font-size: 16px;
            color: #d9534f;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
    <div class="container">
        <h1>Delete Question</h1>
        <form action="delete.jsp" method="post">
            <label for="questionId">Question ID to delete:</label>
            <input type="text" id="questionId" name="questionId" required>
            <input type="submit" value="Delete Question">
        </form>
        <div class="message">
            <%
                String URL = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
                String DB_USERNAME = "root"; // Update with your MySQL Username
                String DB_PASSWORD = "aman"; // Update with your MySQL password

                String questionId = request.getParameter("questionId");

                Connection connection = null;
                PreparedStatement statement = null;

                if (questionId != null && !questionId.trim().isEmpty()) {
                    try {
                        // Load the MySQL driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Get a connection to the database
                        connection = DriverManager.getConnection(URL, DB_USERNAME, DB_PASSWORD);

                        // Prepare the SQL statement
                        String sql = "DELETE FROM questions WHERE id = ?";
                        statement = connection.prepareStatement(sql);
                        statement.setInt(1, Integer.parseInt(questionId));

                        // Execute the SQL statement
                        int rowsAffected = statement.executeUpdate();

                        if (rowsAffected > 0) {
                            out.print("Question Deleted Successfully");
                        } else {
                            out.print("No Question found with the provided ID");
                        }
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.print("Database driver not found");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.print("Database error");
                    } finally {
                        try {
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    out.print("Please provide a valid Question ID");
                }
            %>
            <form action="AddQuestionsDB.jsp">
            <input type='submit' value='Back'>
            </form>
        </div>
    </div>
</body>
</html>
