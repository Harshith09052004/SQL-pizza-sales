/* =========================================================
   SQL Pizza Sales Analysis
   Author: Harshith Podduturi
   Description: Business insights derived from pizza sales data
========================================================= */


/* =========================================================
   BASIC LEVEL QUERIES
========================================================= */

/* 1. Total Number of Orders Placed */
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;


/* 2. Total Revenue Generated */
SELECT SUM(quantity * price) AS total_revenue
FROM pizza_sales;


/* 3. Highest Priced Pizza */
SELECT pizza_name, MAX(price) AS highest_price
FROM pizza_sales;


/* 4. Most Common Pizza Size Ordered */
SELECT size, COUNT(*) AS size_count
FROM pizza_sales
GROUP BY size
ORDER BY size_count DESC
LIMIT 1;


/* 5. Top 5 Most Ordered Pizza Types */
SELECT pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;



/* =========================================================
   INTERMEDIATE LEVEL QUERIES
========================================================= */

/* 6. Total Quantity Ordered Per Category */
SELECT category, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY category;


/* 7. Distribution of Orders by Hour */
SELECT HOUR(order_time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_hour
ORDER BY order_hour;


/* 8. Category-wise Distribution of Pizza Types */
SELECT category, COUNT(DISTINCT pizza_name) AS total_pizzas
FROM pizza_sales
GROUP BY category;


/* 9. Average Number of Pizzas Ordered Per Day */
SELECT AVG(daily_quantity) AS avg_pizzas_per_day
FROM (
    SELECT order_date,
           SUM(quantity) AS daily_quantity
    FROM pizza_sales
    GROUP BY order_date
) AS daily_data;


/* 10. Top 3 Pizza Types Based on Revenue */
SELECT pizza_name,
       SUM(quantity * price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 3;



/* =========================================================
   ADVANCED LEVEL QUERIES
========================================================= */

/* 11. Percentage Contribution of Each Category to Total Revenue */
SELECT category,
       SUM(quantity * price) AS revenue,
       ROUND(
           (SUM(quantity * price) /
            (SELECT SUM(quantity * price) FROM pizza_sales)) * 100,
           2
       ) AS revenue_percentage
FROM pizza_sales
GROUP BY category;


/* 12. Cumulative Revenue Over Time */
SELECT order_date,
       SUM(daily_revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM (
    SELECT order_date,
           SUM(quantity * price) AS daily_revenue
    FROM pizza_sales
    GROUP BY order_date
) AS revenue_data;


/* 13. Top 3 Pizza Types by Revenue Within Each Category */
SELECT *
FROM (
    SELECT category,
           pizza_name,
           SUM(quantity * price) AS revenue,
           RANK() OVER (
               PARTITION BY category
               ORDER BY SUM(quantity * price) DESC
           ) AS rank_position
    FROM pizza_sales
    GROUP BY category, pizza_name
) ranked_pizzas
WHERE rank_position <= 3;



/* =========================================================
   END OF ANALYSIS
========================================================= */
