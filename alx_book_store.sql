CREATE DATABASE IF NOT EXISTS alx_book_store;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255)
    );
    
CREATE TABLE Books (
book_id INT PRIMARY KEY,
title VARCHAR(130) NOT NULL,
author_id INT NOT NULL,
price DOUBLE,
publication_date DATE
);