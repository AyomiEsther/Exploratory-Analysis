#pulling all 500 rows of my data
SELECT * FROM jan_foods.orders_data;

#Using the aggregate function average to calculate average food rating and average delivery rating, using alias function to rename it
SELECT avg(customer_food_rating) AS avg_food_rating, avg(customer_delivery_rating) AS avg_delivery_rating
FROM orders_data;

#calculating the total item sold using the aggregate function sum
SELECT sum(Quantity_of_items) AS Total_item_sold
FROM orders_data;

#Joining my two tables in the database with inner join
SELECT * 
FROM orders_data od
inner join restaurant_details rd
on od.Restaurant_id = rd.Restaurant_id;

#count of customers with names and grouping by zone
With joined_table AS
(select RestaurantName,
cuisine,
Zone,
Category,
Mode_of_payment,
Order_amount,
customer_name,
quantity_of_items,
Time_taken_for_delivery_in_minutes
From orders_data od
inner join restaurant_details rd
on od.Restaurant_id = rd.Restaurant_id)
SELECT COUNT(distinct(Customer_name)) AS Total_order, Zone
From joined_table
group by Zone
order by COUNT(distinct(Customer_name)) desc;

#Most prefered payment mode by customers(was grouped into cash and card)
With Customer_payment_mode AS
(SELECT Mode_of_payment,
CASE 
When Mode_of_payment = "credit Card" then "card"
When Mode_of_payment = "debit Card" then "card"
else "cash"
end AS customer_payment_mode
From orders_data)
SELECT count(customer_payment_mode) AS "Count_payment_mode", customer_payment_mode
FROM customer_payment_mode
group by customer_payment_mode
order by count(customer_payment_mode) desc;

#Time which most orders was recieved
 With customer_order_time AS
 (SELECT order_time,
 CASE
 when order_time BETWEEN '00:00:00' AND '11:59:59' then "morning"
 when order_time BETWEEN '12:00:00' AND '17:59:59' then "afternoon"
 else "night"
 END AS customer_order_time 
 from orders_data)
 SELECT count(customer_order_time) AS "Count_order_time", customer_order_time
 From customer_order_time
 group by (customer_order_time)
 order by count(customer_order_time) desc;
 
 #Total order received per cuisine
 With second_joined_table AS
 (select RestaurantName, Cuisine, zone, category, Order_amount, Quantity_of_items, Time_taken_for_delivery_in_minutes
 from orders_data od
 inner join restaurant_details rd
 on od.restaurant_id = rd.restaurant_id)
 select sum(order_amount) AS total_order_received, cuisine
 from second_joined_table
 group by cuisine
 order by sum(order_amount) ASC;
 
 
 
 
 