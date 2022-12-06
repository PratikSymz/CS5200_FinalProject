DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier (
	supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(45) NOT NULL,
    contact_first_name VARCHAR(64) NOT NULL,
	contact_last_name VARCHAR(64) DEFAULT NULL,
    contact_title VARCHAR(55) NOT NULL,
    address_id INT NOT NULL,
    
    CONSTRAINT 	
);