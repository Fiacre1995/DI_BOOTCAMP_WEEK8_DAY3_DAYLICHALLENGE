-- Database: test

-- DROP DATABASE IF EXISTS test;

CREATE DATABASE test
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'French_France.1252'
    LC_CTYPE = 'French_France.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	CREATE TABLE customer(
		
		id SERIAL PRIMARY KEY,
		first_name VARCHAR(50) NOT NULL,
		last_name  VARCHAR(30) NOT NULL
	)
	
	CREATE TABLE profil_customer (
		id SERIAL PRIMARY KEY,
		isLoggedIn BOOLEAN DEFAULT false,
		customer_id INTEGER REFERENCES customer (id)
	
	)
	
	INSERT INTO customer (first_name,last_name)
	VALUES ('true', ('biche')),
		   ('Jérôme', 'Lalu'),
		   ('Léa', 'Rive')
		  
	SELECT id FROM customer WHERE id = 1
	
	INSERT INTO profil_customer (isLoggedIn,customer_id)
	VALUES (true, (SELECT id FROM customer WHERE id = 1)),
		   (false, (SELECT id FROM customer WHERE id = 2))
		   
	DROP TABLE profil_customer
	
	SELECT * FROM profil_customer
	
	SELECT C.first_name FROM customer C INNER JOIN profil_customer P ON C.id = P.customer_id
	WHERE P.isLoggedIn = true;
	
	SELECT C.first_name, P.isLoggedIn FROM customer C FULL JOIN profil_customer P ON C.id = P.customer_id 

	SELECT COUNT(*) FROM customer C INNER JOIN profil_customer P ON C.id = P.customer_id
	WHERE P.isLoggedIn = false;
	
	CREATE TABLE book(
		
		book_id  SERIAL PRIMARY KEY,
		title  VARCHAR(50) NOT NULL,
		author   VARCHAR(30) NOT NULL
	)
	
	INSERT INTO book (title,author)
	VALUES ('Alice au pays des merveilles', 'Lewis Carroll'),
		   ('Harry Potter', 'JK Rowling'),
		   ('Pour tuer un oiseau moqueur', 'Harper Lee')
		   
	CREATE TABLE student(
		
		student_id   SERIAL PRIMARY KEY,
		name   VARCHAR(50) NOT NULL UNIQUE,
		age   INTEGER NOT NULL,
		CHECK (Age<=15)
	)
	
	
	INSERT INTO student (name, age)
	VALUES ('Jean', 12),
		   ('Couche', 11),
		   ('Patrick', 10),
		   ('Bob', 14)
	
	SELECT * FROM student
	SELECT * FROM book
	CREATE TABLE library(
		
		book_fk_id INTEGER REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
		student_id INTEGER REFERENCES student (student_id) ON DELETE CASCADE ON UPDATE CASCADE,
		borrowed_date DATE
	)
	
	INSERT INTO library (book_fk_id, student_id,borrowed_date)
	VALUES (1, 1, '15/02/2022'),
		   (1, 4, '03/03/2021'),
		   (1, 3, '23/05/2021'),
		   (2, 4, '12/08/2021')
	
	SELECT * FROM library L 
	INNER JOIN book B ON L.book_fk_id = B.book_id
	INNER JOIN student USING(student_id)
	
	SELECT S.name, B.title FROM library L 
	INNER JOIN book B ON L.book_fk_id = B.book_id
	INNER JOIN student S USING(student_id)
	
	SELECT AVG(S.age) FROM library L 
	INNER JOIN book B ON L.book_fk_id = B.book_id
	INNER JOIN student S USING(student_id)
	
	DELETE FROM student
	WHERE student_id = 2