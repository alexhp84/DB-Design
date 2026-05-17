--1. The table meets all the rules of 1NF - there is no specific row order, data types are identical for the column, it has a primary key and no groups are repeated.

--2. This table is in 2NF because it has a single PK and this creates a partial dependency for the data

--3. author_id -> author_name
--publisher_id -> publisher_name
--publisher_id -> publisher_city

--4 & 5
CREATE TABLE authors (
	author_id TEXT PRIMARY KEY,
	author_name TEXT UNIQUE NOT NULL
	);

CREATE TABLE publishers (
	publisher_id  TEXT PRIMARY KEY,
	publisher_name TEXT,
	publisher_city TEXT NOT NULL
	);

CREATE TABLE books (
	ISBN TEXT PRIMARY KEY,
	title TEXT NOT NULL,
	author_id TEXT,
	publisher_id TEXT,
	FOREIGN KEY (author_id) REFERENCES authors (author_id),
	FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id)
	);

--6 Inserting Data
INSERT INTO authors (author_id, author_name)
VALUES
('A1', 'Jane Doe'),
('A2', 'John Smith');

INSERT INTO publishers (publisher_id, publisher_name, publisher_city)
VALUES
('P1', 'TechPress', 'New York'),
('P2', 'DataBooks', 'Paris');

INSERT INTO books (ISBN, title, author_id, publisher_id)
VALUES
('978-1', 'SQL Mastery', 'A1', 'P1'),
('978-2', 'Python Pro', 'A2', 'P1'),
('978-3', 'Data Viz', 'A1', 'P2');

--7 Displaying the data
SELECT
	b.ISBN,
    b.title,

    a.author_id,
    a.author_name,
    p.publisher_id,
    p.publisher_name,
    p.publisher_city
FROM books b
JOIN publishers p ON b.publisher_id = p.publisher_id
JOIN authors a on b.author_id = a.author_id;

--8.
--Creating and inserting data flat table
CREATE TABLE bad_authors_data (
    isbn TEXT PRIMARY KEY,
    title TEXT,
    author_id TEXT,
    author_name TEXT,
    publisher_id TEXT,
    publisher_name TEXT,
    publisher_city TEXT
);

INSERT INTO bad_authors_data
VALUES
    ('978-1', 'SQL Mastery', 'A1', 'Jane Doe', 'P1', 'TechPress', 'New York'),
    ('978-2', 'Python Pro', 'A2', 'John Smith', 'P1', 'TechPress', 'New York'),
    ('978-3', 'Data Viz', 'A1', 'Jane Doe', 'P2', 'DataBooks', 'Paris');


UPDATE bad_authors_data
	SET author_name = 'Jane Doe-Smith'
	WHERE author_name = 'Jane Doe';
--In this query two rows were affected - each instance of Jane Doe

UPDATE authors
	SET author_name = 'Jane Doe-Smith'
	WHERE author_name = 'Jane Doe';
--In this query only one instance of Jane Doe is updated as the query only updates the main authors table
