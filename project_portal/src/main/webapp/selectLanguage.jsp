<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Language</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
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
        }
        select, input[type="submit"] {
            padding: 10px;
            margin: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
    <div class="container">
        <h1>Select Exam Language</h1>
        <form action="exam.jsp" method="post">
            <label for="language">Choose Language:</label>
            <select name="language" id="language">
                <option value="C Programming">C</option>
                <option value="Java">Java</option>
                <option value="Python">Python</option>
                  <option value="C++">C++</option>
            </select>
            <input type="submit" value="Start Exam">
        </form>
    </div>
</body>
</html>
