<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Portal</title>
    <style>
        /* Same CSS as provided */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
        form {
            display: none;
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        form.visible {
            display: block;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"], input[type="tel"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            color: white;
            background-color: #4CAF50;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Portal</h1>
        <a href="#" class="btn" onclick="showuserSignupForm()">user Signup</a>
        <a href="#" class="btn" onclick="showuserLoginForm()">user Login</a>

        <!-- user Signup Form -->
        <form action="userdb.jsp" id="user-signup-form" class="form">
            <h2>User Signup</h2>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <input type="submit" class="submit-btn" value="Submit">
        </form>

        <!-- user Login Form -->
        <form action="userlogindb.jsp" id="user-login-form" class="form">
            <h2>User Login</h2>
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <input type="submit" class="submit-btn" value="Submit">
        </form>
    </div>

    <script>
        function showuserSignupForm() {
            document.getElementById('user-signup-form').classList.add('visible');
            document.getElementById('user-login-form').classList.remove('visible');
        }

        function showuserLoginForm() {
            document.getElementById('user-login-form').classList.add('visible');
            document.getElementById('user-signup-form').classList.remove('visible');
        }

        document.getElementById('user-signup-form').addEventListener('submit', function(event) {
            // Remove event.preventDefault() to allow form submission
            // Implement any additional logic if needed
        });

        document.getElementById('user-login-form').addEventListener('submit', function(event) {
            // Remove event.preventDefault() to allow form submission
            // Implement any additional logic if needed
            alert('user login logic will be implemented here.');
        });
    </script>
</body>
</html>
