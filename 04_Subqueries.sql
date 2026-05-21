#151 Find users with highest order
select u.name , sum(quantity * price)
from users u join
orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name order by sum(quantity * price) desc limit 1 ;

#152 Find second highest order
select u.name , sum(quantity * price)
from users u join
orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name order by sum(quantity * price) desc limit 1 ;

#153 Find users above average spend
select u.name , sum(oi.subtotal) as total_spending 
from users u join
orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name having sum(oi.subtotal) > 
 (select avg(total_spending) from
   (select  sum(subtotal) as total_spending 
  from orders o 
  join order_items oi 
  on o.order_id = oi.order_id
  group by o.user_id) x
  );

#154 Find items above average price
select item_name , price 
from menu where  price >
(select avg(price) as avg_amount from menu) ;

#155 Subquery in SELECT
select u.name , (select avg(subtotal) from order_items) 
as avg_total from users u;
 
#156 Subquery in WHERE
select item_name , price 
from menu where  price >
(select avg(price) as avg_amount from menu) ;

#157 Subquery in FROM
select  avg(total_spending) from
( select u.name ,sum(quantity*price) as total_spending 
from menu m join
order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
join users u on
o.user_id = u.user_id
group by  u.name ) x;



#158 Correlated subquery example
select item_name , price 
from menu where  price >
(select avg(price) as avg_amount from menu) ;

#159 Find max order per user
select customer_name , total_orders from 
( select u.name as customer_name ,count(oi.order_id) as total_orders from 
order_items oi join
orders o on
o.order_id = oi.order_id
join users u on
u.user_id = o.user_id
group by u.name )x ;

#160 Find users with no orders
select name 
from users 
 where user_id not in (select user_id from orders);

#161 EXISTS example
select name from users u where exists( select 1 order_id from orders o 
where u.user_id = o.user_id);

#162 NOT EXISTS example
select item_name from menu m where not exists
(select 1 order_id from order_items oi where m.menu_id= oi.menu_id);

#163 IN vs EXISTS
#IN example
select name
from users
where user_id in (
    select user_id
    from orders
);

# EXISTS example
select name
from users u
where exists (
    select 1
    from orders o
    where u.user_id = o.user_id
);
#164 Subquery with join
select customer_name , total_orders from 
( select u.name as customer_name ,count(oi.order_id) as total_orders from 
order_items oi join
orders o on
o.order_id = oi.order_id
join users u on
u.user_id = o.user_id
group by u.name )x ;

#165 Subquery with group
select restaurant_name , total_revenue from
( select r.name as restaurant_name ,sum(quantity*price) as total_revenue
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by r.name )x;

#166 Subquery with having
select restaurant_name , total_revenue from
( select r.name as restaurant_name ,sum(quantity*price) as total_revenue
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by r.name having sum(quantity * price) > 500 )x;

#167 Subquery with order
select restaurant_name , total_revenue from
( select r.name as restaurant_name ,sum(quantity*price) as total_revenue
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by r.name order by sum(quantity * price) desc)x;

#168 Subquery with limit
select restaurant_name , total_revenue from
( select r.name as restaurant_name ,sum(quantity*price) as total_revenue
from restaurants r join
menu m on
m.restaurant_id = r.restaurant_id
join order_items oi on
m.menu_id = oi.menu_id
join orders o on
o.order_id = oi.order_id
group by r.name order by sum(quantity * price) desc limit 3)x;

#169 Nested subqueries Find the user who placed the latest order using nested subqueries.
select name from users where user_id in
 (select user_id from orders where order_date = 
 (select max(order_date) from orders
 ) ) ;
 
#170 Scalar subquery
select item_name
from menu
where price > (select avg(price)from menu);

#171 Multi-row subquery
select item_name , menu_id , price
from menu
where price > (select avg(price)from menu);

#172 Subquery in update
update menu 
set price = price + 50 
where price < (select avg(price) from 
(select avg(price) as price from menu ) x
);
select price , item_name from menu;

#173 Subquery in delete
delete from users 
where user_id not in
(select user_id from orders);

#174 Subquery performance
select user_id from users 
where user_id  in
(select user_id from orders);

#175 Rewrite subquery as join
select distinct u.name , u.user_id  from 
users u join orders o on
o.user_id = u.user_id;

#176 Subquery optimization
select user_id from users
where user_id in (select user_id from orders);

#177 Subquery pitfalls
select name from users
where user_id = (select user_id from orders);
# so we use 'in' instead of '='

#178 Subquery execution plan
select name from users
where user_id in (select user_id from orders);

#179 Subquery with window
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
 
#180 Subquery complex scenario
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
 
#181 Derived table usage
select restaurant_name , total_revenue  from
(select r.name as restaurant_name , sum(quantity * price ) as total_revenue from restaurants r join 
 menu m on
 m.restaurant_id = r.restaurant_id 
 join order_items oi on
 m.menu_id = oi.menu_id 
 join orders o on
 o.order_id = oi.order_id 
 group by r.name ) x
 where total_revenue >
 (select avg(total_revenue) from
(select  sum(quantity * price) as total_revenue 
 from restaurants r join 
 menu m on
 m.restaurant_id = r.restaurant_id 
 join order_items oi on
 m.menu_id = oi.menu_id 
 join orders o on
 o.order_id = oi.order_id 
 group by r.name  ) y );
 
#182 Inline view
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
 
#183 Subquery with CASE
select order_id , no_of_orders, case 
 when no_of_orders > 1 then 'valued Coustomer '
 when no_of_orders =1 then 'normal coustomer'
 else 'not a coutmoer'
 end as category from
(select o.order_id as order_id , count(order_item_id) as no_of_orders
from orders o join 
order_items oi on
o.order_id = oi.order_id 
group by o.order_id ) x;
 
#184 Subquery with aggregation
select item_name , menu_id , price
from menu
where price > (select avg(price)from menu);

#185 Subquery with date
select order_id, order_date from orders
where order_date >= (SELECT DATE_SUB(MAX(order_date), INTERVAL 7 DAY)
    FROM orders
);
select dish_name ,  restaurant_name from( 
select m.item_name as dish_name , r.name as  restaurant_name from
 menu m join
 restaurants r on
 m.restaurant_id = r.restaurant_id 
 where  left(m.item_name,1) = left(r.name,1) )x ;
 
#186 Subquery with string
select dish_name ,  restaurant_name from( 
select m.item_name as dish_name , r.name as  restaurant_name from
 menu m join
 restaurants r on
 m.restaurant_id = r.restaurant_id 
 where  left(m.item_name,1) = left(r.name,1) )x ;
 
#187 Subquery with numeric
select item_name , price 
from menu where  price >
(select avg(price) as avg_amount from menu) ;

#188 Subquery real-world problem
select u.name ,oi.subtotal
from users u join 
orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
having oi.subtotal > (
select  avg_spent from(
select  avg(subtotal) as avg_spent 
from  order_items 
) x );

#189 Subquery debugging
select  name , user_id
from users 
where user_id in 
(
   select user_id
   from orders
);

#190 Subquery ranking
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
 
#191 Subquery filtering
select  name from users
WHERE user_id NOT IN (SELECT user_id FROM orders);

#192 Subquery grouping
select restaurant_name , total_revenue  from
(select r.name as restaurant_name , sum(quantity * price ) as total_revenue from restaurants r join 
 menu m on
 m.restaurant_id = r.restaurant_id 
 join order_items oi on
 m.menu_id = oi.menu_id 
 join orders o on
 o.order_id = oi.order_id 
 group by r.name ) x
 where total_revenue >
 (select avg(total_revenue) from
(select  sum(quantity * price) as total_revenue 
 from restaurants r join 
 menu m on
 m.restaurant_id = r.restaurant_id 
 join order_items oi on
 m.menu_id = oi.menu_id 
 join orders o on
 o.order_id = oi.order_id 
 group by r.name  ) y );
 
#193 Subquery ordering
select u.name , sum(quantity * price)
from users u join
orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name order by sum(quantity * price) desc ;

#194 Subquery top N
select u.name , sum(quantity * price)
from users u join
orders o on
u.user_id = o.user_id
join order_items oi on
o.order_id = oi.order_id
join menu m on
m.menu_id = oi.menu_id
group by u.name order by sum(quantity * price) desc limit 1 ;

#195 Subquery duplicates
select user_name , total_count from (
select  u.name as user_name , count(order_item_id) as total_count 
from users u join 
orders o on
u.user_id = o.user_id
join order_items oi on
oi.order_id = o.order_id
group by u.name  )x 
where total_count >1;

#196 Subquery nested join
select item_name , price 
from menu where  price >
(select avg(price) as avg_amount from menu) ;

#197 Subquery multi-condition
select restaurant_name,total_revenue,total_orders
from(select r.name as restaurant_name,sum(oi.quantity * m.price) as total_revenue,
count(distinct o.order_id) as total_orders
from restaurants r join menu m
on r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name
) x
where total_revenue >
(select avg(total_revenue)
from(select sum(oi.quantity * m.price) as total_revenue
from restaurants r
join menu m
on r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name
    ) y )
and total_orders >(select avg(total_orders)
from (select count(distinct o.order_id) as total_orders
from restaurants r
join menu m on r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name
) z );

#198 Subquery advanced logic
select u.name as user_name,
count(distinct m.restaurant_id) as total_restaurants
from users u join 
orders o on
u.user_id = o.user_id
join order_items oi
on o.order_id = oi.order_id
join menu m
on oi.menu_id = m.menu_id
group by u.name
having count(distinct m.restaurant_id) > 1;

#199 Subquery case study
select user_name, total_spent from(
select u.name as user_name,
sum(oi.subtotal) as total_spent
from users u join 
orders o on 
u.user_id = o.user_id
join order_items oi
on o.order_id = oi.order_id
group by u.name
) x
where total_spent = (select max(total_spent)
from (select sum(oi.subtotal) as total_spent
from users u join orders o
on u.user_id = o.user_id
join order_items oi
on o.order_id = oi.order_id
group by u.name
) y );

#200 Complex subquery problem
select restaurant_name from(select 
r.name as restaurant_name,
sum(oi.quantity * m.price) as total_revenue,
count(distinct o.order_id) as total_orders
from restaurants r
join menu m
on r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name
) x
where total_revenue >
(select avg(total_revenue)from(
select sum(oi.quantity * m.price) as total_revenue
from restaurants r
join menu m
on r.restaurant_id = m.restaurant_id
join order_items oi
on m.menu_id = oi.menu_id
join orders o
on oi.order_id = o.order_id
group by r.name
) y)
and total_orders > 5
and restaurant_name in
(select r.name
from restaurants r
join menu m
on r.restaurant_id = m.restaurant_id
where m.price >(select avg(price)from menu
));