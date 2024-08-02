
-- Intermediate:
-- Q1

-- 	Join the necessary tables to find the total quantity of each pizza category ordered.

			SELECT 
    pt.category, SUM(od.quantity) AS Total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY Total_quantity DESC; 






-- Q2

-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(o.order_time) AS 'Hour', COUNT(order_id) AS Order_count
FROM
    orders o
GROUP BY HOUR(o.order_time); 








-- Q3
-- 	Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) AS Pizza_types
FROM
    pizza_types
GROUP BY category





-- Q4

--  Group the orders by date and calculate the average number of pizzas ordered per day.
select

SELECT 
    ROUND(AVG(quantity), 0) as "AVg of pizzas ordered per day"
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS quantity
    FROM
        orders o
    JOIN order_details od ON od.order_id = o.order_id
    GROUP BY o.order_date) AS order_qty;






-- Q5
-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, ROUND(SUM(od.quantity * p.price), 0) AS revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

