# Data Mart SQL Case Study

## **Overview**
This case study analyzes sales performance for **Data Mart**, an international supermarket specializing in fresh produce. The goal is to assess the impact of a sustainability initiative introduced in **June 2020**, where all products switched to sustainable packaging.

## **Business Questions**
1. **What was the impact of the June 2020 packaging change on sales?**
2. **Which platform, region, segment, and customer type were most affected?**
3. **How can Data Mart minimize the impact of future sustainability initiatives on sales?**

---

## **Dataset**
The analysis is based on a single table: `data_mart.weekly_sales`, which contains:

- `week_date`: Start of the sales week (in `VARCHAR` format, needs conversion to `DATE`).
- `region`: Sales region.
- `platform`: Sales platform (`Retail` or `Shopify`).
- `segment`: Customer segment (`C1`, `F3`, etc.).
- `customer_type`: New or existing customers.
- `transactions`: Count of purchases.
- `sales`: Total sales amount.

---

## **Analysis Approach**
### **1. Data Cleansing**
- Convert `week_date` to `DATE` format.
- Extract `week_number`, `month_number`, and `calendar_year`.
- Map `segment` to `age_band` and `demographic` groups.
- Replace `NULL` values with `"unknown"`.
- Calculate `avg_transaction` (`sales / transactions`).

### **2. Data Exploration**
- Identify the day of the week for `week_date`.
- Find missing `week_number` values.
- Aggregate transactions and sales by:
  - Year
  - Region & Month
  - Platform
  - Demographic
  - Age Band

### **3. Before & After Analysis (June 2020 Impact)**
- Compare total sales **4 weeks before vs. 4 weeks after** June 15, 2020.
- Expand analysis to **12 weeks before vs. 12 weeks after**.
- Compare these periods against **2018 & 2019** to detect long-term trends.

### **4. Identifying Negative Business Impact**
- Determine which **region, platform, age_band, demographic, and customer_type** had the highest negative sales impact in **2020**.
- Recommend strategies to mitigate future revenue loss.

---

## **Key Findings & Insights**
📉 **Sales Decline Post-Sustainability Change**:
  - Sales dropped immediately after the sustainable packaging change.
  - The decline was most pronounced in **Retail customers** compared to Shopify.

🌍 **Regional Variations**:
  - **Oceania & Europe** saw the sharpest drops, while some regions showed resilience.

👥 **Customer Segments Most Affected**:
  - **Retirees and Families** were the most impacted demographics.
  - **Existing customers** adapted better than **new customers**.

💡 **Recommendations for Future Changes**:
- **Gradual Implementation**: Introduce sustainability updates in **phases**.
- **Customer Incentives**: Offer discounts or loyalty points to encourage **adoption**.
- **Communication Strategy**: Educate customers on the benefits of sustainability efforts.

---

This case study demonstrates advanced **SQL data analysis** skills, including **data cleansing, time-based comparisons, and business impact assessment**, making it a great showcase for an SQL Developer role.
