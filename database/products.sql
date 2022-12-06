DROP TABLE IF EXISTS product;
CREATE TABLE product (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    category_id INT NOT NULL,
    price FLOAT NOT NULL,
    -- inventory INT NOT NULL,
    weight FLOAT DEFAULT NULL,
    short_desc VARCHAR(255) NOT NULL,
    long_desc VARCHAR(65535) DEFAULT NULL,
    image_url VARCHAR(64) DEFAULT NULL,
    
    CONSTRAINT product_fk_category FOREIGN KEY (category_id)
		REFERENCES category(category_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);
