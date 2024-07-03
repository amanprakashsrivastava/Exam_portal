<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Final Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .button-container {
            text-align: center;
        }
        .button-container input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .button-container input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
    <h1>Final Results</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Language</th>
            <th>Total Questions</th>
            <th>Correct Answers</th>
            <th>Percentage</th>
            <th>Timestamp</th>
        </tr>
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");
                statement = connection.createStatement();
                String sql = "SELECT * FROM final_results";
                resultSet = statement.executeQuery(sql);
                out.print(sql);

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String userId = resultSet.getString("user_id");
                    String lang = resultSet.getString("language");
                    int totalQuestions = resultSet.getInt("total_questions");
                    int correctAnswers = resultSet.getInt("correct_answers");
                    double percentage = resultSet.getDouble("percentage");
                    Timestamp timestamp = resultSet.getTimestamp("timestamp");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= userId %></td>
            <td><%= lang %></td>
            <td><%= totalQuestions %></td>
            <td><%= correctAnswers %></td>
            <td><%= String.format("%.2f", percentage) %></td>
            <td><%= timestamp %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
    <div class="button-container">
        <form action="adminDash.jsp">
            <input type="submit" value="Go Back">
        </form>
    </div>
</body>
</html>
