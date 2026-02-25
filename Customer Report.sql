use DataWarehouseAnalytics
/*
=========================================================================================================
Customer Report
=========================================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviour
Highlights:
	1. Gather essential fields such as names, ages, and transaction details.
	2. Segment customers into categories(VIP, Regular, New) and Age group
	3. Aggregates customer-level metrics:
		-total orders
		- total sales
		- total quantity purchased
		- lifespan(in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
==========================================================================================================*/

CREATE VIEW gold.customer_report AS
WITH base_query AS 
/*--------------------------------------------------------------------------------------------------------
1. Base query : Retrieves core imformation from the database
--------------------------------------------------------------------------------------------------------*/
(SELECT 
F.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
CONCAT(C.first_name,' ',C.last_name) AS cust_name,
DATEDIFF(YEAR, C.birthdate, GETDATE()) AS age 
FROM gold.fact_sales AS F
JOIN gold.dim_customers AS C
ON F. customer_key = C.customer_key
WHERE order_date IS NOT NULL),

customer_aggregation AS 
/*------------------------------------------------------------------------------------------------------
2.Customer Aggregation: Summarizes key metrics at customer level 
-------------------------------------------------------------------------------------------------------*/
(SELECT 
	customer_key,
	cust_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) as last_order_date,
	DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) as lifespan
FROM base_query
GROUP BY customer_key,cust_name,age)

	SELECT
		customer_key,
		cust_name,
		age,
		CASE WHEN age < 20 THEN 'Under 20'
			WHEN age BETWEEN 20 AND 29 THEN '20-29'
			WHEN age BETWEEN 30 AND 39 THEN '30-39'
			WHEN age BETWEEN 40 AND 49 THEN '40-49'
			ELSE '50 And Above'
		END AS age_group,
	CASE WHEN lifespan >= 12 AND total_sales >5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
		total_orders,
		total_sales,
		total_products,
		last_order_date,
		lifespan,
		DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
--Compute Average order value		
		CASE WHEN total_sales = 0 THEN 0
		 ELSE total_sales/ total_orders
		 END AS avg_order_value,
--Compute Avg Monhtly spend
		CASE WHEN lifespan = 0 THEN total_sales
		 ELSE total_sales/ lifespan
		 END as avg_monthly_spend
FROM customer_aggregation

select * from gold.customer_report;
