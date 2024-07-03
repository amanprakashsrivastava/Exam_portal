<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NAVBAR</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .navbar {
            background-color: #white;
            overflow: hidden;
            padding: 10px 0;
        }
        .logout-btn {
            float: right;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 14px 20px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            font-size: 17px;
            margin: 0;
        }
        .logout-btn:hover {
            background-color: #45a049;
        }
        .navbar form {
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <form action="Roles.jsp" method="post" style="float: right;">
            <input type="submit" value="LOGOUT" class="logout-btn">
        </form>
    </div>
</body>
</html>
