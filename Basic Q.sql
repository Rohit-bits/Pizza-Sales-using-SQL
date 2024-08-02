-- Basic --
-- Question 1 --

           --- Retrieve the total number of orders placed. ---

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders
 
 
 
 
 
 
-- Question 2 --
              -- Calculate the total revenue generated from pizza sales. --

select

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS Total_revenue_generated
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id

 
 
 
 
 
 
 
--  Question 3
--                        Identify the highest-priced pizza.



SELECT 
    pt.name AS 'Name', p.price 'Price'
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1; 
 
 
 
 
 
 

 -- Question 4 --
                  -- Identify the most common pizza size ordered. --
 
SELECT 
    p.size AS 'Size', COUNT(od.order_id) AS 'Quantity_ordered'
FROM
    order_details od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
GROUP BY Size
ORDER BY Quantity_ordered DESC ;






	
 -- Question 5 --
 -- List the top 5 most ordered pizza types along with their quantities. --
 
SELECT 
    pt.name, SUM(od.quantity) AS 'Quantity'
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5;


 
 
