DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(64) NOT NULL,
	email VARCHAR(64) UNIQUE NOT NULL,
    password VARCHAR(256) NOT NULL
);

DROP TABLE IF EXISTS address;
CREATE TABLE address (
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_address_1 VARCHAR(64) NOT NULL,
    street_address_2 VARCHAR(55) DEFAULT NULL,
    city VARCHAR(55) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip INT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT address_fk_user FOREIGN KEY (user_id)
		REFERENCES users(user_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier (
	supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(45) NOT NULL,
    contact_first_name VARCHAR(64) NOT NULL,
	contact_last_name VARCHAR(64) DEFAULT NULL,
    contact_title VARCHAR(55) NOT NULL
);


DROP TABLE IF EXISTS phone;
CREATE TABLE phone (
	phone_number VARCHAR(55) PRIMARY KEY,
    is_primary BOOL NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT phone_fk_user FOREIGN KEY (user_id)
		REFERENCES users(user_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS category;
CREATE TABLE category (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(64) NOT NULL
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    total_price FLOAT NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT orders_fk_user FOREIGN KEY (user_id)
		REFERENCES users(user_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS product;
CREATE TABLE product (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    category_id INT NOT NULL,
	supplier_id INT NOT NULL,
    price FLOAT NOT NULL,
    -- inventory INT NOT NULL,
    weight FLOAT DEFAULT NULL,
    short_desc VARCHAR(255) NOT NULL,
    long_desc VARCHAR(10000) DEFAULT NULL,
    image_url VARCHAR(64) DEFAULT NULL,

    CONSTRAINT product_fk_category FOREIGN KEY (category_id)
		REFERENCES category(category_id)
			ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT product_fk_supplier FOREIGN KEY (supplier_id)
		REFERENCES supplier(supplier_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);


            
DROP TABLE IF EXISTS order_product_details;
CREATE TABLE order_product_details (
order_id int not null,
product_id int not null,
quantity INT DEFAULT 1,
	CONSTRAINT order_fk_details FOREIGN KEY (order_id) 
		REFERENCES orders(order_id)
			ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT product_fk_details FOREIGN KEY (product_id) 
		REFERENCES product(product_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);


DROP VIEW IF EXISTS consolidated_view;
CREATE VIEW consolidated_view as (
select o.order_id, o.order_date, o.user_id, a.product_id, p.name as product_name, a.quantity as product_quantity, p.price, (p.price*a.quantity) as item_total,
p.short_desc, p.category_id, c.category_name, s.company_name as supplier_name
from ecommerce.orders o inner join ecommerce.order_product_details a using(order_id)
inner join ecommerce.product p using(product_id) inner join ecommerce.category c using(category_id)
inner join ecommerce.supplier s using(supplier_id) 
order by order_id, user_id
);


DROP PROCEDURE IF EXISTS priceRangeFilter;
DELIMITER $$
CREATE PROCEDURE priceRangeFilter(IN start_r INT, IN end_r INT)
BEGIN
DECLARE row_not_found INT;
DECLARE product_id INT; 
DECLARE product_price, product_weight FLOAT;
DECLARE product_name VARCHAR(50);
DECLARE product_category INT;


DECLARE product_cursor CURSOR FOR 
    select p.product_id, p.name, p.price, p.weight, p.category_id
    from ecommerce.product p
    where p.price >= start_r and p.price <= end_r;
DECLARE CONTINUE HANDLER FOR NOT FOUND
    set row_not_found = TRUE;
set row_not_found = FALSE;
OPEN product_cursor;
WHILE row_not_found = false DO
    FETCH product_cursor into product_id, product_name, product_price, product_weight, product_category;
    select product_id, product_name, product_price, product_weight, product_category;
END WHILE;
CLOSE product_cursor;
END $$
DELIMITER ;

