DROP TABLE IF EXISTS address;
CREATE TABLE address (
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_address_1 VARCHAR(64) NOT NULL,
    street_address_2 VARCHAR(55) DEFAULT NULL,
    city VARCHAR(55) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip INT NOT NULL
);
