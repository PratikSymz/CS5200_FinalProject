DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(64) NOT NULL,
    -- last_name VARCHAR(64) NOT NULL,
    username VARCHAR(64) NOT NULL,
    password VARCHAR(15) NOT NULL,
    email VARCHAR(64) NOT NULL,
    -- date_of_birth DATE DEFAULT NULL,
    profile_picture_url VARCHAR(255) DEFAULT NULL
);
