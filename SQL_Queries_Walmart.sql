-- Create databASe
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
SELECT time,(CASE
	WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) 
	AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (
	CASE WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening" END );

-- Add day_name column
SELECT date,DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name = DAYNAME(date);

-- Add month_name column
SELECT date,MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = MONTHNAME(date);

-- How many unique cities does the data have?
SELECT DISTINCT City
FROM sales

-- In which city is each branch?
SELECT DISTINCT City, Branch
FROM sales

-- How many unique product lines does the data have?
SELECT COUNT(DISTINCT product_line)
FROM sales
    
-- What is the most common payment method?
SELECT Payment ,COUNT(Payment) AS most_common FROM sales 
GROUP BY Payment
ORDER BY most_common DESC LIMIT 1 ;

-- What is the most selling product line?
SELECT product_line ,COUNT(product_line) AS famous FROM sales 
GROUP BY product_line
ORDER BY famous DESC LIMIT 1;

-- What is the total revenue by month?
SELECT month_name AS Months, SUM(Total) AS Total_Revenue FROM sales
GROUP BY month_name
ORDER BY Total_Revenue DESC;

-- What month had the largest COGS?
SELECT month_name AS Months, SUM(cogs) AS largest_cog FROM sales
GROUP BY Months
ORDER BY largest_cog DESC ;

-- What product line had the largest revenue?
SELECT product_line , SUM(total) AS total_revenue FROM sales 
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT City , sum(total) AS Total_Revenue FROM sales 
GROUP BY city
ORDER BY Total_Revenue DESC ;

-- What product line had the largest VAT?
SELECT product_line,AVG(tax_pct) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT product_line , CASE WHEN total_sales > avg_sales THEN "GOOD" ELSE "Bad" END AS sales_quality FROM 
(SELECT product_line , SUM(total) AS total_sales , AVG(sum(total))  over () AS avg_sales FROM sales
GROUP BY product_line) AS sales_summary;

-- Which branch sold more products than average product sold?
SELECT branch , SUM(quantity) AS total_quantity FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT Gender,product_line, count(product_line) AS cnt FROM sales
GROUP BY gender , product_line
ORDER BY cnt DESC;

-- What is the average rating of each product line?

SELECT product_line , ROUND(AVG(rating),1) AS avg FROM sales
GROUP BY product_line
ORDER BY avg DESC;

-----------------------------Sales------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT time_of_day,COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT customer_type , SUM(total) AS Total_Revenue  FROM sales 
GROUP BY customer_type
ORDER BY Total_Revenue DESC;

-- Which city hAS the largest tax percent/ VAT (Value Added Tax)?
SELECT city, AVG(tax_pct) AS VAT FROM sales
GROUP BY city
ORDER BY vat DESC;

-- Which customer type pays the most in VAT?
SELECT customer_type, AVG(tax_pct) AS total_tax FROM sales
GROUP BY customer_type
ORDER BY total_tax DESC;

-----------------------Customer-------------------------
-- How many unique customer types does the data have?
SELECT DISTINCT customer_type FROM sales

-- How many unique payment methods does the data have?
SELECT DISTINCT payment FROM sales

-- What is the most common customer type?
SELECT  customer_type , count(customer_type) AS cnt FROM sales
GROUP BY customer_type
ORDER BY cnt DESC LIMIT 1;

-- Which customer type buys the most?
SELECT customer_type , count(*) FROM sales
GROUP BY customer_type

-- What is the gender of most of the customers?
SELECT COUNT(gender) AS cnt FROM sales
GROUP BY gender
ORDER BY cnt DESC;

-- What is the gender distribution per branch?
SELECT gender, COUNT(*) AS cnt FROM sales
WHERE branch="A"
GROUP BY gender
ORDER BY cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT time_of_day , avg(rating) FROM sales
GROUP BY time_of_day
ORDER BY avg(rating) DESC;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter

-- Which time of the day do customers give most ratings per branch?
SELECT time_of_day, AVG(rating) AS rating FROM sales
WHERE branch="B"
GROUP BY time_of_day
ORDER BY rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

-- Which day fo the week hAS the best avg ratings?
SELECT day_name,AVG(rating) AS rating FROM sales
GROUP BY day_name,
ORDER BY rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the cASe, how many sales are made on these days?

-- Which day of the week hAS the best average ratings per branch?
SELECT day_name,COUNT(day_name) total_sales FROM sales
WHERE branch="A"
GROUP BY total_sales
ORDER BY rate DESC;
