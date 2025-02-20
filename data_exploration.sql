-- 1. What day of the week is used for each week_date value?

SELECT DISTINCT week_date, TO_CHAR(week_date, 'Day') AS week_day
FROM data_mart.clean_weekly_sales;

-- This will show which day of the week corresponds to each week_date.

-- 2. What range of week numbers are missing from the dataset?

WITH weeks AS (
    SELECT generate_series(1, 52) AS week_number
)
SELECT w.week_number
FROM weeks w
LEFT JOIN (SELECT DISTINCT week_number FROM data_mart.clean_weekly_sales) cws
ON w.week_number = cws.week_number
WHERE cws.week_number IS NULL;

-- This finds any missing week numbers.

-- 3. How many total transactions were there for each year in the dataset?

SELECT calendar_year, SUM(transactions) AS total_transactions
FROM data_mart.clean_weekly_sales
GROUP BY calendar_year
ORDER BY calendar_year;

-- This sums up the total transactions for each year.

-- 4. What is the total sales for each region for each month?

SELECT calendar_year, month_number, region, SUM(sales) AS total_sales
FROM data_mart.clean_weekly_sales
GROUP BY calendar_year, month_number, region
ORDER BY calendar_year, month_number, region;

-- This aggregates sales by region and month.

-- 5. What is the total count of transactions for each platform?

SELECT platform, SUM(transactions) AS total_transactions
FROM data_mart.clean_weekly_sales
GROUP BY platform
ORDER BY total_transactions DESC;

-- This shows total transactions per platform.

-- 6. What is the percentage of sales for Retail vs Shopify for each month?

WITH platform_sales AS (
    SELECT calendar_year, month_number, platform, SUM(sales) AS total_sales
    FROM data_mart.clean_weekly_sales
    GROUP BY calendar_year, month_number, platform
)
SELECT calendar_year, month_number, 
       platform, 
       total_sales, 
       ROUND(100.0 * total_sales / SUM(total_sales) OVER(PARTITION BY calendar_year, month_number), 2) AS percentage_sales
FROM platform_sales
ORDER BY calendar_year, month_number, platform;

-- This calculates the sales percentage for each platform per month.

-- 7. What is the percentage of sales by demographic for each year in the dataset?

WITH demographic_sales AS (
    SELECT calendar_year, demographic, SUM(sales) AS total_sales
    FROM data_mart.clean_weekly_sales
    GROUP BY calendar_year, demographic
)
SELECT calendar_year, 
       demographic, 
       total_sales, 
       ROUND(100.0 * total_sales / SUM(total_sales) OVER(PARTITION BY calendar_year), 2) AS percentage_sales
FROM demographic_sales
ORDER BY calendar_year, total_sales DESC;

-- This calculates the sales contribution of each demographic per year.

-- 8. Which age_band and demographic values contribute the most to Retail sales?

SELECT age_band, demographic, SUM(sales) AS total_retail_sales
FROM data_mart.clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band, demographic
ORDER BY total_retail_sales DESC
LIMIT 1;

-- This finds the top contributor to retail sales.

-- 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify?
-- The avg_transaction column is calculated per row, so directly averaging it would not be accurate. Instead, we should calculate the average transaction size as:

SELECT calendar_year, platform, 
       ROUND(SUM(sales) * 1.0 / SUM(transactions), 2) AS avg_transaction_size
FROM data_mart.clean_weekly_sales
GROUP BY calendar_year, platform
ORDER BY calendar_year, platform;
This computes the correct average transaction size by dividing total sales by total transactions.
