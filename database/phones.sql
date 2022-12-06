DROP TABLE IF EXISTS phone;
CREATE TABLE phone (
	phone_number VARCHAR(55) PRIMARY KEY,
    is_primary BOOL NOT NULL,
    user_id INT NOT NULL,
    
    CONSTRAINT phone_fk_user FOREIGN KEY (user_id)
		REFERENCES users(user_id)
			ON DELETE CASCADE ON UPDATE CASCADE
);
