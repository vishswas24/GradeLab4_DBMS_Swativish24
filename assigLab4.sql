create database ecommerce;

Use ecommerce;

create table category(
cat_id int(5) auto_increment,
cat_name varchar(15) not null,
primary key(cat_id));

insert into category (cat_id , cat_name) values
(1 , 'BOOKS'),
(2 , 'GAMES'),
(3 , 'GROCERIES'),
(4 , 'ELECTRONICS'),
(5 , 'CLOTHES');

create table product(
pro_id int(5) auto_increment primary key,
pro_name varchar(15) not null,
pro_desc varchar(50) default null,
cat_id int(5),
Foreign key(cat_id) references category(cat_id));

insert into product(pro_id, pro_name, pro_desc, cat_id) values
(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
(3, 'ROGLAPTOP	', 'Windows 10 with 15inch screen,i7 processor,1TB SSD', 4),
(4, 'OATS', 'Highly Nutritious from Nestle	', 3),
(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
(6, 'MILK', '1L Toned MIlk', 3),
(7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
(8, 'Jeans', 'Stretchable Denim Jeans with various sizesandcolor', 5),
(9, 'Project IGI', 'compatible with windows 7 and above', 2),
(10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
(11, 'RichDad PoorDad', 'Written by RObert Kiyosaki', 1),
(12, 'TrainYourBrain', 'By Shireen Stephen', 1);

create table supplier(
supp_id int(5) not null,
supp_name varchar(25) not null,
supp_city varchar(25) not null,
supp_phone varchar(10) not null,
primary key(supp_id));

insert into supplier(supp_id, supp_name, supp_city, supp_phone) values
(1, 'Rajesh Retails', 'Delhi', 1234567890),
(2, 'Appario Ltd', 'Mumbai', 2589631470),
(3, 'Knome products', 'Banglore', 9785462315),
(4, 'Bansal Retails', 'Kochi', 8975463285),
(5, 'Mittal Ltd', 'Lucknow', 7898456532);
     
create table supplier_pricing(
pricing_id int(5) auto_increment primary key,
pro_id int(5) not null,
supp_id int(5) not null,
supp_price int(5) default 0,
foreign key(pro_id) references product(pro_id),
foreign key(supp_id) references supplier(supp_id)
);

insert into supplier_pricing(pricing_id, pro_id, supp_id, supp_price) values
(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000);

insert into supplier_pricing(pricing_id, pro_id, supp_id, supp_price) values
(6, 12, 2,780),
(7, 12, 4,789),
(8, 3, 1,31000),
(9, 1, 5,1450),
(10, 4, 2,999),
(11, 7, 3,549),
(12, 7, 4,529),
(13, 6, 2,105),
(14, 6, 1,99),
(15, 2, 5,2999),
(16, 5, 2,2999);


create table customer(
cus_id int(5) auto_increment,
cus_name varchar(15) not null,
cus_phone varchar(10) not null,
cus_city varchar(10) not null,
cus_gender char(1) not null,
primary key(cus_id));

insert into customer(cus_id, cus_name, cus_phone, cus_city, cus_gender) values
(1, 'AAKASH', 9999999999, 'DELHI', 'M'),
(2, 'AMAN', 9785463215, 'NOIDA', 'M'),
(3, 'NEHA', 9999999999, 'MUMBAI', 'F'),
(4, 'MEGHA', 9994562399, 'KOLKATA', 'F'),
(5, 'PULKIT', 7895999999, 'LUCKNOW', 'M');
  
create table orders(
ord_id int(5) auto_increment primary key,
ord_date date,
cus_id int(5),
pricing_id int(5),
foreign key(cus_id) references customer(cus_id),
foreign key(pricing_id) references supplier_pricing(pricing_id));

alter table orders
add ord_amount int(5) default 0; 

insert into orders(ord_id, ord_date, cus_id, pricing_id, ord_amount) values
(101, "2021-10-06", 2, 1, 1500),
(102,"2021-10-12",3,5,1000),
(103,"2021-09-16",5,3,30000),
(104,"2021-10-05",1,1,1500),
(105,"2021-08-16",4,3,3000),
(106,"2021-08-18",1,9,1450),
(107,"2021-09-01",3,7,789),
(108,"2021-09-07",5,6,780),
(109,"2021-09-10",5,3,3000),
(110,"2021-09-10",2,4,2500),
(111,"2021-09-15",4,5,1000),
(112,"2021-09-16",4,7,789),
(113,"2021-09-16",1,8,31000),
(114,"2021-09-16",3,5,1000),
(115,"2021-09-16",5,3,3000),
(116,"2021-09-17",2,14,99);

create table rating(
rat_id int(5) auto_increment primary key,
ord_id int(5),
rat_ratstars int(1) not null default 5,
foreign key (ord_id) references orders(ord_id) );

insert into rating(rat_id, ord_id, rat_ratstars) values
(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(15,115,1),
(16,116,0);

-- question 3

select  c.cus_gender as Customer_Gender, 
count(*) as Order_Count, 
sum(o.ord_amount) as Order_amount 
from customer as c inner join `orders` as o 
on o.cus_id = c.cus_id 
where ord_amount >= 3000 group by c.cus_gender;

-- question 4

SELECT p.name, ord_id, ord_amount, ord_date, cus_id, pricing_id
FROM product as p
inner join 
(select pro_id, 
ord_id,
ord_amount,
ord_date,
cus_id,
pricing_id from `orders` as o inner join 
supplier_pricing as s on o.pricing_id = s.pricing_id and o.cus_id = 2) 
as n 
on n.pro_id = pro.id; 

-- question 5

select supplier.* from supplier where supplier.supp_id in
(select supp_id from supplier_pricing group by supp_id having count(supp_id)>1) group by supplier.supp_id;


-- question 6


select category.cat_id,category.cat_name, min(t3.min_price) as Min_Price
from category
inner join(select product.cat_id, pro_name, t2.* from product inner join(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id) as t2 
where t2.pro_id = product.pro_id) as t3
where t3.cat_id = category.cat_id
group by t3.cat_id;


-- question 7

select pro_id, pro_name from product where pro_id in 
(select pro_id from supplier_pricing where pro_id in 
(select pricing_id from `orders` where ord_date >= '2021-10-05')
);

-- question 8

select customer.cus_name,
customer.cus_gender from customer 
where customer.cus_name like 'A%' or customer.cus_name like '%A';

-- question 9

delimiter &&  
create PROCEDURE proc()
begin
select report.supp_id,report.supp_name,report.Average,
case
when report.Average =5 then 'Excellent Service'
when report.Average >4 then 'Good Service'
when report.Average >2 then 'Average Service'
else 'Poor Service'
end as Type_of_Service from 
(select final.supp_id, supplier.supp_name, final.Average from
(select o.supp_id, sum(o.rat_ratstars)/count(o.rat_ratstars) as Average from
(select supplier_pricing.supp_id, o.ord_id, o.rat_ratstars from supplier_pricing inner join
(select `orders`.pricing_id, rating.ord_id, rating.rat_ratstars from `orders` inner join rating on rating.ord_id = `orders`.ord_id ) as o
on o.pricing_id = supplier_pricing.supp_id) 
as o group by supplier_pricing.supp_id) 
as final inner join supplier where final.supp_id = supplier.supp_id) as report;
end &&  
delimiter ;  

call proc();































