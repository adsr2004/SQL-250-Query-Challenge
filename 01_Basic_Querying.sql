# BASIC QUERYING
# Fetch all users
Select * from users;
# Get all restaurants
select * from restaurants;
# List all menu items
select * from menu;
# Show all orders
select * from orders;
# Get all order items
select * from order_items;
# Fetch users from Bangalore
select * from users where address = 'Bangalore';
# Find restaurants with rating > 4.5
select * from restaurants where rating > 4.5;
# List menu items with price > 200
select * from menu where price>200;
# Get orders with total_amount > 300
select * from orders where total_amount > 300;
# Find users whose name starts with 'R'
select * from users where name like 'r%';
# Find users whose email contains 'gmail'
select * from users where email like '%gmail%';
# Get menu items sorted by price
select * from menu order by price asc;
# Get top 5 expensive menu items
select item_name , price from menu order by price desc limit 5;
# Find cheapest item
select item_name , price from menu order by price asc limit 1;
# Count total users
select count(*) from users;
# Count total orders
select count(*) from  orders;
# Find distinct cities in users
select distinct address from users; 
# Find restaurants in Bangalore
select * from restaurants where location = 'bangalore';
# Find orders placed today
select * from orders where date(order_date)= curdate();
# Get users sorted by name
select * from users order by name ;
# Find menu items between 100 and 200
select item_name , price from menu where price between 100 and 200;
# Find users with phone starting with 9
select * from users where phone like '9%';
# Get orders sorted by amount descending
select * from orders order by total_amount desc;
# Find restaurants with rating between 4.2 and 4.6
select * from restaurants where rating between 4.2 and 4.6;
# List all unique item names
select distinct item_name ,price from menu;
# Find menu items ending with 'a'
select item_name , price from menu  where item_name like '%a';
# Get count of menu items per restaurant
select restaurant_id , count(*) as total_items from Restaurants group by restaurant_id;
# Find average price of menu items
select avg(price) as average_price from menu;
# Get max price item
select item_name,price from menu where price = (select max(price)from menu);
# Get min price item
select item_name,price from menu where price = (select min(price)from menu);
# Find users with 'a' in name
select * from users where name like '%a%';
# Find orders with even order_id
select * from orders where order_id % 2 = 0;
# Get users with address length > 5
select * from users where length(address) > 5;
# Get menu items sorted alphabetically
select * from menu order by item_name asc;
# Find users with duplicate cities
select address , count(*) as total_user from users group by address having count(*) >1;
# Get orders above average amount
select * from orders where total_amount >( select avg(total_amount) from orders );
# Find items with price not equal to 100
select * from menu where price != 100; 
# Get all records with NULL values
select * from users where name is null or email is null or phone is null or address is null;
# Count total restaurants
select count(*) from restaurants;
# Get latest order
select * from orders order by order_date desc limit 1;