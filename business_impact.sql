-- To identify the areas of the business with the highest negative impact in sales metrics for the 12 weeks before and after 2020-06-15, we can break it down by region, platform, age_band, demographic, and customer_type.

-- Identify the business areas with the largest negative impact

WITH sales_trends AS (
    SELECT 
        region, platform, age_band, demographic, customer_type,
        CASE 
            WHEN week_date BETWEEN '2020-03-23' AND '2020-06-14' THEN 'Before'
            WHEN week_date BETWEEN '2020-06-15' AND '2020-09-06' THEN 'After'
            ELSE NULL 
        END AS period,
        SUM(sales) AS total_sales
    FROM data_mart.clean_weekly_sales
    WHERE week_date BETWEEN '2020-03-23' AND '2020-09-06'
    GROUP BY region, platform, age_band, demographic, customer_type, period
)
SELECT region, platform, age_band, demographic, customer_type,
       MAX(CASE WHEN period = 'Before' THEN total_sales ELSE NULL END) AS before_sales,
       MAX(CASE WHEN period = 'After' THEN total_sales ELSE NULL END) AS after_sales,
       (MAX(CASE WHEN period = 'After' THEN total_sales ELSE NULL END) - 
        MAX(CASE WHEN period = 'Before' THEN total_sales ELSE NULL END)) AS sales_difference,
       ROUND(100.0 * 
        (MAX(CASE WHEN period = 'After' THEN total_sales ELSE NULL END) - 
         MAX(CASE WHEN period = 'Before' THEN total_sales ELSE NULL END)) / 
        MAX(CASE WHEN period = 'Before' THEN total_sales ELSE NULL END), 2) AS percentage_change
FROM sales_trends
GROUP BY region, platform, age_band, demographic, customer_type
ORDER BY percentage_change ASC
LIMIT 10;

-- Calculates sales for each business segment before and after the change.
-- Sorts in ascending order to highlight the biggest negative impacts.
-- Limits results to the top 10 worst-affected areas.
  
-- Recommendations & Insights for Danny’s Team

-- Region Impact: If a specific region (e.g., USA, Asia, Europe) shows a significant drop, it may indicate external factors like economic shifts or customer behavior changes.
-- Platform Shift: A drop in Retail sales but an increase in Shopify sales could suggest a shift in online shopping behavior.
-- Demographic Trends: If younger age groups or specific demographics have a sharp decline, it could indicate changing preferences.
-- Customer Type Changes: A decline in Guest or New Customers could suggest acquisition challenges, while a drop in Existing Customers might indicate loyalty issues.
