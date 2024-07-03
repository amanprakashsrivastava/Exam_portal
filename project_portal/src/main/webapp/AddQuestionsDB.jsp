<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Question</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
        }
        .container h1 {
            margin-bottom: 20px;
            font-size: 24px;
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
        .message {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
    <div class="container">
        <h1>Insert Question</h1>
        <div class="message">
            <%
                String URL = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL
                String DB_USERNAME = "root"; // Update with your MySQL Username
                String DB_PASSWORD = "aman"; // Update with your MySQL password

                String question = request.getParameter("question");
                String option1 = request.getParameter("option1");
                String option2 = request.getParameter("option2");
                String option3 = request.getParameter("option3");
                String option4 = request.getParameter("option4");
                String correctOption = request.getParameter("correctOption");
                String tag = request.getParameter("tag");

                Connection connection = null;
                PreparedStatement statement = null;

                try {
                    // Load the MySQL driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Get a connection to the database
                    connection = DriverManager.getConnection(URL, DB_USERNAME, DB_PASSWORD);

                    // Prepare the SQL statement
                    String sql = "INSERT INTO questions (question, option1, option2, option3, option4, correctOption, tag) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, question);
                    statement.setString(2, option1);
                    statement.setString(3, option2);
                    statement.setString(4, option3);
                    statement.setString(5, option4);
                    statement.setString(6, correctOption);
                    statement.setString(7, tag);

                    // Execute the SQL statement
                    statement.executeUpdate();
                    out.print("Question Inserted<br>");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.print("Database driver not found<br>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.print("Database error<br>");
                } finally {
                    try {
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
        <form action="delete.jsp" method="post">
            <p>If the question you entered is wrong,</p>
            <input type="submit" value="Delete">
        </form>

        <br><br><br>
        <form action="adminDash.jsp" method="post">
            <input type="submit" value="Back to Dashboard">
        </form>

        <h2>All Questions</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Question</th>
                <th>Option 1</th>
                <th>Option 2</th>
                <th>Option 3</th>
                <th>Option 4</th>
                <th>Correct Option</th>
                <th>Tag</th>
            </tr>
            <%
                Connection connection2 = null;
                Statement statement2 = null;
                ResultSet resultSet = null;

                try {
                    // Load the MySQL driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Get a connection to the database
                    connection2 = DriverManager.getConnection(URL, DB_USERNAME, DB_PASSWORD);

                    // Prepare the SQL statement
                    String sql = "SELECT * FROM questions";
                    statement2 = connection2.createStatement();
                    resultSet = statement2.executeQuery(sql);

                    while (resultSet.next()) {
                        %>
                        <tr>
                            <td><%= resultSet.getInt("id") %></td>
                            <td><%= resultSet.getString("question") %></td>
                            <td><%= resultSet.getString("option1") %></td>
                            <td><%= resultSet.getString("option2") %></td>
                            <td><%= resultSet.getString("option3") %></td>
                            <td><%= resultSet.getString("option4") %></td>
                            <td><%= resultSet.getString("correctOption") %></td>
                            <td><%= resultSet.getString("tag") %></td>
                        </tr>
                        <%
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement2 != null) statement2.close();
                        if (connection2 != null) connection2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
