use DataWarehouseAnalytics
--Analyze sales performance overtime
	SELECT
	DATETRUNC(YEAR,order_date)AS order_date,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	COUNT(quantity) AS total_quantity
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date)
	ORDER BY DATETRUNC(YEAR,order_date)
