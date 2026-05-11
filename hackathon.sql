create database if not exists sale_db;
use sale_db;

create table if not exists categories(
category_id varchar(10) primary key not null,
category_name varchar(100) unique,
description text
);

create table if not exists products(
product_id varchar(10) primary key not null,
product_name varchar(150) not null,
price decimal(10, 2) not null,
status varchar(50),
category_id varchar(10) not null,
foreign key (category_id) references categories(category_id)
);

create table if not exists orders (
order_id int primary key auto_increment,
order_date datetime not null,
total_amount decimal(15,2),
customer_name varchar(100)
);

create table if not exists order_details (
detail_id int primary key auto_increment,
order_id int not null,
foreign key (order_id) references orders(order_id),
product_id varchar(10) not null,
foreign key (product_id) references products(product_id),
quantity int not null,
subtotal decimal(12,2) not null
);

insert into categories (category_id, category_name, description) values
("C01","Coffee","All types of coffee beans and brews"),
("C02","Tea & Fruit","Fresh fruit juices and tea"),
("C03","Bakery","Cakes and pastries");

insert into products (product_id, product_name, price, status, category_id) values
("P001","Espresso",35000,"Available","C01"),
("P002","Matcha Latte",45000,"Available","C02"),
("P003","Tiramisu",55000,"Available","C03"),
("P004","Cold Brew",50000,"Out of Stock","C01"),
("P005","Croissant",30000,"Available","C03");

insert into orders(order_date, total_amount, customer_name) values
("2025-01-01 06:30:00",80000,"Mr.An"),
("2025-01-01 09:15:00",45000,"Ms.Hoa"),
("2025-01-02 14:00:00",140000,"Mr.Binh"),
("2025-01-03 10:00:00",35000,"Anonymous"),
("2025-01-03 11:20:00",90000,"Ms.Lan");

insert into order_details (order_id, product_id, quantity, subtotal) values
(1,"P001",1,35000),
(1,"P004",1,50000),
(3,"P002",3,135000),
(3,"P001",2,70000),
(5,"P003",2,110000);

select * from categories;
select * from products;
select * from orders;
select * from order_details;

update products
set status = "Available"
where product_id = "P004";

update products 
set price = price * 1.1
where category_id = "C03";

delete from order_details
where quantity = 0 or subtotal < 50000;

select product_id, product_name, price
from products
where price >= 40000;

select order_id, order_date, customer_name
from orders
where customer_name like 'M%';

select product_name, price
from products
order by price desc;

select product_name, price, category_name 
from categories
join products on categories.category_id = products.category_id;

select* from products 
where price > (select avg(price) from products);

select customer_name
from order_details
join orders on order_details.order_id = orders.order_id
join products on order_details.product_id = products.product_id
where product_name = 'Matcha Latte';
 