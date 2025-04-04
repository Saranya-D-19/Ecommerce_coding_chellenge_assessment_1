create database Ecommerce

use Ecommerce

create table customers(
customer_id int not null primary key,
firstname varchar(100) not null,
lastname varchar(100) not null,
email varchar(100) unique,
address varchar(100),
password varchar(100) not null unique
)

create table products(
product_id int not null primary key,
name varchar(100),
price decimal(10,2),
description varchar(100),
stockQuantity int
)

create table cart(
cart_id int not null primary key,
customer_id int,
product_id int,
quantity int,
constraint fk_cid foreign key (customer_id) references customers (customer_id),
constraint fk_pid foreign key (product_id) references products (product_id)
)

create table orders(
order_id int not null primary key,
customer_id int,
order_date date,
total_price decimal(10,2),
shipping_address varchar(100),
constraint fk_coid foreign key (customer_id) references customers(customer_id)
)

create table order_items(
order_item_id int not null primary key,
order_id int,
product_id int,
quantity int,
itemAmount decimal(10,2),
constraint fk_ooid foreign key (order_id) references orders(order_id),
constraint fk_opid foreign key (product_id) references products(product_id)
)

insert into customers (customer_id,firstname,lastname,email,address,password) values
(1,'John','Doe','johndoe@example.com','123 Main St, City','john123'),
(2,'Jane','Smith','janesmith@example.com','456 Elm St, Town','jane123'),
(3,'Robert','Johnson','robert@example.com','789 Oak St, Village','robert123'),
(4,'Sarah','Brown','sarah@example.com','101 Pine St,Suburb','saarh123'),
(5,'David','Lee','david@example.com','234 Cedar St, District','david123'),
(6,'Laura','Hall','laura@example.com','567 Birch St, County','laura123'),
(7,'Michael','Davis','jmichael@example.com','890 Maple St, State','micheal123'),
(8,'Emma','Wilson','emma@example.com','321 Redwood St, Country','emma123'),
(9,'William','Taylor','william@example.com','432 Spruce St, Province','william123'),
(10,'Olivia','Adams','olivia@example.com','765 Fir St, Territory','olivia123')


insert into products(product_id,name,description,price,stockQuantity) values
(1,'Laptop','High-performance laptop',800.00,10),
(2,'Smartphone','Latest smartphone',600.00,15),
(3,'Tablet','HPortable tablet',300.00,20),
(4,'Headphones','Noise-canceling',800.00,10),
(5,'TV','4K Smart TV',900.00,5),
(6,'Coffee Maker','Coffee Maker',50.00,25),
(7,'Refrigerator','Energy-efficient',700.00,10),
(8,'Microwave Oven','Countertop microwave',80.00,15),
(9,'Blender','High-speed blender',70.00,20),
(10,'Vacuum Cleaner','Bagless vacuum cleaner',120.00,10)

insert into cart(cart_id,customer_id,product_id,quantity) values
(1,1,1,2),
(2,1,3,1),
(3,2,2,3),
(4,3,4,4),
(5,3,5,2),
(6,4,6,1),
(7,5,1,1),
(8,6,10,2),
(9,6,9,3),
(10,7,7,2)

insert into orders (order_id,customer_id,order_date,total_price,shipping_address) values
(1,1,'2023-01-05',1200.00,'chennai'),
(2,2,'2023-02-10',900.00,'salem'),
(3,3,'2023-03-15',300.00,'mumbai'),
(4,4,'2023-04-20',150.00,'delhi'),
(5,5,'2023-05-25',1800.00,'bengalore'),
(6,6,'2023-06-30',400.00,'gujarat'),
(7,7,'2023-07-05',700.00,'karnataka'),
(8,8,'2023-08-10',160.00,'madurai'),
(9,9,'2023-09-15',140.00,'sivagangai'),
(10,10,'2023-10-20',1400.00,'madurai')

insert into order_items (order_item_id,order_id,product_id,quantity,itemAmount) values
(1,1,1,2,1600.00),
(2,1,3,1,300.00),
(3,2,2,3,1800.00),
(4,3,5,2,1800.00),
(5,4,4,4,600.00),
(6,4,6,1,50.00),
(7,5,1,1,800.00),
(8,5,2,2,1200.00),
(9,6,10,2,240.00),
(10,6,9,3,210.00)

select * from customers
select * from orders
select * from products
select * from cart
select* from order_items

--1.Update refrigerator product price to 800.

update products set price=800.00 where product_id=7

--2. Remove all cart items for a specific customer.

delete from cart where customer_id=7

--3. Retrieve Products Priced Below $100.

select * from products where price<100

--4. Find Products with Stock Quantity Greater Than 5.

select * from products where stockQuantity>5

--5. Retrieve Orders with Total Amount Between $500 and $1000.

select * from orders where total_price between 500 and 1000

--6. Find Products which name end with letter �r�.

select name from products where name like ('%r')

--7. Retrieve Cart Items for Customer 5.

select * from cart where customer_id=5

--8. Find Customers Who Placed Orders in 2023.

select c.customer_id,c.firstname+' '+c.lastname as 'customername',o.order_date
from customers c inner join orders o
on c.customer_id=o.customer_id
where order_date like('2023%')

--9. Determine the Minimum Stock Quantity for Each Product Category.

alter table products
add category varchar(100)

update products set category='electronics' where product_id=1
update products set category='electronics' where product_id=2
update products set category='electronics' where product_id=3
update products set category='electronics' where product_id=4
update products set category='electronics' where product_id=5
update products set category='home appliances' where product_id=6
update products set category='home appliances' where product_id=7
update products set category='home appliances' where product_id=8
update products set category='home appliances' where product_id=9
update products set category='home appliances' where product_id=10

select category,min(stockQuantity) as 'minstock' from products 
group by category

--10. Calculate the Total Amount Spent by Each Customer.

select c.customer_id,concat(c.firstname,' ',c.lastname)as 'customername',sum(o.total_price) as 'total_spent'
from customers c inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.firstname,c.lastname

--11. Find the Average Order Amount for Each Customer.

select c.customer_id,concat(c.firstname,' ',c.lastname) as 'customername', floor(avg(o.total_price))as 'avg_order_amount'
from customers c inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.firstname,c.lastname

--12. Count the Number of Orders Placed by Each Customer.

select c.customer_id,concat(c.firstname,' ',c.lastname) as 'customername',count(o.order_id) as 'no_of_orders'
from customers c inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.firstname,c.lastname

--13. Find the Maximum Order Amount for Each Customer.

select c.customer_id,concat(c.firstname,' ',c.lastname) as 'customername',max(o.total_price) as 'max_order_price'
from customers c inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.firstname,c.lastname

--14. Get Customers Who Placed Orders Totaling Over $1000.

select c.customer_id,concat(c.firstname,' ',c.lastname) as 'customername',sum(o.total_price)
from customers c inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.firstname,c.lastname
having sum(o.total_price) >1000

--15. Subquery to Find Products Not in the Cart.

select product_id,name 
from products
where product_id not in (select product_id from cart)

--16. Subquery to Find Customers Who Haven't Placed Orders.

select customer_id,concat(firstname,' ',lastname) as 'customername'
from customers
where customer_id not in (select customer_id from orders)

--17. Subquery to Calculate the Percentage of Total Revenue for a Product.

select p.product_id,p.name,(sum(oi.itemAmount)) as 'total_revenue',
(sum(oi.itemAmount) *100)/(select sum(itemAmount) from order_items)as 'totel revenue percentage'
from products p inner join order_items oi
on p.product_id=oi.product_id
group by p.product_id,p.name 


--18. Subquery to Find Products with Low Stock.

select product_id,name
from products 
where stockQuantity=(select min(stockQuantity) from products)

--19. Subquery to Find Customers Who Placed High-Value Orders.

select c.customer_id,concat(c.firstname,' ',c.lastname) as 'customername',o.total_price
from customers c inner join orders o 
on c.customer_id =o.customer_id
where o.total_price=(select max(total_price) from orders)



