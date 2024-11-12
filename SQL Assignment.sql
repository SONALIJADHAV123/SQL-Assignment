create database emp;
use emp;

# Q.1
CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL DEFAULT 30000
);


# Q.2
/*
Constraints are rules applied to columns in a database table to ensure the accuracy, validity, and consistency of the data stored.
They play a crucial role in maintaining data integrity by restricting the types of data that can be inserted, updated, or deleted, thereby reducing the risk of data errors and ensuring that relationships between tables are properly enforced.

Purpose of Constraints:
- Data Integrity: Constraints enforce rules to keep data accurate and consistent, so the database remains reliable.
- Data Validation: They ensure only valid data is entered into the database.
- Prevention of Duplicates: Constraints help avoid duplicate records by enforcing uniqueness where required.
- Relational Integrity: They enforce relationships between tables, ensuring that data in one table is accurately linked to data in another.

Common Types of Constraints with Examples:
- NOT NULL Constraint: Ensures that a column cannot have NULL values, requiring that each record contains a valid entry for that field.
  Example: In an employees table, a NOT NULL constraint on the emp_name column ensures that every employee has a name. 
  emp_name VARCHAR(255) NOT NULL

- UNIQUE Constraint: Ensures all values in a column are distinct, preventing duplicate entries in that column.
  Example: In an employees table, a UNIQUE constraint on the email column guarantees that each employee has a unique email address.
  email VARCHAR(255) UNIQUE

- PRIMARY KEY Constraint: Uniquely identifies each record in a table and combines NOT NULL and UNIQUE.
  Example: A primary key constraint on emp_id in the employees table ensures every employee has a unique identifier.
  emp_id INTEGER PRIMARY KEY

- FOREIGN KEY Constraint: Enforces a link between tables, ensuring that a column's values in one table match the primary key of another table.
  Example: In an orders table, a FOREIGN KEY on customer_id can reference the id in a customers table, enforcing that each order belongs to a valid customer.
  FOREIGN KEY (customer_id) REFERENCES customers(id)

- CHECK Constraint: Ensures that values in a column meet specific conditions.
  Example: In an employees table, a CHECK constraint on age could ensure that only employees aged 18 or above are added.
  age INTEGER CHECK (age >= 18)

- DEFAULT Constraint: Provides a default value for a column when no value is specified in an insert operation.
  Example: A DEFAULT constraint on salary in the employees table can set the initial salary to 30,000 if not provided.
  salary DECIMAL DEFAULT 30000

Summary:
Constraints are essential for enforcing data integrity by setting rules for valid data entry, unique values, and proper table relationships.
Properly applied, they prevent many common data errors and contribute to a reliable and consistent database system.
*/

# Q.3

-- The NOT NULL constraint is used to ensure that a column cannot have a NULL value.
-- - Ensures Data Integrity: Guarantees that the column always contains a value, preventing incomplete or inconsistent records.
-- - Prevents Errors: Avoids issues in operations that require a valid value (e.g., calculations, joins).
-- - Enforces Business Rules: Ensures essential data is provided (e.g., email, product price).

-- Example:
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,  -- email must have a value
    username VARCHAR(50) NOT NULL  -- username must have a value
);

-- 2. Can a primary key contain NULL values?
-- No, a primary key cannot contain NULL values because:
-- - Uniqueness: A primary key must uniquely identify each row, and NULL cannot be considered unique.
-- - Mandatory Identification: A primary key needs to have a non-null value to ensure each row can be identified.
-- - Database Standards: Primary keys must have non-null, unique values to maintain integrity.

-- Example of Primary Key:
CREATE TABLE Orders (
    order_id INT NOT NULL PRIMARY KEY,  -- primary key cannot be NULL
    order_date DATE NOT NULL
);


# Q.4

/*
In SQL, constraints are used to enforce rules on data in a table. The most common types of constraints include:

NOT NULL: Ensures a column cannot have a NULL value.
UNIQUE: Ensures all values in a column are unique.
PRIMARY KEY: A combination of NOT NULL and UNIQUE. It uniquely identifies each row in a table.
FOREIGN KEY: Ensures the value in one table matches values in another table.
CHECK: Ensures the values in a column meet a specific condition.
DEFAULT: Sets a default value for a column if no value is provided.
Adding Constraints
To add constraints to an existing table, we use the ALTER TABLE command with ADD CONSTRAINT.


Example: Adding a UNIQUE constraint
*/
-- Step 1: Create an example table without any constraints
create database exp;
use exp;
CREATE TABLE Employees (
    emp_id INT,
    emp_name VARCHAR(100),
    emp_email VARCHAR(100)
);

-- Step 2: Add a UNIQUE constraint on the `emp_email` column
ALTER TABLE Employees
ADD CONSTRAINT unique_email UNIQUE (emp_email);

/*In this example:

We created a table named Employees.
We then added a UNIQUE constraint to the emp_email column to ensure no two employees have the same email.
Example: Adding a CHECK constraint
*/
-- Adding a CHECK constraint to ensure age is greater than or equal to 18
ALTER TABLE Employees
ADD CONSTRAINT check_age CHECK (emp_id >= 1);

/*Removing Constraints
To remove a constraint from a table, we use the ALTER TABLE command with DROP CONSTRAINT.

Example: Removing the UNIQUE constraint*/
-- Removing the UNIQUE constraint from the `emp_email` column
ALTER TABLE Employees
DROP CONSTRAINT unique_email;

/*In this example:
We removed the previously added UNIQUE constraint named unique_email from the Employees table.
Example: Removing the CHECK constraint*/

-- Removing the CHECK constraint from the `emp_id` column
ALTER TABLE Employees
DROP CONSTRAINT check_age;


# Q.5

-- 1. NOT NULL Constraint Violation
-- Create a table with NOT NULL constraints
CREATE TABLE Students (
    student_id INT NOT NULL,
    student_name VARCHAR(100) NOT NULL
);

-- Attempt to insert a row with a NULL value in 'student_name'
-- This will raise an error because 'student_name' cannot be NULL
INSERT INTO Students (student_id, student_name) VALUES (1, NULL);

-- 2. UNIQUE Constraint Violation
-- Create a table with a UNIQUE constraint on 'user_email'
CREATE TABLE Users (
    user_id INT,
    user_email VARCHAR(100) UNIQUE
);

-- Insert a record with a unique email
INSERT INTO Users (user_id, user_email) VALUES (1, 'test@example.com');

-- Attempt to insert another row with the same email
-- This will raise an error because 'user_email' must be unique
INSERT INTO Users (user_id, user_email) VALUES (2, 'test@example.com');

-- 3. PRIMARY KEY Constraint Violation
-- Create a table with a PRIMARY KEY constraint
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

-- Insert a record with a unique order ID
INSERT INTO Orders (order_id, order_date) VALUES (101, '2024-11-08');

-- Attempt to insert another row with the same order_id
-- This will raise an error because 'order_id' must be unique
INSERT INTO Orders (order_id, order_date) VALUES (101, '2024-11-09');

-- 4. FOREIGN KEY Constraint Violation
-- Create a parent table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Create a child table with a FOREIGN KEY constraint
CREATE TABLE OrdersFK (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Attempt to insert a row with a non-existing customer_id
-- This will raise an error because 'customer_id' does not exist in 'Customers'
INSERT INTO OrdersFK (order_id, customer_id) VALUES (1, 999);

-- 5. CHECK Constraint Violation
-- Create a table with a CHECK constraint
CREATE TABLE Employees (
    emp_id INT,
    emp_age INT CHECK (emp_age >= 18)
);

-- Attempt to insert a row with an invalid age
-- This will raise an error because 'emp_age' must be 18 or older
INSERT INTO Employees (emp_id, emp_age) VALUES (1, 16);

-- 6. DEFAULT Constraint (No direct error example, just showcasing its use)
-- Create a table with a DEFAULT constraint
CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(100),
    stock_quantity INT DEFAULT 0
);

-- Insert a row without specifying 'stock_quantity'
-- The value will default to 0 as per the DEFAULT constraint
INSERT INTO Products (product_id, product_name) VALUES (1, 'Laptop');

-- View the result to see the default value applied
SELECT * FROM Products;

/*Explanation of Each Section
NOT NULL Violation:

The SQL command attempts to insert a NULL value into a column defined as NOT NULL, causing an error.
UNIQUE Violation:

The command tries to insert a duplicate email into a column with a UNIQUE constraint, causing an error.
PRIMARY KEY Violation:

The command attempts to insert a duplicate order_id in a table with a PRIMARY KEY, causing an error.
FOREIGN KEY Violation:

The command tries to insert a customer_id in the OrdersFK table that does not exist in the Customers table, causing an error.
CHECK Violation:

The command attempts to insert a value that does not meet the condition specified by the CHECK constraint, causing an error.
DEFAULT Constraint:

Demonstrates how the DEFAULT constraint works by inserting a row without specifying a value for stock_quantity, which defaults to 0.
You can paste this SQL code into your database system to observe the errors when constraints are violated. The errors raised will help you understand how SQL constraints work in practice.
*/

# Q.6
# Original Table Creation
-- Creating the products table without constraints
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

# Adding Constraints to the Existing Table
-- 1. Adding a PRIMARY KEY constraint to 'product_id'
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- 2. Adding a DEFAULT value of 50.00 to the 'price' column
ALTER TABLE products
MODIFY COLUMN price DECIMAL(10, 2) DEFAULT 50.00;

# Testing the Changes
-- Inserting a product without specifying the price
INSERT INTO products (product_id, product_name) VALUES (1, 'Notebook');

-- Inserting a product with a specified price
INSERT INTO products (product_id, product_name, price) VALUES (2, 'Pen', 25.00);

-- Checking the data in the table
SELECT * FROM products;

/*Explanation:
ALTER TABLE is used to modify the existing products table:
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id); adds a primary key to ensure that product_id is unique.
MODIFY COLUMN price DECIMAL(10, 2) DEFAULT 50.00; sets a default value for the price column to 50.00 if no value is provided during insertion.
This completes your task of adding constraints to the existing table using simple SQL commands.
*/

# Q.7

SELECT 
    s.student_name, 
    c.class_name
FROM 
    Students s
INNER JOIN 
    Classes c ON s.class_id = c.class_id;

# Q .8

SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
LEFT JOIN 
    Customers c ON o.customer_id = c.customer_id;

# Q. 9

SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    Sales s
INNER JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;

# Q. 10

SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od ON o.order_id = od.order_id;

-- SQL Commands

# 1.
-- Query to identify Primary Keys in the schema
SELECT 
    table_name, 
    constraint_name, 
    column_name
FROM 
    information_schema.key_column_usage
WHERE 
    constraint_name = 'PRIMARY'
    AND table_schema = 'mavenmovies';  -- replace with your actual schema name if needed

-- Query to identify Foreign Keys in the schema
SELECT 
    table_name, 
    constraint_name, 
    column_name,
    referenced_table_name,
    referenced_column_name
FROM 
    information_schema.key_column_usage
WHERE 
    table_schema = 'mavenmovies'  -- replace with your actual schema name if needed
    AND referenced_table_name IS NOT NULL;

/*Explanation:
The first query will give you all the Primary Keys in the database, listing each table along with the primary key column.
The second query will return all Foreign Keys, showing which columns in your tables are linked to other tables' primary keys.*/

#2.
-- Query to list all details of actors
SELECT * 
FROM actor;
-- Query to list specific details of actors
SELECT actor_id, first_name, last_name, last_update
FROM actor;

# 3.
-- Query to list all customer information
SELECT * 
FROM customer;
-- Query to list specific customer details
SELECT customer_id, first_name, last_name, email, store_id, last_update
FROM customer;

# 4.
-- Query to list different countries
SELECT DISTINCT country
FROM country;

# 5.
-- Query to display all active customers based on recent last_update
SELECT customer_id, first_name, last_name, email, store_id, last_update
FROM customer
WHERE last_update > NOW() - INTERVAL 20 year;  -- Adjust the interval as per your definition of "active"

# 6.
-- Query to list all rental IDs for customer with ID 1
SELECT rental_id
FROM rental
WHERE customer_id = 1;


# 7.
-- Query to display all films with rental duration greater than 5
SELECT film_id, title, rental_duration
FROM film
WHERE rental_duration > 5;

# 8.
-- Query to list the total number of films with replacement cost between $15 and $20
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

# 9.
-- Query to display the count of unique first names of actors
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

# 10.
-- Query to display the first 10 records from the customer table
SELECT *
FROM customer
LIMIT 10;

# 11.
SELECT * 
FROM customer 
WHERE first_name LIKE 'b%' 
LIMIT 3;

# 12.
SELECT movie_name 
FROM movies 
WHERE rating = 'G' 
LIMIT 5;

# 13.
SELECT first_name, last_name 
FROM customer 
WHERE first_name LIKE 'a%';


# 14.
SELECT first_name
FROM customer 
WHERE first_name LIKE '%a';

# 15.
SELECT city 
FROM city
WHERE city LIKE 'a%a' 
LIMIT 4;

# 16.
SELECT * 
FROM customer 
WHERE first_name LIKE '%NI%';

# 17.
SELECT * 
FROM customer 
WHERE first_name LIKE '_r%';

# 18.
SELECT * 
FROM customer 
WHERE first_name LIKE 'a%' 
  AND LENGTH(first_name) >= 5;

# 19.
SELECT * 
FROM customer 
WHERE first_name LIKE 'a%o';

# 20.
SELECT * 
FROM film 
WHERE rating IN ('PG', 'PG-13');

# 21.
SELECT * 
FROM film 
WHERE length BETWEEN 50 AND 100;

# 22.
SELECT * 
FROM actor_award
ORDER BY awards DESC 
LIMIT 50;

# 23.
SELECT DISTINCT film_id 
FROM inventory;


-- Functions

# Basic Aggregate Functions:

# 1.
SELECT COUNT(*) 
FROM rental 
WHERE rental_date BETWEEN '2005-01-01' AND '2005-12-31';

# 2.
SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration
FROM rental
WHERE return_date IS NOT NULL;

# String Functions:

# 3.
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name 
FROM customer;

# 4.
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

# GROUP BY:

# 5.
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

# 6.
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

# 7.
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

# 8.
SELECT 
    l.name AS language_name,
    AVG(f.rental_rate) AS average_rental_rate
FROM 
    film f
JOIN 
    language l ON f.language_id = l.language_id
GROUP BY 
    l.name;


# Joins

# 9.
-- Query to display movie title, customer's first name and last name who rented the movie
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

# 10.
-- Query to retrieve names of all actors who appeared in the film "Gone with the Wind"
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

# 11.
-- Query to retrieve customer names along with total amount spent on rentals
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name;

# 12.
-- Query to list titles of movies rented by each customer in a specific city (e.g., 'London')
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'  -- Replace 'London' with the desired city
ORDER BY c.first_name, c.last_name, f.title;

# Advanced Joins and GROUP BY:

#13
-- Query to display the top 5 rented movies along with the number of times they've been rented
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;

# 14.
-- Query to determine customers who have rented movies from both stores (store ID 1 and store ID 2)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;


# Windows Function:

# 1.
-- Query to rank customers based on the total amount they've spent on rentals
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY customer_rank;

# 2.

-- Query to calculate cumulative revenue generated by each film over time
SELECT 
    f.title,
    p.payment_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, p.payment_date;

# 3.
-- Query to calculate the average rental duration for each film, considering films with similar lengths
SELECT 
    f.title,
    f.length,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS average_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL  -- Only consider completed rentals
GROUP BY f.length, f.film_id, f.title
ORDER BY f.length, f.title;

# 4.
-- Query to identify the top 3 films in each category based on their rental counts
SELECT 
    c.name AS category_name,
    f.title,
    COUNT(r.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS film_rank
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id, f.title
HAVING film_rank <= 3
ORDER BY c.name, film_rank;


# 5.
-- Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers
WITH customer_rentals AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
average_rentals AS (
    SELECT 
        AVG(total_rentals) AS avg_rentals
    FROM customer_rentals
)
SELECT 
    cr.customer_id,
    cr.first_name,
    cr.last_name,
    cr.total_rentals,
    ar.avg_rentals,
    (cr.total_rentals - ar.avg_rentals) AS difference_from_avg
FROM customer_rentals cr
CROSS JOIN average_rentals ar
ORDER BY difference_from_avg DESC;

# 6.
-- Query to find the monthly revenue trend for the entire rental store
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS revenue_month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY revenue_month
ORDER BY revenue_month;

# 7.
-- Query to identify customers whose total spending falls within the top 20% of all customers
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_percentile
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent
FROM customer_spending
WHERE spending_percentile <= 0.2
ORDER BY total_spent DESC;

# 8.
WITH category_rentals AS (
    SELECT 
        c.name AS category_name,        -- Corrected column name here
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title          -- Corrected column name here
)
SELECT 
    category_name,
    film_title,
    rental_count,
    SUM(rental_count) OVER (PARTITION BY category_name ORDER BY rental_count DESC) AS running_total
FROM category_rentals
ORDER BY category_name, rental_count DESC;

# 9.
WITH category_rentals AS (
    SELECT 
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
),
category_avg_rentals AS (
    SELECT 
        category_name,
        AVG(rental_count) AS avg_rental_count
    FROM category_rentals
    GROUP BY category_name
)
SELECT 
    cr.category_name,
    cr.film_title,
    cr.rental_count,
    car.avg_rental_count
FROM category_rentals cr
JOIN category_avg_rentals car ON cr.category_name = car.category_name
WHERE cr.rental_count < car.avg_rental_count
ORDER BY cr.category_name, cr.rental_count;

# 10.
-- Query to identify the top 5 months with the highest revenue and display the revenue generated
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS revenue_month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY revenue_month
ORDER BY total_revenue DESC
LIMIT 5;

# Normalisation & CTE
use sakila;
# 1.
-- Create a new table 'rental_films' to store atomic rental-film pairs
CREATE TABLE rental_films (
    rental_id INT NOT NULL,
    customer_id INT NOT NULL,
    rental_date DATETIME NOT NULL,
    film_id INT NOT NULL,
    PRIMARY KEY (rental_id, film_id),  -- Composite primary key to uniquely identify each rental-film pair
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id), -- FK to the 'rental' table
    FOREIGN KEY (film_id) REFERENCES film(film_id)  -- FK to the 'film' table
);

-- Insert the atomic rental-film pairs into 'rental_films' table
INSERT INTO rental_films (rental_id, customer_id, rental_date, film_id)
VALUES
(1, 101, '2024-01-15 10:00:00', 1),  -- Movie1 (film_id 1)
(1, 101, '2024-01-15 10:00:00', 2),  -- Movie2 (film_id 2)
(2, 102, '2024-01-16 15:00:00', 3);  -- Movie3 (film_id 3)

# 2.
-- Create a table for actors with non-key attributes
CREATE TABLE actor (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(255)
);

-- Create the normalized film_actor table with only the composite primary key
CREATE TABLE film_actor (
    film_id INT NOT NULL,
    actor_id INT NOT NULL,
    PRIMARY KEY (film_id, actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

-- Insert actor details into the new 'actor' table
INSERT INTO actor (actor_id, actor_name)
SELECT DISTINCT actor_id, actor_name FROM film_actor;

-- Assuming `actor_name` was in film_actor, we now remove it from the film_actor table
-- (The `actor_name` will now be retrieved from the 'actor' table)

# 3.
-- Create a new 'country' table
CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country VARCHAR(255),
    last_update TIMESTAMP
);

-- Create a new 'city' table
CREATE TABLE city (
    city_id INT PRIMARY KEY,
    city VARCHAR(255),
    country_id INT,
    last_update TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Create a new 'address' table
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    address VARCHAR(255),
    city_id INT,
    postal_code VARCHAR(10),
    phone VARCHAR(20),
    last_update TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- Modify the 'customer' table to reference 'address_id' instead of storing address, city, and country details
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address_id INT,
    store_id INT,
    active BOOLEAN,
    create_date TIMESTAMP,
    last_update TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

# 4.
-- Creating an unnormalized payment table
CREATE TABLE payment_UNF (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    rental_id INT,
    film_title VARCHAR(100),
    payment_date DATETIME,
    amount DECIMAL(5, 2)
);

-- Inserting sample data into unnormalized table
INSERT INTO payment_UNF (payment_id, customer_id, first_name, last_name, rental_id, film_title, payment_date, amount)
VALUES 
    (1, 1, 'John', 'Doe', 101, 'Movie A', '2024-01-10 10:30', 4.99),
    (2, 1, 'John', 'Doe', 102, 'Movie B', '2024-01-11 11:00', 3.99),
    (3, 2, 'Jane', 'Smith', 103, 'Movie A', '2024-01-12 12:00', 4.99);
-- Creating 1NF version of the payment table (Removing repeating groups)
CREATE TABLE payment_1NF (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    rental_id INT,
    payment_date DATETIME,
    amount DECIMAL(5, 2)
);

-- Inserting data into the 1NF table
INSERT INTO payment_1NF (payment_id, customer_id, rental_id, payment_date, amount)
VALUES 
    (1, 1, 101, '2024-01-10 10:30', 4.99),
    (2, 1, 102, '2024-01-11 11:00', 3.99),
    (3, 2, 103, '2024-01-12 12:00', 4.99);

-- Creating customer table to remove partial dependencies
CREATE TABLE customer_2NF (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Inserting customer data
INSERT INTO customer_2NF (customer_id, first_name, last_name)
VALUES 
    (1, 'John', 'Doe'),
    (2, 'Jane', 'Smith');

-- Creating rental table to remove partial dependencies
CREATE TABLE rental_2NF (
    rental_id INT PRIMARY KEY,
    film_title VARCHAR(100)
);

-- Inserting rental data
INSERT INTO rental_2NF (rental_id, film_title)
VALUES 
    (101, 'Movie A'),
    (102, 'Movie B'),
    (103, 'Movie A');
-- Creating 2NF version of the payment table
CREATE TABLE payment_2NF (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    rental_id INT,
    payment_date DATETIME,
    amount DECIMAL(5, 2),
    FOREIGN KEY (customer_id) REFERENCES customer_2NF(customer_id),
    FOREIGN KEY (rental_id) REFERENCES rental_2NF(rental_id)
);

-- Inserting data into the 2NF payment table
INSERT INTO payment_2NF (payment_id, customer_id, rental_id, payment_date, amount)
VALUES 
    (1, 1, 101, '2024-01-10 10:30', 4.99),
    (2, 1, 102, '2024-01-11 11:00', 3.99),
    (3, 2, 103, '2024-01-12 12:00', 4.99);


# 5.
-- Using a CTE to get the distinct list of actor names and their film counts
WITH ActorFilmCount AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id
)

-- Selecting actor names and the number of films they have acted in
SELECT 
    actor_name,
    film_count
FROM 
    ActorFilmCount
ORDER BY 
    film_count DESC;

# 6.
-- Creating a CTE to combine film and language information
WITH FilmLanguageDetails AS (
    SELECT 
        f.film_id,
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)

-- Selecting film title, language name, and rental rate
SELECT 
    film_title,
    language_name,
    rental_rate
FROM 
    FilmLanguageDetails
ORDER BY 
    film_title;

# 7.
-- Using a CTE to calculate the total revenue generated by each customer
WITH CustomerRevenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id
)

-- Selecting customer name and total revenue
SELECT 
    customer_name,
    total_revenue
FROM 
    CustomerRevenue
ORDER BY 
    total_revenue DESC;

# 8.
-- Using a CTE with a window function to rank films by rental duration
WITH FilmRank AS (
    SELECT 
        film_id,
        title AS film_title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_duration_rank
    FROM 
        film
)

-- Selecting film title, rental duration, and rank
SELECT 
    film_title,
    rental_duration,
    rental_duration_rank
FROM 
    FilmRank
ORDER BY 
    rental_duration_rank;

# 9.
-- Creating a CTE to find customers with more than two rentals
WITH CustomersWithRentals AS (
    SELECT 
        r.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM 
        rental r
    GROUP BY 
        r.customer_id
    HAVING 
        COUNT(r.rental_id) > 2
)

-- Joining the CTE with the customer table to retrieve additional customer details
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.active,
    cw.rental_count
FROM 
    CustomersWithRentals cw
JOIN 
    customer c ON cw.customer_id = c.customer_id
ORDER BY 
    cw.rental_count DESC;

# 10
-- Using a CTE to calculate the total number of rentals made each month
WITH MonthlyRentals AS (
    SELECT 
        DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month,
        COUNT(r.rental_id) AS total_rentals
    FROM 
        rental r
    GROUP BY 
        DATE_FORMAT(r.rental_date, '%Y-%m')
)

-- Selecting the month and total number of rentals
SELECT 
    rental_month,
    total_rentals
FROM 
    MonthlyRentals
ORDER BY 
    rental_month;

# 11.
-- Using a CTE and self-join to generate pairs of actors who appeared in the same film
WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE 
        fa1.actor_id < fa2.actor_id  -- Ensure each pair is listed only once
)

-- Retrieving actor names along with the film they appeared in together
SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name,
    f.title AS film_title
FROM 
    ActorPairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
JOIN 
    film f ON ap.film_id = f.film_id
ORDER BY 
    film_title, actor1_name, actor2_name;

# 12.
-- Using a recursive CTE to find employees who report to a specific manager
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: Select the manager (e.g., staff_id = 1)
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM 
        staff s
    WHERE 
        s.reports_to = 1  -- Replace 1 with the manager's staff_id you want to search for
    
    UNION ALL

    -- Recursive case: Find employees who report to the employees from the previous level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM 
        staff s
    INNER JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)

-- Selecting the list of employees who report to the specified manager
SELECT 
    staff_id,
    first_name,
    last_name,
    reports_to
FROM 
    EmployeeHierarchy
ORDER BY 
    staff_id;
















































