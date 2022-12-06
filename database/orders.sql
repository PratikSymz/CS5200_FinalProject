DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    quantity INT DEFAULT 1,
    total_price FLOAT NOT NULL
);