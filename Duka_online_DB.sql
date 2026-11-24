/**
 users,
 products,
 categories,
 orders,
 orderItems, 
 payments,
 reviews
*/

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

/*
Payments
 paymentid, orderid(fk),customerid(fk), payment_status, payment_method
*/






