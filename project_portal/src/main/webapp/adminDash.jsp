<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding-top: 50px;
        }

        h1 {
            text-align: center;
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
            text-align: center;
        }

        button {
            padding: 5px 10px;
            cursor: pointer;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        form label, form input, form button {
            margin-bottom: 10px;
        }

        form button {
            align-self: flex-start;
            padding: 5px 15px;
            cursor: pointer;
        }
    </style>
    <script>
        function openForm(language) {
            document.getElementById("formModal").style.display = "block";
            document.getElementById("tag").value = language;
        }

        function closeForm() {
            document.getElementById("formModal").style.display = "none";
            document.getElementById("questionForm").reset();
        }

        document.getElementById("questionForm").addEventListener("submit", function(event) {
            event.preventDefault();
            alert("Question added for " + document.getElementById("tag").value + " successfully!");
            closeForm();
        });
    </script>
</head>
<body>
<%@ include file="nav.jsp" %>
    <div class="container">
        <h1>Admin Dashboard</h1>
        <table>
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Language</th>
                    <th>ADD Questions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>C Programming</td>
                    <td><button onclick="openForm('C Programming')">Add</button></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Java</td>
                    <td><button onclick="openForm('Java')">Add</button></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Python</td>
                    <td><button onclick="openForm('Python')">Add</button></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>C++</td>
                    <td><button onclick="openForm('C++')">Add</button></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div id="formModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeForm()">&times;</span>
            <h2>Add Question</h2>
            <form action="AddQuestionsDB.jsp" method="post" id="questionForm">
                <label for="question">Question:</label>
                <input type="text" id="question" name="question" required>

                <label for="option1">Option 1:</label>
                <input type="text" id="option1" name="option1" required>

                <label for="option2">Option 2:</label>
                <input type="text" id="option2" name="option2" required>

                <label for="option3">Option 3:</label>
                <input type="text" id="option3" name="option3" required>

                <label for="option4">Option 4:</label>
                <input type="text" id="option4" name="option4" required>

                <label for="correctOption">Correct Option:</label>
                <input type="text" id="correctOption" name="correctOption" required>

                <label for="tag">Tag:</label>
                <input type="text" id="tag" name="tag" readonly>

                <button type="submit">Add Question</button>
            </form>
            
          <br><br><br><br><br><br><br><br><br><br>
          
          
        </div>
    </div>
    <form action="showResults.jsp">
    <input type="submit" value="View Student Performance" style="background-color: #28a745; color: #fff; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;">
</form>
<br><br><br><br><br><br>
 <form action="viewUsers.jsp" style="margin-top: 20px;">
        <input type="submit" value="View Registered Users" style="background-color: #28a745; color: #fff; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;">
    </form>

</body>
</html>
