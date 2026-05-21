#41 Join users and orders
select * from 
users u inner join
orders o on
u.user_id = o.user_id;
#42 Get user name with their orders
select u.name ,o.order_id,o.order_date,o.total_amount from 
users u inner join 
orders o on 
u.user_id = o.user_id;
#43 Join orders and order_items
select * from orders o 
inner join 
order_items i on
o.order_id = i.order_id;
#44 Join menu and order_items
select * from menu m
inner join
order_items o on
m.menu_id = o.menu_id;
#45 Get item name with quantity ordered
select item_name , quantity
from menu m
inner join
order_items o on
m.menu_id = o.menu_id;
#46 Join all tables
select * from users u
inner join 
orders o on
u.user_id = o.user_id 
inner join 
order_items i on
 o.order_id = i.order_id
inner join 
menu m on
i.menu_id = m.menu_id
inner join 
Restaurants r on
m.restaurant_id = r.restaurant_id;

#47 Get user name, item name, quantity
select u.name , r.item_name , o.quantity 
from order_items o 
inner join 
orders r on
o.order_id = r.order_id
inner join
users u on
r.user_id = u.user_id 
inner join
menu m on
m.menu_id = o.menu_id;
#48 Get restaurant name with menu items
select r.name , m.item_name 
from restaurants r
inner join 
menu m on
r.restaurant_id = m.restaurant_id;

#49 Get restaurant with ordered items
select r.name , m.item_name , o.order_id , o.quantity
from restaurants r
inner join
menu m on
r.restaurant_id = m.restaurant_id 
inner join 
order_items o on
o.menu_id = m.menu_id;

#50 Find users who placed orders
select name , order_id 
from users u inner join
orders o on
u.user_id = o.user_id ;
#51 Find users who did not place orders
select name , order_id 
from users u inner join
orders o on
u.user_id = o.user_id 
where order_id is null;

#52 Find restaurants with no orders
select r.name , order_id
from restaurants r left join 
menu m on
r.restaurant_id = m.restaurant_id
left join 
order_items oi on
oi.menu_id = m.menu_id
where order_id is null ;

#53 Get orders with item details
select oi.order_id , m.item_name , m.price , m.menu_id
from order_items oi left join 
menu m on
oi.menu_id = m.menu_id;

#54 Find most ordered item
select m.item_name , sum(quantity) as total_quantity 
from menu m
join 
order_items oi on
m.menu_id = oi.menu_id group by m.item_name order by 
total_quantity  desc limit 5 ;

#55 Get total quantity per item
select m.item_name , sum(quantity) as total_quantity 
from menu m
join 
order_items oi on
m.menu_id = oi.menu_id group by m.item_name ;

#56 Join and filter by price > 200
select m.price , m.item_name  
from menu m
 join 
order_items oi on
oi.menu_id = m.menu_id
where m.price > 200;

#57 Join and sort by quantity
select  m.item_name ,sum(quantity) as total_quantity
from menu m
 join 
order_items oi on
oi.menu_id = m.menu_id
group by m.item_name
order by total_quantity desc;

#58 Join and group by user
select u.name , count(order_id) as total_count
from users u join 
orders o on
u.user_id = o.user_id 
group by u.name;

#59 Join and group by restaurant
select r.name , count(distinct oi.order_id) as total_count 
from restaurants r join 
menu m on 
r.restaurant_id = m.restaurant_id
join 
order_items oi on
oi.menu_id = m.menu_id
group by r.name; 

#60 Join multiple conditions
select m.item_name , m.price , sum(quantity) as total_quantity
from order_items oi join
menu m on
oi.menu_id = m.menu_id
group by  m.item_name, m.price
having sum(quantity) >1
order by total_quantity;

#61 Find orders with multiple items
select   order_id, count(oi.menu_id) as total
from order_items oi join 
menu m on
oi.menu_id = m.menu_id
group by order_id 
having count(oi.menu_id)>1;

#62 Get total bill using join
select r.name , sum(quantity * price) 
from restaurants r join 
menu m on
r.restaurant_id = m.restaurant_id
join 
order_items oi on
oi.menu_id = m.menu_id
group by r.name ;

#63 Find restaurant revenue
select r.name , sum(quantity * price) as revenue 
from restaurants r join 
menu m on
r.restaurant_id = m.restaurant_id
join  order_items oi on
oi.menu_id = m.menu_id
group by r.name ;

#64 Get top restaurant by orders
select r.name , count(distinct order_id)
from restaurants r join menu m on 
r.restaurant_id = m.restaurant_id
join order_items oi on
oi.menu_id = m.menu_id
group by r.name order by sum(order_id) desc;

#65 Find users with max orders
select u.name , count(distinct order_id) as total_orders
from users u join 
orders o on
u.user_id = o.user_id 
group by u.name ;

#66 Get item frequency
select item_name , count(order_id) as frequency
from menu m join
order_items oi on
m.menu_id = oi.menu_id
group by item_name;

#67 Join and use HAVING
select item_name , count(order_id) as frequency
from menu m join
order_items oi on
m.menu_id = oi.menu_id
group by item_name 
having count(order_id) >1;

#68 Join with subquery


#69 Join with window function
select r.name , r.restaurant_id , sum(price)  over(partition by r.name ) as revenue from
restaurants r 
join menu m on
r.restaurant_id = m.restaurant_id;
#group by r.name , r.restaurant_id;

#70 Join and filter NULL values Find menu items never ordered
select item_name , order_id 
from menu m left join
order_items oi on
oi.menu_id = m.menu_id 
where oi.order_id is null;
#71 Join and find unmatched records restaurants without menu items
select r.name , r.restaurant_id , item_name 
from restaurants r left join
menu m on 
r.restaurant_id = m.restaurant_id 
where item_name is null;

#72 Join using aliases
select m.item_name , count(oi.order_id) as frequency
from menu m join
order_items oi on
m.menu_id = oi.menu_id
group by m.item_name;

#73 Join and count items per order
select order_id , count(oi.menu_id) as total_count from 
order_items oi join
menu m on
m.menu_id = oi.menu_id
group by order_id;
 
#74 Join and sum quantities
select item_name , sum(quantity) from 
menu m join 
order_items oi on
oi.menu_id = m.menu_id 
group by item_name;

#75 Join and calculate average order
select item_name , avg(quantity * price) as average 
from menu m join 
order_items oi on
oi.menu_id = m.menu_id 
group by item_name;

#76 Join and get top users
select u.name , sum(quantity * price) as revenue from
users u join 
orders o on
u.user_id = o.user_id join 
order_items oi on
oi.order_id = o.order_id 
join menu m on
m.menu_id = oi.menu_id
group by u.name order by sum(quantity*price) desc ; 
#77 Join and filter by city
select u.address , u.name from
users u join
orders o on
u.user_id = o.order_id
order by address asc;

#78 Join and filter by rating
select distinct r.name , r.rating 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
order by r.rating desc;

#79 Join and use CASE Classify users based on total spending.
select u.name , sum(quantity * price) as total_amount ,
 case 
 when sum(quantity * price) > 400 then 'premium user'
 when sum(quantity * price) > 200 then 'noraml user'
 else 'rare user'
end as catergory
from users u 
join orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id 
join menu m on
m.menu_id = oi.menu_id
group by u.name ;
  
#80 Join and rank results
select r.name , sum(quantity * price)as revenue , rank() over(order by  sum(quantity * price) desc) as ranking 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
join
order_items oi on
m.menu_id = oi.menu_id
group by r.name ;

#81 Join and partition data average order per user
select u.name , avg(subtotal) over(partition by u.name ) as average 
from users u join
orders o on
u.user_id = o.user_id join
order_items oi on
o.order_id = oi.order_id;
#82 Join and sort descending 
select u.name , order_id 
from users u join
orders o on
o.user_id = u.user_id
order by order_id desc;
#83 Join and find duplicates same item ordered multiple times
select item_name , count(order_id) as total_count
from menu m join
order_items oi on
oi.menu_id = m.menu_id
group by item_name
having count(order_id) > 1;
#84 Join and remove duplicates
select distinct r.name , r.rating 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
order by r.rating desc;

#85 Join and use limit
select r.name , r.rating , sum(quantity * price) as revenue 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id 
group by r.rating , r.name 
order by revenue desc limit 3;

#86 Join and paginate results
select r.name , r.rating , sum(quantity * price) as revenue 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id 
group by r.rating , r.name 
order by r.rating desc limit 7 offset 3;
SELECT *
FROM menu
LIMIT 5 OFFSET 2;
#87 Join and group multiple columns
select u.name ,u.user_id , u.email ,u.address, sum(quantity * price) as revenue from
users u join 
orders o on
u.user_id = o.user_id join 
order_items oi on
oi.order_id = o.order_id 
join menu m on
m.menu_id = oi.menu_id
group by u.name ,u.user_id , u.email ,u.address order by sum(quantity*price) desc ; 

#88 Join and calculate percentages item sales percentage
select r.name , (sum(quantity * price) * 100 )/ 1040 as total_count 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id 
group by r.name;

#89 Join and compare values Find items priced above average price
select m.item_name,  avg(price) as total_count 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
group by m.item_name
having  avg(price) > (select avg(price) from menu);

#90 Join and filter top N top 5 users by spending
select u.name , sum(quantity * price) as bill
from users u join
orders o on
u.user_id = o.user_id 
join order_items oi on
o.order_id = oi.order_id 
join menu m on
oi.menu_id = m.menu_id
group by u.name order by bill desc limit 5;

#91 Join and use derived table
select 
    u.name,
    x.total_spending
from users u
join(select 
        o.user_id,
        sum(quantity * price) as total_spending
    from orders o
    join order_items oi
    on o.order_id = oi.order_id
    join menu m on
    oi.menu_id = m.menu_id
    group by o.user_id
) x on u.user_id = x.user_id;
#92 Join and nested query
select m.item_name,  avg(price) as total_count 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
group by m.item_name
having  avg(price) > (select avg(price) from menu);

#93 Join performance question
/* JOIN performance depends on:
- indexing
- table size
- join conditions
- filtering
- query structure
Performance can be improved using indexes, filtering rows early, and avoiding unnecessary joins.*/

#94 Join indexing scenario
/*Indexes should be created on:
- primary keys
- foreign keys
- JOIN columns
- WHERE columns
Example:
orders.user_id
order_items.order_id
order_items.menu_id*/

#95 Join execution plan question
/*EXPLAIN statement is used to analyze JOIN execution plans.
It shows:
- indexes used
- table scans
- join order
- estimated rows
Example:*/
EXPLAIN SELECT * FROM users u JOIN orders o ON u.user_id=o.user_id;

#96 Join optimization case
/*JOIN optimization techniques:
- use indexes
- avoid SELECT *
- filter rows early
- use proper JOIN conditions
- reduce unnecessary joins
- paginate large results*/

#97 Join large table scenario
/*For large tables:
- use indexing
- partition data
- paginate results
- optimize joins
- filter early
- avoid full table scans*/

#98 Join real-world 
/*Real-world JOIN example:
Find top restaurants by revenue using restaurants, menu, orders, and order_items tables.
JOINs help combine related business data from multiple tables.*/

#99 Join with multiple aggregations
select r.name , sum(quantity * price) as revenue , avg(quantity*price) as avg_price , max(price) as max_price 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id 
join order_items oi on
m.menu_id = oi.menu_id
group by r.name ;

#100 Complex join scenario
select r.name , sum(quantity * price) 
over(partition by r.name)
from restaurants r join 
menu m on 
r.restaurant_id = m.restaurant_id 
join order_items oi 
on m.menu_id = oi.menu_id ;
#group by r.name;
