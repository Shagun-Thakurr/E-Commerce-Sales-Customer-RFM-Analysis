CREATE DATABASE ECOMMERCE;
USE ecommerce;

SELECT COUNT(*) FROM ecommerce_sales;

SELECT * FROM ecommerce_sales LIMIT 5;

-- Checking Null values
SELECT COUNT(*)
FROM ecommerce_sales
WHERE `Customer ID` IS NULL;

-- Updating Datatype of Order date & Ship date 
SET SQL_SAFE_UPDATES = 0;

UPDATE ecommerce_sales 
SET `Order Date` = STR_TO_DATE(REPLACE(`Order date`, '/', '-'), '%m-%d-%Y'),
    `Ship Date` = STR_TO_DATE(REPLACE(`Ship date`, '/', '-'), '%m-%d-%Y');

ALTER TABLE ecommerce_sales 
MODIFY COLUMN `Order Date` DATE,
MODIFY COLUMN `Ship Date` DATE;
    

-- Total Orders
SELECT COUNT(`Order ID`) AS total_orders 
FROM ecommerce_sales ;

-- Average Order Value
SELECT AVG(Sales) AS average_order_value 
FROM ecommerce_sales;

-- Total Sales & Profit
SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales;
-- INSIGHTS:
-- Total Sales is around $2.27M
-- Total Profit is around $282K
-- Overall profit margin is moderate, not very high.
-- Business needs to focus on improving margins.

-- Sales by Region 
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Profit by Region-- 
SELECT 
region,
SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY region
ORDER BY total_profit DESC;
-- The West region generates the highest overall profit.
-- East and South regions show stable and consistent profitability.
-- However, the Central region records the lowest profit, indicating potential operational or pricing challenges that may require further investigation.

-- Sales by Category 
select category,sum(sales) as total_sales from ecommerce_sales
group by category
order by total_sales desc;
-- Technology leads in sales, followed by Furniture and Office Supplies. Customers prefer buying Technology products the most.

-- Top 10 Customers
select
`Customer Name`, 
sum(sales) as total_sales
from ecommerce_sales
group by `Customer Name`
order by total_sales desc
limit 10;


-- Monthly Sales Trend
SELECT 
YEAR(`Order Date`) AS year,
MONTH(`Order Date`) AS month,
SUM(sales) AS monthly_sales
FROM ecommerce_sales
GROUP BY year, month
ORDER BY year, month;

-- Most Profitable Category
SELECT 
category,
SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY category
ORDER BY total_profit DESC
LIMIT 1;
-- Technology category is most profitable.


-- Top 10 Profitable product Name
SELECT 
`Product Name`,
SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY `Product Name`
HAVING total_profit < 0
ORDER BY total_profit limit 10 ;

-- Top 10 Customers by Revenue 
SELECT 
    `Customer ID`,
    `Customer Name`,
    SUM(Sales) AS total_revenue
FROM ecommerce_sales
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_revenue DESC
LIMIT 10;
-- High-value customers contribute a major share of total revenue and should be prioritized for retention.


-- Average Order Value per Customer 
SELECT 
    `Customer ID`,
    `Customer Name`,
    SUM(Sales) AS total_sales,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    SUM(Sales) / COUNT(DISTINCT `Order ID`) AS avg_order_value
FROM ecommerce_sales
GROUP BY `Customer ID`, `Customer Name`
ORDER BY avg_order_value DESC;
-- Increasing order value per customer can significantly boost overall revenue.

-- Order Per Customer (Frequency)
SELECT 
    `Customer ID`,
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS order_frequency
FROM  ecommerce_sales
GROUP BY `Customer ID`, `Customer Name`
ORDER BY order_frequency DESC limit 10 ;
-- Frequent buyers show strong engagement and offer opportunities for repeat sales strategies.

-- Profit Margin % by Category 
SELECT 
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM ecommerce_sales
GROUP BY Category
ORDER BY profit_margin_percent DESC;

-- Running Total Sales
SELECT 
    `Order Date`,
    SUM(Sales) AS daily_sales,
    SUM(SUM(Sales)) OVER (ORDER BY `Order Date`) AS running_total_sales
FROM ecommerce_sales
GROUP BY `Order Date`
ORDER BY `Order Date`;

-- Rank Customers Using RANK function
SELECT 
    `Customer ID`,
    `Customer Name`,
    SUM(Sales) AS total_revenue,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS revenue_rank
FROM ecommerce_sales
GROUP BY `Customer ID`, `Customer Name` limit 5;













