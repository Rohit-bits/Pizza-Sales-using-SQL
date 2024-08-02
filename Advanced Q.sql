-- Advanced: --
-- Q1
-- Calculate the percentage contribution of each pizza type to total revenue.


SELECT 
    pt.category,
    CONCAT(ROUND(SUM(od.quantity * p.price) / (SELECT 
                            SUM(od.quantity * p.price) AS Total_revenue
                        FROM
                            pizzas p
                                JOIN
                            order_details od ON p.pizza_id = od.pizza_id) * 100,
                    2),
            '%') AS Total_revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY Total_revenue DESC;





SELECT 
    pt.category,
    CONCAT(ROUND(SUM(od.quantity * p.price) / (SELECT 
                            SUM(od.quantity * p.price) AS Total_revenue
                        FROM
                            pizzas p
                                JOIN
                            order_details od ON p.pizza_id = od.pizza_id) * 100,
                    2),
            '%') AS Total_revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY Total_revenue DESC;





-- By using CTE 

with Total_Revenue_CTE as (
SELECT 
    SUM(od.quantity * p.price) as Total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
),

Category_Revenue_CTE as (
SELECT 
    pt.category, SUM(od.quantity * p.price) AS Category_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
)
select cr.category, concat(round(cr.category_revenue / tr.total_revenue * 100,2), "%") as "Total Revenue %"
from category_revenue_cte cr, total_revenue_cte tr







-- Q2
        --  -- Analyze the cumulative revenue generated over time. --
select         
  
  
  
select order_date, round(sum(revenue) over (order by order_date),2) as Cum_revenue from
(SELECT 
    o.order_date, SUM(p.price * od.quantity) AS Revenue
    FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
        JOIN
    orders o ON o.order_id = od.order_id
GROUP BY o.order_date) AS Sales
       
       


-- Q3 
-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.



select category, name, Revenue from
(select category, name, Revenue, 
rank() over(partition by category order by Revenue Desc) as Rank_No from 
(SELECT 
    pt.category, pt.name, SUM(p.price * od.quantity) AS Revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category , pt.name) as A) as B
where Rank_no <= 3;


   -- By using cte
with cte as (
select category, name, Revenue, 
rank() over(partition by category order by Revenue Desc) as Rank_No from 
(select pt.category, pt.name, sum(p.price * od.quantity) as Revenue from pizza_types pt join pizzas p
on pt.pizza_type_id = p.pizza_type_id join order_details od 
on od.pizza_id = p.pizza_id
group by pt.category, pt.name) as abc)

select name, revenue from cte 
where Rank_no <= 3;



  -- BY Using CTE with two tables (CTE_A, CTE_B)

With CTE_A as (
SELECT 
    pt.category, pt.name, SUM(p.price * od.quantity) AS Revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.Category , pt.name ),
CTE_B as (
select *, RANK() OVER(partition by category order by revenue DESC) as Rank_no from CTE_A 
)
SELECT 
    B.category, B.name, B.revenue
FROM
    CTE_B B
WHERE
    Rank_no <= 3;
