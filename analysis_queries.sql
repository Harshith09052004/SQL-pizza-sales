-- Total Revenue
SELECT SUM(quantity * price) AS total_revenue
FROM pizza_sales;

-- Top 5 Best Selling Pizzas
SELECT pizza_name, SUM(quantity) AS total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC
LIMIT 5;

-- Revenue by Category
SELECT category, SUM(quantity * price) AS revenue
FROM pizza_sales
GROUP BY category;

-- Daily Sales Trend
SELECT order_date, SUM(quantity * price) AS daily_revenue
FROM pizza_sales
GROUP BY order_date
ORDER BY order_date;
