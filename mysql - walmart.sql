show databases;
CREATE DATABASE walmart_db;
use walmart_db;
show tables;

SELECT * FROM walmart;

SELECT COUNT(*) FROM walmart;
SELECT * FROM walmart limit 10;
SELECT DISTINCT payment_method FROM walmart;

SELECT payment_method,COUNT(*)
FROM walmart
GROUP BY payment_method
ORDER BY COUNT(*) DESC ;



SELECT COUNT(DISTINCT branch) FROM walmart;


-- Business problems
-- q1. Find different payment method and number of transactions, number of qty sold

SELECT payment_method, COUNT(*) AS num_of_payments, SUM(quantity) AS num_qty_sold
FROM walmart
GROUP BY payment_method
ORDER BY num_of_payments, num_qty_sold asc;

-- q2.Identify the highest-rated catgeory, in each branch, displaying the branch, category, avg rating

SELECT * FROM
(
SELECT branch, category, AVG(rating) AS avg_rating,
RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS RANK_NUM
from walmart
GROUP BY branch, category
)AS ranked_data
WHERE RANK_NUM = 1;

-- q3. Identify the busiest day for each branch based on the number of transactions
SELECT branch, DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
COUNT(*) AS no_of_transactions
from walmart
 GROUP BY branch,day_name
 ORDER BY branch , no_of_transactions desc;
 
 -- q4. calculate the total quantity of items sold per payment method. List payment_method and total_quantity.

SELECT payment_method,  SUM(quantity) AS num_qty_sold
FROM walmart
GROUP BY payment_method
ORDER BY num_qty_sold asc;

-- q5. Determine the average, minimum, and maximun rating of products for each city. 
-- List the city, average_rating, min_rating and max_rating.

SELECT city, category,
MIN(rating) AS min_rating, 
MAX(rating) AS max_rating, 
AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;


-- q6. calculate the total profit for each category by considering total_profit as (unit_price * quantity * profit_margin).
-- List category and total_profit, ordered from highest to lowest profit.

SELECT category, 
SUM(total) AS total_revenue, 
SUM(total * profit_margin) AS profit
from walmart
GROUP BY category;

-- q7. Determine the most common payment method for each Branch.

SELECT branch, payment_method,
COUNT(*) AS total_trans
FROM walmart
GROUP BY branch, payment_method;


