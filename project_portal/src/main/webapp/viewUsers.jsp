<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>
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
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Registered Users</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Password</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");
                    statement = connection.createStatement();
                    String sql = "SELECT * FROM userTable";
                    resultSet = statement.executeQuery(sql);

                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String email = resultSet.getString("email");
                        String phone = resultSet.getString("phone");
                        String password = resultSet.getString("password");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= email %></td>
                <td><%= phone %></td>
                <td><%= password %></td>
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
        </tbody>
    </table>
    <form action="adminDash.jsp" style="margin-top: 20px;">
        <input type="submit" value="Go Back" style="background-color: #28a745; color: #fff; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;">
    </form>
</body>
</html>
