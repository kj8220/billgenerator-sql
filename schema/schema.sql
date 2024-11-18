CREATE DATABASE testdb;
CREATE TABLE customer
 (customer_id int NOT NULL AUTO_INCREMENT,
 customer_name varchar(100) NOT NULL,
 address varchar(255) DEFAULT NULL,
 email varchar(100) DEFAULT NULL,
 phone_number varchar(15) DEFAULT NULL,
 customer_ts timestamp NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY (customer_id),
 UNIQUE KEY email (email));
 
CREATE TABLE orders (
  order_id int NOT NULL AUTO_INCREMENT,
  customer_id int NOT NULL,
  status varchar(50) DEFAULT NULL,
  order_items json NOT NULL,
  order_ts timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  total_price int NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (customer_id) REFERENCES customer(`customer_id`));
 
CREATE TABLE `product` 
(product_id int NOT NULL AUTO_INCREMENT,
  product_name varchar(100) NOT NULL,
  price decimal(10,2) NOT NULL,
  description text,
  warranty int DEFAULT 0,
  product_ts timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (product_id));
