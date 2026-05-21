#101 Count orders per user
select distinct u.name , count(order_item_id) as total
from users u join 
orders o on
u.user_id = o.user_id
join order_items oi on
oi.order_id = o.order_id
group by u.name ;

#102 Count items per order
select o.order_id ,  count(order_item_id )
from orders o join
order_items oi on
o.order_id = oi.order_id
group by o.order_id;

#103 Total sales per restaurant
select r.name , sum(quantity * price) as total_sales
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
group by r.name ;

#104 Average order amount per user
select u.name ,avg(total_amount) as avg_amount from users u
 join (select  o.user_id ,o.order_id , sum(oi.quantity*m.price) as total_amount from 
orders o join
order_items oi on
o.order_id = oi.order_id 
join menu m on
oi.menu_id = m.menu_id
group by o.order_id,o.user_id) x 
on u.user_id = x.user_id
group by u.name ;
 
#105 Max order per user
select u.name , sum(quantity * price) as total_order
from users u join
orders o on
u.user_id = o.user_id 
join order_items oi on
oi.order_id = o.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name 
order by max(quantity * price) desc limit 1;

#106 Min order per user
select u.name , sum(quantity * price) as total_order
from users u join
orders o on
u.user_id = o.user_id 
join order_items oi on
oi.order_id = o.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name 
order by max(quantity * price) asc limit 1;

#107 Group by restaurant
select r.name , r.restaurant_id , m.item_name 
from restaurants r join 
menu m on
r.restaurant_id = m.restaurant_id
group by r.name , r.restaurant_id, m.item_name;

#108 Group by city
select name , phone , email , address from users group by name ,phone , email,address;

#109 Group by item
select item_name , menu_id from 
menu group by menu_id ;

#110 Use HAVING count > 1
select m.item_name , m.price , sum(quantity) as total_quantity
from order_items oi join
menu m on
oi.menu_id = m.menu_id
group by  m.item_name, m.price
having sum(quantity) >1
order by total_quantity;

#111 Use HAVING sum > 300
select u.name , sum(quantity * price) as total
from users u join
orders o on 
o.user_id = u.user_id
join order_items oi on
oi.order_id = o.order_id
join menu m on
m.menu_id = oi.menu_id 
group by u.name having sum(quantity * price ) >300;

#112 Find top spending users
select u.name , sum(quantity * price) as total
from users u join
orders o on 
o.user_id = u.user_id
join order_items oi on
oi.order_id = o.order_id
join menu m on
m.menu_id = oi.menu_id 
group by u.name order by sum(quantity * price) desc;
#113 Find low spending users
select u.name , sum(quantity * price) as total
from users u join
orders o on 
o.user_id = u.user_id
join order_items oi on
oi.order_id = o.order_id
join menu m on
m.menu_id = oi.menu_id 
group by u.name order by sum(quantity * price) asc;

#114 Find restaurants with highest sales
select r.name  , sum(quantity * price) as total
from restaurants r join
menu m on 
r.restaurant_id = m.restaurant_id 
join order_items oi on
oi.menu_id = m.menu_id
group by r.name  order by sum(quantity * price) desc;

#115 Find least popular items
select m.item_name , count(oi.order_id) total_count 
from menu m left join
order_items oi on
oi.menu_id = m.menu_id
group by m.item_name order by count(oi.order_id) asc limit 3;

#116 Group and sort
select r.name  , sum(quantity * price) as total
from restaurants r join
menu m on 
r.restaurant_id = m.restaurant_id 
join order_items oi on
oi.menu_id = m.menu_id
group by r.name  order by sum(quantity * price) asc;

#117 Group multiple columns
select name , phone , email , address from users group by name ,phone , email,address;

#118 Group and join
select m.item_name , sum(quantity) as total_quantity 
from menu m
join 
order_items oi on
m.menu_id = oi.menu_id group by m.item_name ;

#119 Group and subquery
select u.name , sum(total_amount) as total_spent 
from users u join 
orders o on
o.user_id = u.user_id group by u.name 
having sum(total_amount) > (
select avg(total_amount) from orders);

#120 Group and window
select r.name , sum(quantity * price) as revenue , 
rank() over(order by sum(quantity * price) desc )
as rankinng  
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
join order_items oi on
oi.menu_id = m.menu_id
group by r.name;

#121 Find duplicate users
select name , phone , email , count(*) 
as duplicate from users group by name, 
phone , email having count(phone) >1;

#122 Remove duplicates using group
select distinct order_id , item_name
from menu m join 
order_items oi on
oi.menu_id = m.menu_id ;
 
#123 Count distinct users
select count(distinct user_id) as no_of_users from users ;

#124 Sum subtotal per order
select order_id , sum(quantity * price) as tootal_amount_order
from order_items oi join 
menu m on
oi.menu_id = m.menu_id 
group by order_id order by order_id asc;

#125 Average item price per restaurant
select r.name , avg(price) as avg_price  from 
restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
group by r.name ;

select item_name , price from menu;

#126 Group and filter date
#127 Monthly sales
select r.name , sum(oi.quantity * m.price) as revenue 
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by month(o.order_date),r.name ;

#128 Yearly sales
select  sum(oi.quantity * m.price) as revenue 
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by year(o.order_date);

#129 Group by hour
select r.name ,HOUR(o.order_date) AS order_hour, sum(oi.quantity * m.price) as revenue 

from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by hour(o.order_date),r.name ,order_hour ;

#130 Group and use CASE
select u.name , sum(subtotal),
case 
    when sum(subtotal)  > 500 then 'Regular Costomer'
    when sum(subtotal) > 300 then 'weekly costomer'
    else 'rare coustomer'
    end as category 
from users u join
orders o on 
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
group by u.name;
    
#131 Conditional aggregation
select u.name , 
		sum(case when oi.subtotal >= 300 then 1 else 0 end) as high_valued_coustomer ,
        sum(case when oi.subtotal < 300 then 1 else 0 end ) as healthy_coustomer 
from users u join
orders o on
u.user_id = o.user_id 
join order_items oi on
oi.order_id = o.order_id 
group by u.name ;


#132 Count items > 200 price
select item_name , price  from menu 
group by item_name , price having price >200;

#133 Find users with more than 2 orders
select u.name , count(distinct oi.order_id) as total_orders
from users u join 
orders o on
u.user_id  = o.user_id
join order_items oi on
o.order_id = oi.order_id 
group by u.name having count(oi.order_id) >2;

#134 Find restaurants with more than 5 items
select r.name , count(item_name) as total_items 
from restaurants r join
menu m on
r.restaurant_id = m.restaurant_id
group by r.name having count(item_name) >2;

#135 Group and use ranking
select u.name , sum(quantity * price) as amount_spent , 
rank() over(order by sum(quantity* price) desc)
as ranking from users u join
orders o on
u.user_id = o.user_id 
join order_items oi on
o.order_id = oi.order_id 
join menu m on
oi.menu_id = m.menu_id 
group by u.name;

#136 Group and use limit
select m.item_name , count(oi.order_id) total_count 
from menu m left join
order_items oi on
oi.menu_id = m.menu_id
group by m.item_name order by count(oi.order_id) asc limit 3;

#137 Group and derived table
select avg(x.total_sales) as avg_revenue
from (select r.name,sum(oi.subtotal) as total_sales
    from restaurants r join 
    menu m on 
    r.restaurant_id = m.restaurant_id
    join order_items oi
    on m.menu_id = oi.menu_id
    group by r.name
) x;

#138 Group and nested query
select r.name,sum(oi.subtotal) as revenue
from restaurants r join 
menu m on 
r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
group by r.name
having sum(oi.subtotal) > (
    select avg(subtotal) from order_items);
    
#139 Group performance scenario
select r.name,sum(oi.subtotal) as revenue
from restaurants r join
 menu m on 
 r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
group by r.name;

#140 Group optimization
select r.name , sum(oi.subtotal) as revenue
from restaurants r join 
menu m on 
r.restaurant_id = m.restaurant_id
join order_items oi on
 m.menu_id = oi.menu_id
group by r.name;

#141 Group vs window
select r.name, sum(oi.subtotal) as total_sales,
rank() over(order by sum(oi.subtotal) desc) as ranking
from restaurants r join 
menu m on 
r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
group by r.name;

#142 Group edge cases
select address,count(*) as total_users from users group by address;

#143 Group with NULL values
select address, count(*) as total_users
from users group by address;

#144 Group large dataset
select r.name, sum(oi.subtotal) as revenue
from restaurants r join 
menu m on 
r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
where oi.subtotal > 100
group by r.name;

#145 Group and partition
select distinct r.name ,  sum(price)  over(partition by r.name ) as revenue from
restaurants r 
join menu m on
r.restaurant_id = m.restaurant_id;


#146 Group and cumulative sum

#147 Group and difference
select o.order_id, oi.subtotal,
sum(oi.subtotal) over(order by o.order_id)
as cumulative_total
from orders o join 
order_items oi
on o.order_id = oi.order_id;

#148 Group complex problem
select r.name,count(distinct o.order_id) as total_orders,
sum(oi.subtotal) as revenue,avg(oi.subtotal) as avg_order
from restaurants r join 
menu m on
 r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name
having revenue > 500;

#149 Group advanced scenario
select u.address,count(distinct u.user_id) as total_users,
sum(oi.subtotal) as total_sales
from users u join 
orders o on 
u.user_id = o.user_id
join order_items oi
on o.order_id = oi.order_id
group by u.address;

#150 Group real-world case
select r.name,month(o.order_date) as sales_month,
sum(oi.subtotal) as monthly_revenue
from restaurants r
join menu m on 
r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name, month(o.order_date);