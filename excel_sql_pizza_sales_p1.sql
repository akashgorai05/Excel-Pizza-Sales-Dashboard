DROP TABLE IF EXISTS pizza_sales;
CREATE TABLE pizza_sales(
pizza_id int,
order_id int,
pizza_name_id varchar(50),	
quantity int,
order_date varchar(20),
order_time varchar(20),
unit_price numeric(10,2),
total_price	numeric(10,2),
pizza_size varchar(10),
pizza_category varchar(50),
pizza_ingredients varchar(225),	
pizza_name varchar(100)
)

SELECT*FROM pizza_sales

--KPI--

--total revenue

SELECT
	ROUND(SUM(total_price)::numeric,2) AS total_revenue
FROM pizza_sales

--average order value

SELECT
	ROUND(SUM(total_price)/COUNT(DISTINCT order_id)::numeric,2) AS avg_order_value
FROM pizza_sales

--total pizzas sold

SELECT	
	SUM(quantity) AS total_sold
FROM pizza_sales

--total orders

SELECT
	COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales

--average pizza per order

WITH cte AS(
SELECT
	order_id,
	sum(quantity) AS total_quantity
FROM pizza_sales
GROUP BY 1
)
SELECT
	ROUND(AVG(total_quantity)) AS avg_pizza
FROM cte

--CHARTS REQUIREMENT

--daily trend for total orders

SELECT
	TO_CHAR(TO_DATE(order_date,'DD-MM-YYYY'),'FMday') AS day,
	COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC

--hourly trend for total orders

SELECT
	EXTRACT(HOUR FROM order_time::time) AS time,
	COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC

--percentage of sales by pizza category

WITH category_sale AS(
SELECT
	pizza_category,
	ROUND(SUM(total_price),2) AS total_revenue,
	ROUND((SUM(total_price)/SUM(SUM(total_price)) OVER()*100),2) AS percent
FROM pizza_sales
GROUP BY 1












