-- Convert week_date to a proper DATE format.
-- Extract week_number, month_number, and calendar_year.
-- Map segment values to age_band and demographic while handling NULL values.
-- Replace NULL values with 'unknown' where needed.
-- Calculate avg_transaction by dividing sales by transactions, ensuring no division by zero.


DROP TABLE IF EXISTS data_mart.clean_weekly_sales;
CREATE TABLE data_mart.clean_weekly_sales AS
SELECT
    -- Convert week_date to DATE format (assuming dd/mm/yy format)
    TO_DATE(week_date, 'DD/MM/YY') AS week_date,

    -- Extract week number, month number, and calendar year
    EXTRACT(WEEK FROM TO_DATE(week_date, 'DD/MM/YY')) AS week_number,
    EXTRACT(MONTH FROM TO_DATE(week_date, 'DD/MM/YY')) AS month_number,
    EXTRACT(YEAR FROM TO_DATE(week_date, 'DD/MM/YY')) AS calendar_year,

    region,
    platform,

    -- Replace NULL values in segment column with 'unknown'
    COALESCE(segment, 'unknown') AS segment,

    -- Assign age_band based on segment
    CASE 
        WHEN segment IN ('C1', 'F1') THEN 'Young Adults'
        WHEN segment IN ('C2', 'F2') THEN 'Middle Aged'
        WHEN segment IN ('C3', 'C4', 'F3', 'F4') THEN 'Retirees
        ELSE 'unknown'
    END AS age_band,

    -- Assign demographic based on the first letter of segment
    CASE 
        WHEN LEFT(segment, 1) = 'C' THEN 'Couples'
        WHEN LEFT(segment, 1) = 'F' THEN 'Families'
        ELSE 'unknown'
    END AS demographic,

    -- Replace NULL values in customer_type with 'unknown'
    COALESCE(customer_type, 'unknown') AS customer_type,

    transactions,
    sales,

    -- Calculate avg_transaction, avoiding division by zero
    ROUND(sales / NULLIF(transactions, 0), 2) AS avg_transaction

FROM data_mart.weekly_sales;
