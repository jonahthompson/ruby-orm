CREATE TABLE users (
	id integer PRIMARY KEY AUTOINCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	created_at timestamp DEFAULT current_timestamp
);

-- Create make
-- Read get
-- Update update
-- Delete delete

-- Create
INSERT INTO users (first_name, last_name) VALUES ('Jimothy', 'Bobert');

-- Read
SELECT * FROM users WHERE id = 1 AND first_name = 'Jimothy'; --star just means all data
SELECT first_name, last_name FROM users;

--Update
UPDATE users SET first_name = 'Jimothi' WHERE id = 1;

--Delete
DELETE FROM users WHERE id = 1;