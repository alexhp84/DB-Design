--1. Dependencies
--order_id (PK) -> customer_name
-- product_id (PK) -> product_name & unit_price

--2/3. Design & Create
CREATE TABLE customers (
	customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_name TEXT NOT NULL
	);

CREATE TABLE products (
	product_id INTEGER PRIMARY KEY,
	product_name TEXT UNIQUE NOT NULL,
	unit_price REAL NOT NULL
	);

CREATE TABLE orders (
	order_id  INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_id INTEGER,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
	);

CREATE TABLE order_items (
	order_id INTEGER,
	product_id INTEGER,
	qty INTEGER NOT NULL,
	PRIMARY KEY (order_id, product_id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
	);

--DATA INSERT
INSERT INTO customers (customer_name)
VALUES
    ('Alice'),
    ('Bob');

INSERT INTO products (product_id, product_name, unit_price)
VALUES
    (42, 'Keyboard', 49.99),
    (77, 'Mouse', 29.99);

INSERT INTO orders (order_id, customer_id)
VALUES
    (1001, 1),
    (1002, 2);

INSERT INTO order_items (order_id, product_id, qty)
VALUES
    (1001, 42, 2),
    (1001, 77, 1),
    (1002, 42, 1);

--REPRODUCING THE TABLE
SELECT
	o.order_id,
	p.product_id,
	i.qty,
	c.customer_name,
	p.product_name,
	p.unit_price
FROM order_items i
JOIN orders o ON i.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p on i.product_id = p.product_id;

---CREATING THE BAD TABLE AND AMENDING THE DATA AND COMPARING
CREATE TABLE bad_orders (
	order_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	qty	INTEGER NOT NULL,
	customer_name TEXT NOT NULL,
	product_name TEXT NOT NULL,
	unit_price REAL NOT NULL
	);

INSERT INTO bad_orders (order_id, product_id, qty, customer_name, product_name, unit_price) VALUES (1001, 42, 2, 'Alice', 'Keyboard', 49.99);
INSERT INTO bad_orders (order_id, product_id, qty, customer_name, product_name, unit_price) VALUES (1001, 77, 1, 'Alice', 'Mouse', 29.99);
INSERT INTO bad_orders (order_id, product_id, qty, customer_name, product_name, unit_price) VALUES (1002, 42, 1, 'Bob', 'Keyboard', 49.99);

UPDATE bad_orders
	SET product_name = 'Mechanical Keyboard'
	WHERE product_name = 'Keyboard'
	;
--In this table and query three rows were changes as there are three occurences of it in the table

UPDATE products
	SET product_name = 'Mechanical Keyboard'
	WHERE product_name = 'Keyboard'
	;
--In this query only one row was affected as KEYBOARD only appears on one row in one table
