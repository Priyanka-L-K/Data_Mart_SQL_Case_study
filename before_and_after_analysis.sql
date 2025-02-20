-- 1. Total sales for the 4 weeks before and after 2020-06-15, along with growth rate

WITH sales_data AS (
    SELECT week_date, 
           SUM(sales) AS total_sales,
           CASE 
               WHEN week_date BETWEEN '2020-05-18' AND '2020-06-14' THEN 'Before'
               WHEN week_date BETWEEN '2020-06-15' AND '2020-07-12' THEN 'After'
               ELSE NULL 
           END AS period
    FROM data_mart.clean_weekly_sales
    WHERE week_date BETWEEN '2020-05-18' AND '2020-07-12'
    GROUP BY week_date
)
SELECT period, 
       SUM(total_sales) AS total_sales,
       LAG(SUM(total_sales)) OVER() AS previous_sales,
       (SUM(total_sales) - LAG(SUM(total_sales)) OVER()) AS sales_difference,
       ROUND(100.0 * (SUM(total_sales) - LAG(SUM(total_sales)) OVER()) / LAG(SUM(total_sales)) OVER(), 2) AS percentage_change
FROM sales_data
WHERE period IS NOT NULL
GROUP BY period;

-- Calculates total sales for the 4 weeks before and after 2020-06-15.
-- Computes absolute and percentage change in sales.
  
2. Total sales for the 12 weeks before and after 2020-06-15

WITH sales_data AS (
    SELECT week_date, 
           SUM(sales) AS total_sales,
           CASE 
               WHEN week_date BETWEEN '2020-03-23' AND '2020-06-14' THEN 'Before'
               WHEN week_date BETWEEN '2020-06-15' AND '2020-09-06' THEN 'After'
               ELSE NULL 
           END AS period
    FROM data_mart.clean_weekly_sales
    WHERE week_date BETWEEN '2020-03-23' AND '2020-09-06'
    GROUP BY week_date
)
SELECT period, 
       SUM(total_sales) AS total_sales,
       LAG(SUM(total_sales)) OVER() AS previous_sales,
       (SUM(total_sales) - LAG(SUM(total_sales)) OVER()) AS sales_difference,
       ROUND(100.0 * (SUM(total_sales) - LAG(SUM(total_sales)) OVER()) / LAG(SUM(total_sales)) OVER(), 2) AS percentage_change
FROM sales_data
WHERE period IS NOT NULL
GROUP BY period;

-- Extends the analysis to 12 weeks before and after the change.
-- Shows sales trends over a broader period.
