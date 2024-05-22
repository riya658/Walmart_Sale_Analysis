-- Create database
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
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

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
SELECT Payment ,count(Payment) as most_common from sales 
group by Payment
ORDER BY most_common desc limit 1 ;

-- What is the most selling product line?
SELECT product_line ,count(product_line) as famous from sales 
group by product_line
ORDER BY famous desc limit 1;

-- What is the total revenue by month?
SELECT month_name AS month, SUM(Total) as Total_Revenue from sales
GROUP by month_name
order by Total_Revenue desc;

-- What month had the largest COGS?
SELECT month_name AS month, SUM(cogs) as largest_cog from sales
group by month
order by largest_cog desc ;

-- What product line had the largest revenue?
select product_line , SUM(total) as total_revenue from sales 
group by product_line
order by total_revenue desc;

-- What is the city with the largest revenue?
SELECT City , sum(total) as Total_Revenue from sales 
group by city
order by Total_Revenue DESC ;

-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT product_line , case when total_sales > avg_sales then "GOOD" else "Bad" end as sales_quality from 
(SELECT product_line , SUM(total) as total_sales , AVG(sum(total))  over () as avg_sales from sales
group by product_line) as sales_summary;

-- Which branch sold more products than average product sold?
SELECT branch , SUM(quantity) as total_quantity from sales
group by branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
select Gender,product_line, count(product_line) as cnt from sales
group by gender , product_line
order by cnt desc;

-- What is the average rating of each product line?

select product_line , ROUND(AVG(rating),1) as avg from sales
group by product_line
order by avg desc;

-----------------------------Sales------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
select customer_type , SUM(total) as Total_Revenue  from sales 
group by customer_type
order by Total_Revenue desc;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, AVG(tax_pct) as VAT from sales
group by city
order by vat desc;

-- Which customer type pays the most in VAT?
select customer_type, AVG(tax_pct) as total_tax from sales
group by customer_type
order by total_tax desc;

-----------------------Customer-------------------------
-- How many unique customer types does the data have?
select distinct customer_type from sales

-- How many unique payment methods does the data have?
select distinct payment from sales

-- What is the most common customer type?
select  customer_type , count(customer_type) as cnt from sales
group by customer_type
order by cnt desc limit 1;

-- Which customer type buys the most?
select customer_type , count(*) from sales
group by customer_type

-- What is the gender of most of the customers?
select count(gender) as cnt from sales
group by gender
order by cnt desc;

-- What is the gender distribution per branch?
select gender, count(*) as cnt from sales
where branch="A"
group by gender
order by cnt desc;

-- Which time of the day do customers give most ratings?
select time_of_day , avg(rating) from sales
group by time_of_day
order by avg(rating) desc;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter

-- Which time of the day do customers give most ratings per branch?
SELECT time_of_day, AVG(rating) AS rating FROM sales
WHERE branch="B"
GROUP BY time_of_day
ORDER BY rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

-- Which day fo the week has the best avg ratings?
SELECT day_name,AVG(rating) AS rating FROM sales
GROUP BY day_name,
ORDER BY rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?

-- Which day of the week has the best average ratings per branch?
SELECT day_name,COUNT(day_name) total_sales FROM sales
WHERE branch="A"
GROUP BY total_sales
ORDER BY rate DESC;
