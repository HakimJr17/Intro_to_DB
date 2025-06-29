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

CREATE TABLE Customers (
customer_id INT PRIMARY KEY NOT NULL,
customer_name VARCHAR(215) NOT NULL,
email VARCHAR(215) NOT NULL,
address TEXT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    );
    
CREATE TABLE Order_Details (
orderdetailid INT PRIMARY KEY,
quantity DOUBLE, 
order_id INT NOT NULL,
book_id INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES Orders(order_id), 
FOREIGN KEY (book_id) REFERENCES Books(book_id)
)