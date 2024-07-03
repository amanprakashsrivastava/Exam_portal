<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/genpact"; // Update with your database URL including the database name
    String username = "root"; // Update with your MySQL username
    String password = "aman"; // Update with your MySQL password

    Connection connection = null;
    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        connection = DriverManager.getConnection(url, username, password);

        // Check if connection is successful
        if (connection != null) {
            out.println("Database connection to 'genpact' established successfully!");
        } else {
            out.println("Failed to connect to database!");
        }
    } catch (ClassNotFoundException e) {
        out.println("MySQL JDBC Driver not found: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Failed to connect to database: " + e.getMessage());
    } finally {
        // Close the connection
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            out.println("Error while closing the connection: " + e.getMessage());
        }
    }   
%>
