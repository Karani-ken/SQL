/*Creating in SQL*/
CREATE TABLE users(
   userId int PRIMARY KEY,
   username VARCHAR(255),
   email VARCHAR(255), 
   password VARCHAR(12)
);

/*INSERT DATA INTO THE TABLE*/
INSERT INTO users (userId,username,email,password) 
VALUES (4,'Sally', 'janedoe@example.com', 'Password@123'),
       (5,'Smith', 'kellydoe@example.com', 'Password@123');

/*Fetching data using SELECT*/
SELECT * FROM users;

/*SELECT JUST ONE ROW */
SELECT username, email FROM users;

/*SELECT A SPECIFIC USER*/
SELECT * FROM users WHERE username = 'janedoe';

/*Adding another column to the users table*/
ALTER TABLE users
ADD COLUMN phone int;


/*Updating Data in a table or a field in a table*/
UPDATE users
SET phone = 0712345678 WHERE userid = 1;

UPDATE users
SET password = 'Newpass!12' WHERE userid = 3;

/*Adding another column to the users table*/
ALTER TABLE users
ADD COLUMN age int;

ALTER TABLE users
ALTER COLUMN age TYPE VARCHAR(2);

ALTER TABLE users
DROP COLUMN age;

SELECT * FROM users;

/*Delete a row from a table*/
DELETE FROM users WHERE userid = 5;

CREATE TABLE test(
  testId int,
  testName VARCHAR(20)
);

DROP TABLE test;







