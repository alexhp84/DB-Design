CREATE TABLE customers (
	cust_id INTEGER PRIMARY KEY AUTOINCREMENT,
	cust_add TEXT NOT NULL,
	cust_city TEXT NOT NULL,
	cust_dob TEXT,
	cust_phone INTEGER NOT NULL
	);

CREATE TABLE drinks (
	drink_id INTEGER PRIMARY KEY AUTOINCREMENT,
	drink_name TEXT CHECK (drink_name IN ('Cola', 'Sprite', 'Orange Juice')),
	drink_type TEXT CHECK (drink_type IN ('soft drink', 'alcoholic drink', 'water/juice'))
	);

CREATE TABLE toppings (
	topping_id INTEGER PRIMARY KEY AUTOINCREMENT,
	topping_name TEXT NOT NULL,
	topping_type TEXT CHECK (topping_type IN ('vegetarian', 'vegan', 'meat', 'sauce')),
	topping_price REAL NOT NULL
	);

CREATE TABLE pizzas (
	pizza_id INTEGER PRIMARY KEY AUTOINCREMENT,
	pizza_name TEXT UNIQUE NOT NULL,
	pizza_price REAL NOT NULL
	);

CREATE TABLE orders (
	order_id INTEGER PRIMARY KEY AUTOINCREMENT,
	cust_id INTEGER NOT NULL,
	order_time datetime NOT NULL,
	order_notes TEXT,
	delivery_time datetime NOT NULL,
	FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
	);

CREATE TABLE order_drinks (
	order_id INTEGER NOT NULL,
	drink_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	price_snapshot REAL NOT NULL,
	price_snapshot datetime NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (drink_id) REFERENCES drinks(drink_id),
	PRIMARY KEY (order_id, drink_id)
	);

CREATE TABLE order_pizzas (
	order_id INTEGER NOT NULL,
	pizza_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	price_snapshot REAL NOT NULL,
	price_snapshot datetime NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id),
	PRIMARY KEY (order_id, pizza_id)
	);

CREATE TABLE order_pizza_toppings (
	order_id INTEGER NOT NULL,
	pizza_id INTEGER NOT NULL,
	topping_id INTEGER NOT NULL,
	price_snapshot REAL NOT NULL,
	price_snapshot datetime NOT NULL,
	FOREIGN KEY (order_id, pizza_id) REFERENCES order_pizzas(order_id, pizza_id),
    FOREIGN KEY (topping_id) REFERENCES toppings(topping_id),
	PRIMARY KEY (order_id, pizza_id, topping_id)
	);
