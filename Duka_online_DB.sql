/**
 users,
 products,
 categories,
 orders,
 orderItems, 
 payments,
 reviews
*/
/*To ensure postgresQL generates random UUIDs*/
/*CREATE EXTENSION IF NOT EXISTS pgcrypto;*/
/*
Users
userid (pk), username, fullname, email,password, role ('buyer', 'seller', 'admin');
*/



/*Sample a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11 */
CREATE TABLE users(
	userid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	username VARCHAR(30) UNIQUE,
	fullname VARCHAR(50),
	email VARCHAR(50) UNIQUE,
	password VARCHAR(30),
	role VARCHAR(30)
);

/*
Categories
categoryid (pk), categoryname, desc, isMain, main_categoryId (fk);
*/
CREATE TABLE categories(
categoryid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
category_name VARCHAR(50),
category_desc VARCHAR(255),
is_main BOOLEAN DEFAULT FALSE,
main_categoryid UUID,
FOREIGN KEY (main_categoryid) REFERENCES categories(categoryid)
);
/*Products
product (pk), userid(fk), Productname, price, desc, categoryid, stock(fk),
*/
CREATE TABLE products(
productid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
price int,
product_desc TEXT,
categoryid UUID,
userid UUID,
stock INT,

FOREIGN KEY (categoryid) REFERENCES categories(categoryid),
FOREIGN KEY (userid) REFERENCES users(userid)
);

ALTER TABLE products
ADD COLUMN product_name VARCHAR(50);
/**
Orders
orderid (pk), customerid(fk),order_status, order_total;
*/
CREATE TABLE orders(
orderid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
customerid UUID,
order_status VARCHAR(15),
order_totals INT,
FOREIGN KEY (customerid) REFERENCES users(userid)
);
/*
OrderItems
order_items_id (pk),
orderid (fk),
productid(fk)
*/
CREATE TABLE order_items(
order_item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
orderid UUID,
productid UUID,
FOREIGN KEY (orderid) REFERENCES orders(orderid),
FOREIGN KEY (productid) REFERENCES 	products(productid)
);
/*
Payments
 paymentid, orderid(fk),customerid(fk), payment_status, payment_method
*/
CREATE TABLE payments(
paymentid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
orderid UUID,
customerid UUID,
payment_status VARCHAR(20),
payment_method VARCHAR(20)
);
/*
Reviews
reviewid, rating, comments, productid(fk)
*/
CREATE TABLE reviews(
  reviewid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  rating INT,
  comments TEXT,
  productid UUID,
  FOREIGN KEY (productid) REFERENCES products(productid)
);

/*Insert users  into the users table*/
INSERT INTO users (username, fullname, email, password, role) VALUES
('admin_jane', 'Jane Wanjiru',  'jane.admin@shop.co.ke',   'Admin@123',  'admin'),   
('techhub_ke', 'Peter Otieno',  'peter@techhub.co.ke',     'Seller@123', 'seller'),  
('homestyle',  'Grace Muthoni', 'grace@homestyle.co.ke',   'Seller@456', 'seller'),  
('brian_k',    'Brian Kamau',   'brian.kamau@gmail.com',   'Buyer@123',  'buyer'),   
('amina_h',    'Amina Hassan',  'amina.hassan@gmail.com',  'Buyer@456',  'buyer'),  
('dennis_m',   'Dennis Mwangi', 'dennis.mwangi@yahoo.com', 'Buyer@789',  'buyer'),  
('lucy_n',     'Lucy Njeri',    'lucy.njeri@gmail.com',    'Buyer@321',  'buyer');   

SELECT * FROM users;

--Insert Main Categories
INSERT INTO categories (category_name, category_desc, is_main, main_categoryid) VALUES
('Electronics',    'Phones, computers and gadgets',   TRUE, NULL),   
('Fashion',        'Clothing, shoes and accessories', TRUE, NULL),  
('Home & Kitchen', 'Appliances, cookware and decor',  TRUE, NULL);   

SELECT * FROM categories;
--Inserting subcategories 
INSERT INTO categories (category_name, category_desc, is_main, main_categoryid) VALUES
('Smartphones',     'Android phones and iPhones',          FALSE, '8f302d29-6114-4d38-ac2f-24cb8e932b8e'),  
('Laptops',         'Laptops for work, school and gaming', FALSE, '8f302d29-6114-4d38-ac2f-24cb8e932b8e'),  
('Men''s Clothing', 'Shirts, trousers and jeans for men',  FALSE, 'b1722c49-c20f-4bf0-b7ac-32f7703ceb63'),  
('Cookware',        'Pots, pans and kitchen tools',        FALSE, '89786d3a-37af-4d8d-9791-2388c83afaee');  


--Insert into products table
INSERT INTO products (price, product_desc, categoryid, userid, stock) VALUES
-- seller: techhub_ke -> aaaaaaaa-...-0002
(22000, 'Samsung Galaxy A15 - 128GB, 6GB RAM, dual SIM',                '6a8d0cbf-b9e3-4717-afdb-6901ccf2a9bb', '2e7300af-9e80-4f11-973f-377d662c1513', 25),  
(52000, 'Lenovo IdeaPad 3 - Core i5, 8GB RAM, 512GB SSD, 15.6 inch',    '8a059e77-3188-48af-9c58-182746f5dda7', '2e7300af-9e80-4f11-973f-377d662c1513', 10),  
(3500,  'Wireless Earbuds - Bluetooth 5.3, 20-hour battery case',       '8f302d29-6114-4d38-ac2f-24cb8e932b8e', '2e7300af-9e80-4f11-973f-377d662c1513', 60),  
(18500, 'Tecno Spark 20 Pro - 256GB, 8GB RAM, 50MP camera',             '6a8d0cbf-b9e3-4717-afdb-6901ccf2a9bb', '2e7300af-9e80-4f11-973f-377d662c1513', 20),  
-- seller: homestyle -> aaaaaaaa-...-0003
(1500,  'Men''s Cotton Polo Shirt - available in M, L and XL',          '9aaacad4-9b5b-4345-a550-8ea2e51436fd', 'cbae7672-830a-457a-9900-4f6e2ff66a54', 80),  
(3000,  'Men''s Slim Fit Denim Jeans - dark blue, sizes 30 to 40',      '9aaacad4-9b5b-4345-a550-8ea2e51436fd', 'cbae7672-830a-457a-9900-4f6e2ff66a54', 45),  
(2500,  'Non-stick Frying Pan - 28cm, induction compatible',            'ba10ef2f-9616-46b7-9f09-9bf9e69ee68a', 'cbae7672-830a-457a-9900-4f6e2ff66a54', 30),  
(2800,  'Electric Kettle - 1.8 litre, stainless steel, auto shut-off',  '89786d3a-37af-4d8d-9791-2388c83afaee', 'cbae7672-830a-457a-9900-4f6e2ff66a54', 40);  

SELECT * FROM products;

-- SQL Joins: Practice Questions
 

 
---
 
-- Level 1: Single table (warm-up)
 
-- 1. Get all orders.
-- 2. Get all products that cost more than 3,000.
-- 3. Get all users who are buyers.
-- 4. Get all orders that are still pending.
-- Level 2: INNER JOIN with two tables
 
-- 5. Get all products together with the name of the seller who owns them.
SELECT p.product_name, p.price, p.desc, p.stock u.username AS seller FROM products p JOIN users u ON userid = p.userid;
-- 6. Get all products together with their category name.
-- 7. Get all orders together with the customer's name.
-- 8. Get all reviews together with the product they are about.
-- 9. Get all products owned by one user (the seller `homestyle`).
-- ## Level 3: Joining three or more tables
 
-- 10. For every order, show the customer, the products in it and each product's price.
-- 11. Get all the items in one customer's orders (`brian_k`).
-- 12. Show each order with its payment status and payment method.
-- 13. Show each product with its seller, category and reviews.
-- 14. Show which seller's products each customer bought.
-- ## Level 4: LEFT JOIN (finding what is missing)
 
-- 15. Which products have never been reviewed?
-- 16. Which products have never been ordered?
-- 17. Which users have never placed an order?
-- 18. Show all products with their reviews, including products that have no reviews.
-- ## Level 5: Self join
 
-- 19. Show each sub-category with the name of its main category.
-- 20. Show every main category with how many sub-categories it has (including zero).
-- Level 6: Joins with GROUP BY
 
-- 21. How many products does each seller have?
-- 22. How many orders has each customer placed, and how much did they spend?
-- 23. What is the average rating for each product, and how many reviews does it have?
-- 24. Which products sell the most (number of times ordered)?
-- 25. How much revenue has each seller made from orders that were not cancelled?
-- 26. How many payments are there for each payment method?
-- 27. How many products are in each category (including categories with none)?
-- Level 7: Challenges
 
-- 28. Does every order's `order_totals` match the sum of its item prices?
-- 29. List customers with a pending payment, and the amount they owe.
-- 30. Which products have an average rating below 3 and are still in stock?


