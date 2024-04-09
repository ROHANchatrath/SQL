CREATE DATABASE IF NOT EXISTS FoodDeliveryApp;

/* Count of distinct food items ordered */
SELECT 
    COUNT(DISTINCT name) AS distinct_food_items_ordered
FROM
    items
LIMIT 1000;

/* Group vegetarian and meat items together */
SELECT 
    CASE 
        WHEN is_veg = 1 THEN 'Vegetarian'
        ELSE 'Non-Vegetarian'
    END AS item_type,
    COUNT(name) AS item_count
FROM
    items
GROUP BY item_type;

/* Vegetarian items only */
SELECT 
    *
FROM
    items
WHERE
    is_veg = 1;

/* Items with 'Chicken' in the name */
SELECT 
    *
FROM
    items
WHERE
    name LIKE '%Chicken%';

/* Items with 'Paratha' in the name */
SELECT 
    *
FROM
    items
WHERE
    name LIKE '%Paratha%';

/* Average items per order */
SELECT 
    COUNT(name) / COUNT(DISTINCT order_id) AS avg_items_per_order
FROM
    items;

/* Most frequently ordered items */
SELECT 
    name AS item_name, 
    COUNT(*) AS order_count
FROM
    items
GROUP BY item_name
ORDER BY order_count DESC;

/* Distinct rainy items */
SELECT DISTINCT
    rain_mode
FROM
    orders
LIMIT 1000;

/* Count of unique restaurant names */
SELECT 
    COUNT(DISTINCT restaurant_name) AS unique_restaurant_count
FROM
    orders
LIMIT 1000;

/* Restaurants with the most orders */
SELECT 
    restaurant_name,
    COUNT(*) AS order_count
FROM
    orders
GROUP BY restaurant_name
ORDER BY order_count DESC;

/* Orders placed per month and year */
SELECT 
    DATE_FORMAT(order_time, '%Y-%m') AS month_year,
    COUNT(DISTINCT order_id) AS order_count
FROM
    orders
GROUP BY month_year
ORDER BY order_count DESC;

/* Revenue made by month */
SELECT 
    MAX(order_time) AS last_order_date
FROM
    orders;

SELECT 
    DATE_FORMAT(order_time, '%Y-%m') AS month_year,
    SUM(order_total) AS total_revenue
FROM
    orders
GROUP BY month_year
ORDER BY total_revenue DESC;

/* Average Order Value */
SELECT 
    SUM(order_total) / COUNT(DISTINCT order_id) AS average_order_value
FROM
    orders;

/* Year-over-Year change in revenue using lag function and ranking highest year */
SELECT 
    DATE_FORMAT(order_time, '%Y') AS year,
    SUM(order_total) AS revenue,
    LAG(SUM(order_total)) OVER (ORDER BY year) AS previous_year_revenue
FROM
    orders
GROUP BY year;

/* Ranking of revenue by year */
WITH yearly_revenue AS (
    SELECT 
        DATE_FORMAT(order_time, '%Y') AS year,
        SUM(order_total) AS revenue
    FROM
        orders
    GROUP BY year
)
SELECT 
    year,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_ranking
FROM
    yearly_revenue;

/* Restaurants with the highest revenue ranking */
WITH restaurant_revenue AS (
    SELECT 
        restaurant_name,
        SUM(order_total) AS revenue
    FROM
        orders
    GROUP BY restaurant_name
)
SELECT 
    restaurant_name,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_ranking
FROM
    restaurant_revenue
ORDER BY revenue DESC;

/* Find product combinations using self join */
SELECT 
    a.name AS item_name,
    a.is_veg AS is_vegetarian,
    b.restaurant_name AS restaurant_name,
    b.order_id AS order_id,
    b.order_time AS order_time
FROM
    items a
    JOIN orders b ON a.order_id = b.order_id;

/* Find product combinations (excluding identical items) using self join */
SELECT 
    a.order_id AS order_id,
    a.name AS first_item_name,
    b.name AS second_item_name,
    CONCAT(a.name, '-', b.name) AS product_combination
FROM
    items a
    JOIN items b ON a.order_id = b.order_id
WHERE
    a.name < b.name;

