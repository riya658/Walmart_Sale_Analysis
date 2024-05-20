# Walmart_Sale_Analysis
This project aims to explore Walmart sales data to understand top-performing branches and products, sales trends of different products, and customer behavior. The goal is to study how sales strategies can be improved and optimized. 

In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact.

Source: [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

# Purpose of the Project

The primary aim of this project is to gain insight into Walmart's sales data to understand the various factors that affect sales across different branches.

# Data
The dataset contains sales transactions from three different branches of Walmart, located in Mandalay, Yangon, and Naypyitaw. The data consists of 17 columns and 1,000 rows.

Here's the information converted into a table format:

| Column                  | Description                          | Data Type        |
|-------------------------|-----------------------------------------|------------------|
| invoice_id              | Invoice of the sales made               | VARCHAR(30)      |
| branch                  | Branch at which sales were made         | VARCHAR(5)       |
| city                    | The location of the branch              | VARCHAR(30)      |
| customer_type           | The type of the customer                | VARCHAR(30)      |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)      |
| product_line            | Product line of the product sold        | VARCHAR(100)     |
| unit_price              | The price of each product               | DECIMAL(10, 2)   |
| quantity                | The amount of the product sold          | INT              |
| VAT                     | The amount of tax on the purchase       | FLOAT(6, 4)      |
| total                   | The total cost of the purchase          | DECIMAL(10, 2)   |
| date                    | The date on which the purchase was made | DATE             |
| time                    | The time at which the purchase was made | TIMESTAMP        |
| payment_method          | The payment method used              | VARCHAR(30)         |
| cogs                    | Cost of Goods Sold                   | DECIMAL(10, 2)      |
| gross_margin_percentage | Gross margin percentage              | FLOAT(11, 9)        |
| gross_income            | Gross Income                         | DECIMAL(10, 2)      |
| rating                  | Rating                               | FLOAT(2, 1)         |

# Analysis
1. Product Analysis
               Conduct an analysis of the data to understand the different product lines, identify the product lines performing best, and determine the product lines that need                           improvement.
3. Sales Analysis   
               This analysis aims to answer the question of sales trends for each product. The results can help us measure the effectiveness of each sales strategy the business applies                  and determine what modifications are needed to increase sales.
4. Customer Analysis
               This analysis aims to uncover the different customer segments, purchase trends, and the profitability of each customer segment.

# Generic Questions
- How many unique cities are in the data?
- In which city is each branch located?

# Product
- How many unique product lines are in the data?
- What is the most common payment method?
- What is the best-selling product line?
- What is the total revenue by month?
- Which month had the largest COGS?
- Which product line had the largest revenue?
- Which city has the largest revenue?
- Which product line had the largest VAT?
- Fetch each product line and add a column indicating "Good" or "Bad". Label as "Good" if its sales are greater than the average sales.
- Which branch sold more products than the average number of products sold?
- What is the most common product line by gender?
- What is the average rating of each product line?

# Sales
- Number of sales made at each time of the day per weekday.
- Which customer type brings the most revenue?
- Which city has the largest tax percentage/VAT (Value Added Tax)?
- Which customer type pays the most in VAT?

# Customer
- How many unique customer types are in the data?
- How many unique payment methods are in the data?
- What is the most common customer type?
- Which customer type buys the most?
- What is the gender of most of the customers?
- What is the gender distribution per branch?
- At what time of the day do customers give the most ratings?
- At what time of the day do customers give the most ratings per branch?
- Which day of the week has the best average ratings?
- Which day of the week has the best average ratings per branch?

