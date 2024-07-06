*The project starts with the page Roles.jsp*
# Exam_portal
A portal to conduct examination which can be used by admins and users both
It uses 5 databases
1.admins
2.final_results
3.questions
4.results
5.usertable

queries to create table are
create database genpact;

use genpact;
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    ADMid VARCHAR(10) NOT NULL DEFAULT 'adm12345'
);

use genpact;
CREATE TABLE final_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50),
    language VARCHAR(50),
    total_questions INT,
    correct_answers INT,
    percentage DOUBLE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

use genpact;
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option1 TEXT NOT NULL,
    option2 TEXT NOT NULL,
    option3 TEXT NOT NULL,
    option4 TEXT NOT NULL,
    correctOption TEXT NOT NULL,
    tag VARCHAR(255) NOT NULL
);

use genpact;
CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId VARCHAR(255) NOT NULL,
    questionId INT NOT NULL,
    selectedOption VARCHAR(10) NOT NULL
);

use genpact;
CREATE TABLE userTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL
);

use genpact;
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option1 TEXT NOT NULL,
    option2 TEXT NOT NULL,
    option3 TEXT NOT NULL,
    option4 TEXT NOT NULL,
    correctOption TEXT NOT NULL,
    tag VARCHAR(255) NOT NULL
);


**NOTE THAT-   IN ADMIN PAGE WHILE LOGIN AmdId will be always 'adm12345' **
