CREATE DATABASE PowerBI_project;
USE PowerBI_project;

create table customers as select row_number() over(order by purchasedate)+3000 as customerid , CustomerName, Country from customer_purchase

create table purchase as
select row_number() over(order by purchasedate)+3000 as customerid,row_number() over(order by purchasedate)+300 as productid, row_number()
over(order by purchasedate)+5000 as purchaseid,transactionid,purchasedate,purchaseprice,purchasequantity,country from customer_purchase;


create table product as 
select distinct productname , productcategory , dense_rank() over(partition by productcategory order by productName)+200 as pid from customer_purchase;

create table products as 
select row_number() over(order by productname)+300 as productid ,productname ,productcategory from product;


select * from customers;
select * from products;
select * from purchase;


-- build relationship in between tables 
ALTER TABLE customers
ADD PRIMARY KEY (CustomerID);

ALTER TABLE products
ADD PRIMARY KEY (productID);

ALTER TABLE purchase
ADD CONSTRAINT fk FOREIGN KEY (CustomerID)
REFERENCES customers(CustomerID);

ALTER TABLE purchase
ADD CONSTRAINT fk2 FOREIGN KEY (productID)
REFERENCES products(productID);