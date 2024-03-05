create database rahul_assign;
use rahul_assign;

create table customers(
customer_id int primary key,
first_name varchar(255),
last_name varchar(255),
email varchar(255),
address varchar(255));

create table products(
product_id int primary key,
product_name varchar(255),
descr varchar(255),
price int,
stockQuantity int);

create table cart(
cart_id int primary key,
customer_id int,
product_id int,
quantity int,
foreign key(customer_id) references customers(customer_id),
foreign key(product_id) references products(product_id)
);

create table orders(
order_id int primary key,
customer_id int,
order_date date,
total_amount int,
foreign key(customer_id) references customers(customer_id)
);


create table order_items(
order_item_id int primary key,
order_id int,
product_id int,
quantity int,
item_amount int,
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id)
);


insert into products values
(1, 'Laptop', 'High-performance laptop', 800, 10),
(2, 'Smartphone', 'Latest smartphone', 600, 15),
(3, 'Tablet', 'Portable tablet', 300, 20),
(4, 'Headphones', 'Noise-cancelling', 150, 30),
(5, 'TV', '4k Smart TV', 900, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50, 25),
(7, 'Refrigerator', 'Energy-efficient',  700, 10),
(8, 'Microwave Oven',  'Countertop microwave',  80, 15),
(9, 'Blender', 'High-speed blender', 70, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120, 10);


insert into customers values
(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');


insert into cart values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);


INSERT INTO order_items (order_item_id, order_id, product_id, quantity, item_amount) VALUES
(1, 1, 1, 2, 1600),
(2, 1, 3, 1, 300),
(3, 2, 2, 3, 1800),
(4, 3, 5, 2, 1800),
(5, 4, 4, 4, 600),
(6, 4, 6, 1, 50),
(7, 5, 1, 1, 800),
(8, 5, 2, 2, 1200),
(9, 6, 10, 2, 240),
(10, 6, 9, 3, 210);


insert into orders (order_id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);


-- 1. Update refrigerator product price to 800.
update products set price=800 where product_id=7;

-- 2. Remove all cart items for a specific customer.
delete from cart where customer_id=2;

-- 3. retrieve Products Priced Below $100
select product_name from products where price < 100;

-- 4. Find Products with Stock Quantity Greater Than 5. 
select product_name from products where stockQuantity > 5; 

-- 5. Retrieve Orders with Total Amount Between $500 and $1000.
select * from orders where total_amount between 500 and 1000;

-- 6. Find Products which name end with letter ‘r’
select * from products where product_name like '%r';

-- 7. Retrieve Cart Items for Customer 5.
select c.first_name, c.last_name, ca.cart_id, p.product_name as product_name, ca.product_id, ca.quantity 
from customers as c 
join cart as ca on c.customer_id = ca.customer_id 
join products as p on ca.product_id = p.product_id
where c.customer_id = 5;

-- 8. Find Customers Who Placed Orders in 2023.
select o.customer_id, ca.first_name, ca.last_name from orders as o join customers as ca on o.customer_id=ca.customer_id where year(o.order_date)=2023; 

-- 9. Determine the Minimum Stock Quantity for Each Product Category.
select product_id, product_name, descr, stockQuantity as Minimum_Stock from products 
where stockQuantity = (select MIN(stockQuantity) from products);

-- 10. Calculate the Total Amount Spent by Each Customer.
select c.customer_id, c.first_name, c.last_name, SUM(oi.quantity * p.price) as Total_Amount
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name;

-- 11. Find the Average Order Amount for Each Customer.
select c.customer_id, c.first_name, c.last_name, avg(oi.quantity * p.price) as Avg_Amount
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name;

-- 12. Count the Number of Orders Placed by Each Customer.
select c.customer_id, c.first_name, c.last_name, COUNT(oi.order_id) as order_count
from customers as c
left join orders as o on c.customer_id = o.customer_id
left join order_items as oi on o.order_id = oi.order_id
group by c.customer_id, c.first_name, c.last_name;


-- 13. Find the Maximum Order Amount for Each Customer.
select c.customer_id, c.first_name, c.last_name, MAX(oi.quantity * p.price) as max_order
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name;


-- 14. Get Customers Who Placed Orders Totaling Over $1000.
select c.customer_id, c.first_name, c.last_name, SUM(oi.quantity * p.price) as Above_1000
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name
having Above_1000>1000;

-- 15. Subquery to Find Products Not in the Cart.
select product_id, product_name
from products
where product_id not in (select distinct product_id from cart);

-- it must give product_id only, but in question 2, since we've removed the customer 2's record, we get both product_id 2 and 8 here. 
-- below is the code to add back the removed value if necessary
INSERT INTO cart (cart_id, customer_id, product_id, quantity)
VALUES (3, 2, 2, 3);

-- 16. Subquery to Find Customers Who Haven't Placed Orders.
select c.customer_id, c.first_name, c.last_name
from customers c
left join orders o on c.customer_id = o.customer_id
left join order_items oi on o.order_id = oi.order_id
where oi.order_id is null;

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product.
select p.product_id, p.product_name, (sum(oi.quantity * p.price) / (select sum(quantity * price) from order_items)) * 100 as revenue_percentage
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- 18. Subquery to Find Products with Low Stock.
select p.product_id, p.product_name, p.stockquantity - coalesce(sum(oi.quantity), 0) as low_stock
from products p
left join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name, p.stockquantity
having low_stock < 4;

-- 19. Subquery to Find Customers Who Placed High-Value Orders.
select c.customer_id, c.first_name, c.last_name, SUM(oi.quantity * p.price) as Total_Amount
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by c.customer_id, c.first_name, c.last_name
having Total_Amount > 1000;