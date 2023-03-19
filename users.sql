DROP DATABASE IF EXISTS users;
CREATE DATABASE users;
USE users;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
);

INSERT INTO users (name, email, password, role) VALUES
    ('Rakesh Kumar', 'rakesh.kumar@gmail.com', '123456', 'patient'),
    ('Sunita Gupta', 'sunita.gupta@gmail.com', '123456', 'patient'),
    ('Anupama Singh', 'anupama.singh@gmail.com', '123456', 'doctor'),
    ('Rohan Mehra', 'rohan.mehta@gmail.com', '123456', 'doctor'),
    ('Yash Kokane', 'yash.kokane@gmail.com', '123456', 'admin');
