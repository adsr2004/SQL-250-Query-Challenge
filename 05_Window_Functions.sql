#201 assign row number to orders
select order_id , total_amount , row_number() over(order by order_id) as row_numbers from  orders;

#202 rank users by spending
select  u.name , sum(subtotal) as total_spending , 
rank() over( order by sum(subtotal) desc) as ranking
from users u join
orders o on
o.user_id = u.user_id
join order_items oi on
oi.order_id = o.order_id
group by u.name ;

#203 dense rank users
select u.name,sum(oi.subtotal) as total_spending,dense_rank() over(order by sum(oi.subtotal) desc) as dense_ranking
from users u
join orders o
on u.user_id = o.user_id
join order_items oi
on oi.order_id = o.order_id
group by u.name;

#204 partition by user
select  u.name,oi.subtotal,order_date ,row_number() 
over( partition by u.user_id order by oi.order_id desc) as row_num
from users u
join orders o
on u.user_id = o.user_id
join order_items oi
on oi.order_id = o.order_id
;

#205 running total of orders
select  order_id,order_date,total_amount,
sum(total_amount) over(order by order_date) as running_total
from orders;

#206 moving average of orders
select  order_id,order_date,total_amount,
avg(total_amount) over(order by order_date) as running_average
from orders;

#207 lead function for next order
select order_id , order_date , lead(total_amount) 
 over(order by order_date ) as next_order_amount 
 from orders;
 
#208 lag function for previous order
select order_id , order_date , lag(total_amount) 
 over(order by order_date ) as previous_order_amount 
 from orders;
 
#209 first order per user
select * from(
select u.name as user_name ,o.order_id , o.order_date ,
row_number() over( partition by u.user_id order by o.order_date asc) as row_num
from users u join 
orders o on
o.user_id= u.user_id
)x
where row_num =1;

#210 last order per user
select * from (
select u.name as user_name , o.order_id , o.order_date ,
row_number() over(partition by u.user_name order by o.order_date desc ) as row_num
from users u join
orders o on
u.user_id = o.user_id) x
where row_num =1;

#211 top 3 items per restaurant

select * from(select r.name as restaurant_name,m.item_name,m.price,
row_number() over(partition by r.restaurant_id
order by m.price desc) as ranking
from restaurants r
join menu m on r.restaurant_id = m.restaurant_id
) x
where ranking <= 3;

#212 remove duplicates using row_number
select * from (select user_id,order_id,order_date,
row_number() over(partition by user_id order by order_date desc) as row_num
from orders) x
where row_num = 1;

#213 gap and island problem
select order_id,order_date,
lag(order_date) over(
order by order_date
) as previous_order_date
from orders;

#214 session analysis
select user_id,order_id,order_date,
lag(order_date) over(
partition by user_id
order by order_date
) as previous_order
from orders;

#215 window with join
select distinct r.name , r.restaurant_id , sum(price)  over(partition by r.name ) as revenue from
restaurants r 
join menu m on
r.restaurant_id = m.restaurant_id;
#group by r.name , r.restaurant_id;

#216 window with group
select distinct r.name ,  sum(price)  over(partition by r.name ) as revenue from
restaurants r 
join menu m on
r.restaurant_id = m.restaurant_id;

#217 window with subquery
select restaurant_name , total_revenue  , rank() over( order by total_revenue) as ranking from 
(select r.name as restaurant_name,sum(Quantity * price) as total_revenue 
 from restaurants r join 
 menu m on
 m.restaurant_id = r.restaurant_id 
 join order_items oi on
 m.menu_id = oi.menu_id 
 join orders o on
 o.order_id = oi.order_id 
 group by r.name )x;
 
#218 window with cte
with user_spending as(select u.name as user_name,
sum(oi.subtotal) as total_spending
from users u
join orders o
on u.user_id = o.user_id
join order_items oi
on oi.order_id = o.order_id
group by u.name
)
select
user_name,
total_spending,
rank() over(
order by total_spending desc
) as ranking
from user_spending;

#219 window performance
select order_id,total_amount,
rank() over(order by total_amount desc) as ranking
from orders;

#220 window optimization
with filtered_orders as(select o.user_id,oi.subtotal
from orders o
join order_items oi
on oi.order_id = o.order_id
where oi.subtotal > 100
)
select user_id,subtotal,
rank() over(partition by user_id
order by subtotal desc) as ranking
from filtered_orders;

#221 window partitioning
select distinct r.name ,  sum(price)  over(partition by r.name ) as revenue from
restaurants r 
join menu m on
r.restaurant_id = m.restaurant_id;

#222 window sorting
select restaurant_name , total_revenue  , rank() over( order by total_revenue) as ranking from 
(select r.name as restaurant_name,sum(Quantity * price) as total_revenue 
 from restaurants r join 
 menu m on
 m.restaurant_id = r.restaurant_id 
 join order_items oi on
 m.menu_id = oi.menu_id 
 join orders o on
 o.order_id = oi.order_id 
 group by r.name )x;
 
#223 window frame clause
SELECT order_id,total_amount,SUM(total_amount) OVER(
ORDER BY order_id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
AS moving_total FROM Orders;

#224 window ranking
select order_id,total_amount,
rank() over(order by total_amount desc) as ranking
from orders;

#225 window aggregation
select u.name,sum(oi.subtotal) as total_spending,rank() over(order by sum(oi.subtotal) desc) as dense_ranking
from users u
join orders o
on u.user_id = o.user_id
join order_items oi
on oi.order_id = o.order_id
group by u.name;

#226 window cumulative sum
SELECT order_id,total_amount,
SUM(total_amount) OVER(ORDER BY order_id) 
AS cumulative_sum
FROM Orders;

#227 window difference
SELECT order_id,total_amount,total_amount -
LAG(total_amount)OVER(ORDER BY order_id) 
AS difference
FROM Orders;

#228 window with date
SELECT user_id,order_id,order_date,
LAG(order_date) OVER (
PARTITION BY user_id
ORDER BY order_date) AS previous_order_date
FROM Orders;

#229 window with string
SELECT restaurant_id,
item_name,LAG(item_name) OVER (PARTITION BY restaurant_id
ORDER BY item_name) AS previous_item
FROM Menu;

#230 window with numeric
SELECT user_id,order_id,total_amount,
SUM(total_amount) OVER (PARTITION BY user_id
ORDER BY order_id) AS running_total
FROM Orders;

#231 window with case
SELECT user_id,order_id,total_amount,
SUM(total_amount) OVER (
PARTITION BY user_id
ORDER BY order_id) AS running_total,
CASE
	WHEN SUM(total_amount) OVER (
	PARTITION BY user_id
	ORDER BY order_id
	) > 300 THEN 'High Spender'
        
	WHEN SUM(total_amount) OVER (
	PARTITION BY user_id
	ORDER BY order_id
	) > 200 THEN 'Medium Spender'
	ELSE 'Low Spender'
    END AS spender_category
FROM Orders;

#232 window filtering
select * from (select user_id,order_id,total_amount,
rank() over (partition by user_id 
order by total_amount desc) as rnk
from orders) x
where rnk = 1;

#233 window advanced problem


select * from (select user_id,order_id,order_date,
lag(order_date) over (partition by user_id order by order_date) 
as previous_order_date from orders
) x
where datediff(order_date, previous_order_date) = 1;

#234 window real-world case
select user_id,order_id,total_amount,
avg(total_amount) over (partition by user_id)
 as avg_user_spending from orders;
 
#235 window analytics
select restaurant_id,menu_id,price,
dense_rank() over (partition by restaurant_id
order by price desc) as price_rank
from menu;

#236 window debugging
select * from (
select user_id,order_id,total_amount,
row_number() over (
partition by user_id
order by total_amount desc) as rn
from orders) x
where rn <= 2;

#237 window execution plan
explain select user_id,order_id,
sum(total_amount) over(
partition by user_id
order by order_id ) as running_total
from orders;

#238 window vs group by
select user_id,order_id,total_amount,
avg(total_amount) over(partition by user_id) as avg_amount
from orders;

#239 window vs subquery
select o.user_id,o.order_id,o.total_amount,(
select avg(total_amount)from orders
where user_id=o.user_id) as avg_amount
from orders o;

#240 window edge cases
select user_id,order_id,total_amount,
lag(total_amount) over(partition by user_id
order by order_id) as previous_amount
from orders;

#241 window large dataset
select user_id,order_id,total_amount,
sum(total_amount) over(partition by user_id
order by order_id) as running_total
from orders;

#242 window partition multiple columns
select restaurant_id,menu_id,price,
rank() over(partition by restaurant_id
order by price desc) as rnk
from menu;

#243 window nested query
select *from(
select user_id,order_id,total_amount,
dense_rank() over(partition by user_id
order by total_amount desc) as rnk
from orders) x
where rnk<=3;

#244 window derived table
select user_id,avg(running_total) as avg_running_total
from(select user_id,sum(total_amount) over(
partition by user_id
order by order_id) as running_total
from orders) x
group by user_id;

#245 window alias usage
select *from(
select user_id,order_id,total_amount,
row_number() over(partition by user_id
order by total_amount desc) as rn
from orders) x
where rn=1;

#246 window duplicate handling
select user_id,order_id,total_amount,
dense_rank() over(partition by user_id
order by total_amount desc) as rnk
from orders;

#247 window top n per group
select *from(
select restaurant_id,menu_id,price,
rank() over(partition by restaurant_id
order by price desc) as rnk
from menu) x
where rnk<=3;

#248 window ranking tie handling
select user_id,order_id,total_amount,
rank() over(partition by user_id
order by total_amount desc) as rnk,
dense_rank() over(
partition by user_id order by total_amount desc) as dense_rnk
from orders;

#249 window optimization scenario
select user_id,order_id,total_amount,
sum(total_amount) over(partition by user_id order by order_id
rows between unbounded preceding and current row
) as running_total from orders;

#250 complex window function problem
select *from(select user_id,order_id,order_date,total_amount,
lag(total_amount) over(partition by user_id order by order_date) as previous_amount
from orders) x where total_amount>previous_amount;
