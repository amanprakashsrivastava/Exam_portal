<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .question-container {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .question-container h2 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .question-container label {
            display: block;
            margin-bottom: 10px;
        }
        .submit-button {
            text-align: center;
            margin-top: 20px;
        }
        .submit-button input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #28a745;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .submit-button input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <%
        HttpSession currentSession = request.getSession(false);
        String username = (String) currentSession.getAttribute("username");
        if (username == null) {
            response.sendRedirect("RolesUser.jsp"); // Redirect to login if session not found
        }
    %>
    <div class="container">
        <h1>Welcome, <%= username %>!</h1>
        <form action="submitAssessment.jsp" method="post">
            <input type="hidden" name="language" value="<%= request.getParameter("language") %>">
            <% 
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            List<Map<String, String>> questions = new ArrayList<>();
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");
                String sql = "SELECT * FROM questions WHERE tag = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, request.getParameter("language"));    
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    Map<String, String> question = new HashMap<>();
                    question.put("id", resultSet.getString("id"));
                    question.put("question", resultSet.getString("question"));
                    question.put("option1", resultSet.getString("option1"));
                    question.put("option2", resultSet.getString("option2"));
                    question.put("option3", resultSet.getString("option3"));
                    question.put("option4", resultSet.getString("option4"));
                    questions.add(question);
            %>
            <div class="question-container">
                <h2><%= question.get("question") %></h2>
                <label><input type="radio" name="answer<%= question.get("id") %>" value="option1"> <%= question.get("option1") %></label><br>
                <label><input type="radio" name="answer<%= question.get("id") %>" value="option2"> <%= question.get("option2") %></label><br>
                <label><input type="radio" name="answer<%= question.get("id") %>" value="option3"> <%= question.get("option3") %></label><br>
                <label><input type="radio" name="answer<%= question.get("id") %>" value="option4"> <%= question.get("option4") %></label><br>
            </div>
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
            <div class="submit-button">
                <input type="submit" value="Submit Assessment">
            </div>
        </form>
    </div>
</body>
</html>
