use DataWarehouseAnalytics
/*-------------------------------------------------------------------------------------------------------------------------
Product Report
----------------------------------------------------------------------------------------------------
Purpose
	- This report consolidates key product metrics and behaviours.
----------------------------------------------------------------------------------------------------
Highlights:-
	1.Gathers essential fields such as product name, category, subcategory and cost.
	2.Segment products by revenue to identify High-Performers, Mid-Range and Low-performers
	3.Aggregates product level metrics:
		-total orders
		- total sales
		- total quantity sold
		- total customers(unique)
		- lifespan (in months)
	4. Calculate KPIs:
		- recency (months since last sale)
		- average order reveue (AOR)
		- average monthly revenue
----------------------------------------------------------------------------------------------------
*/
CREATE VIEW gold.product_report AS 
WITH base_query AS( 
	SELECT 
	F.order_number,
	F.order_date,
	F.customer_key,
	F.sales_amount,
	F.quantity,
	P.product_key,
	P.product_name,
	P.category,
	P.subcategory,
	P.cost
FROM gold.fact_sales AS F JOIN
	gold.dim_products AS P
	ON F.product_key = P.product_key
	WHERE order_date IS NOT NULL
	),
product_aggregation AS(

	SELECT
		product_key,
		product_name,
		category,
		subcategory,
		cost,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
		MAX(order_date) AS last_sale_date,
		COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT customer_key) AS total_customers,
		SUM(sales_amount) AS total_sales,
		SUM (quantity) AS total_quantity_sold,
		ROUND(AVG(CAST (sales_amount AS FLOAT)/ NULLIF (quantity,0)),1) AS avg_selling_price
	FROM base_query
	GROUP BY product_key,
		product_name,
		category,
		subcategory,
		cost 
		)
	SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(MONTH,last_sale_date, GETDATE()) AS recency,
	CASE WHEN total_sales > 50000 THEN 'High Performers'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performers'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity_sold,
	total_customers,
	avg_selling_price,
	CASE WHEN total_orders = 0 THEN 0
	ELSE total_sales/ total_orders
	 END AS avg_order_revenue,
	CASE WHEN	lifespan = 0 THEN total_sales
	  ELSE total_sales / lifespan
	 end AS AVG_monthly_revenue
FROM product_aggregation