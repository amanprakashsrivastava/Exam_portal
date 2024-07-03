<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ include file="nav.jsp" %>
<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("username") == null) {
        response.sendRedirect("RolesUser.jsp"); // Redirect to login if session or username not found
        return; // Stop further execution
    }

   // int username = (int) currentSession.getAttribute("username");
    String user_id = (String) currentSession.getAttribute("username");
    String language = request.getParameter("language");
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    int correctAnswers = 0;
    int totalQuestions = 0;
    double percentage = 0.0;
    List<Map<String, String>> results = new ArrayList<>();

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "aman");

        Enumeration<String> parameterNames = request.getParameterNames();

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("answer")) {
                String questionId = paramName.substring(6);
                String selectedOption = request.getParameter(paramName);

                // Retrieve question details from database
                String sql = "SELECT question, option1, option2, option3, option4, correctOption FROM questions WHERE id = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(questionId));
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Process each question and compare answers
                    String correctOption = resultSet.getString("correctOption");
                    String question = resultSet.getString("question");
                    String option1 = resultSet.getString("option1");
                    String option2 = resultSet.getString("option2");
                    String option3 = resultSet.getString("option3");
                    String option4 = resultSet.getString("option4");

                    // Store options in a map for easy retrieval
                    Map<String, String> optionMap = new HashMap<>();
                    optionMap.put("option1", option1);
                    optionMap.put("option2", option2);
                    optionMap.put("option3", option3);
                    optionMap.put("option4", option4);

                    // Store results for each question
                    Map<String, String> result = new HashMap<>();
                    result.put("question", question);
                    result.put("selectedOptionKey", selectedOption);
                    result.put("selectedOptionValue", optionMap.get(selectedOption));
                    result.put("correctOptionKey", correctOption);
                    result.put("correctOptionValue", correctOption); // Store the correct option value directly
                    results.add(result);

                    // Check if selected option matches correct answer
                    if (selectedOption != null && optionMap.get(selectedOption).equals(correctOption)) {
                        correctAnswers++;
                    }
                    totalQuestions++;
                }
            }
        }

        // Calculate percentage of correct answers
        if (totalQuestions > 0) {
            percentage = ((double) correctAnswers / totalQuestions) * 100;
        }

        // Insert assessment results into database
        String insertSql = "INSERT INTO final_results (user_id, language, total_questions, correct_answers, percentage) VALUES (?, ?, ?, ?, ?)";
        statement = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, user_id); // Set user_id from session as String
        statement.setString(2, language);
        statement.setInt(3, totalQuestions);
        statement.setInt(4, correctAnswers);
        statement.setDouble(5, percentage);
        statement.executeUpdate();

        // Retrieve the generated auto-increment id
        ResultSet generatedKeys = statement.getGeneratedKeys();
        int generatedId = 0;
        if (generatedKeys.next()) {
            generatedId = generatedKeys.getInt(1); // Get the auto-increment id
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        // Close resources
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assessment Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .container h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .container p {
            font-size: 18px;
            margin: 10px 0;
        }
        .result {
            text-align: left;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Assessment Results</h1>
        <p>Total Questions: <%= totalQuestions %></p>
        <p>Correct Answers: <%= correctAnswers %></p>
        <p>Percentage: <%= String.format("%.2f", percentage) %> %</p>

        <h2>Question Details</h2>
        <% for (Map<String, String> result : results) { %>
            <div class="result">
                <p><strong>Question:</strong> <%= result.get("question") %></p>
                <p><strong>Your Answer:</strong> <%= result.get("selectedOptionValue") %></p>
                <p><strong>Correct Answer:</strong> <%= result.get("correctOptionValue") %></p>
                <hr>
            </div>
        <% } %>
    </div>
</body>
</html>
