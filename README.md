# SQL-Bike-sales-Exploratory-Data-Analysis-Project
Architected a scalable SQL-based diagnostic framework that transformed 10,000+ transaction records into actionable-behavioral insights, focusing on customer lifecycle segmentation and product profitability trends, using advanced SQL techniques (CTEs, Window Functions, and Multi-layered Aggregations).
# Data Sources
Used three datasets : dim_products, dim_customers and fact_sales.
# Data Exploration
Explored the database, along with date, dimensions, and measures. 
(https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/7f5cd50cd3ba8eee7e71e9c5fa1cde371f75711b/Data%20Exploration.sql).
 
# Analytics
## Magnitude Analysis
Calculated measures by different dimensions. Example - Total customers by countries, total customers by gender, total products by category. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/484585e664406518cedd2699f07af6076e01c527/Magnitude%20Analysis.sql)
## Ranking Analysis
Ranked top and bottom customers based on highest revenue created, and ranked top-performing and low-perfoming products in terms of sales. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/7a4ac8b4d9748a02db2849aae737ccca640158b8/Ranking%20Analysis.sql)
## Changes Over Time
Analyzed sales performance overtime. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/b3fe5aade7a22a9695d6462d32ccab24b12abdeb/Changes%20Over%20Time.sql)
## Cumulative Analysis
Calculated the total sales per month and running total of sales overtime. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/2b3d148854716ccb75930a6e51c1510d0a942bed/Cumulative%20Analysis.sql)
## Performance Analysis
Analyzed the yearly performance of products by comparing their sales to both the average sales performance of the product and the previous year's sales. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/cf4a7346484f1283a925434e3149aabc6a9c0968/Performance%20Analysis.sql)
## Proportional Analysis
Calculated which categories contribute the most to overall sales. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/0775775dd0db3960284c6239be28be9d321b2f34/Proportional%20Analysis.sql)
## Data Segmentation 
Segmented the customer data with 'VIP', 'Regular', and 'New' based on their spending and lifespan.
And segmented the products with 'High-Performers', 'Mid-Range' and 'low-performers' based total sales of products.
Also segmented customer base by Age Demographics to identify core purchasing age brackets. (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/c6b17ff56cbc57661b844b8822067e70ca334ce6/Data%20Segmentation.sql)
# Key Insights (Reporting)
## Customer Report 
Identified that most of the VIP customers are from (50 and Above) age group with maximum average order value (AOV). (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/c2a350cc51b0244f4fcfd563026f40e98acf2da0/Customer%20Report.sql)
## Product Report 
Identified that our high-performing products are from Bikes category making maximum average order revenue (AOR). (https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/885f42c280f5546c8294c3dee93988d35a3914e2/Product%20Report.sql)
# Results
## Customer Report
(https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/bcd1111a4b5ecd896d5bb70a42948cd9cf00d7f4/Customer%20report%20Result.csv)
## Product Report
(https://github.com/pushpadash2002-lab/sql-Bike-Sales-exploratory-data-analysis-project/blob/1669985cff373552a83959271fa458c6b8176b84/Product%20Report%20Result.csv)
