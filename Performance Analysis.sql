use DataWarehouseAnalytics
/*Performance Analysis:- Analyze the yearly performance of products by comparing their sales to both 
the average sales performance of the product and the previous year's sales */
	WITH yearly_product_sales AS(
	SELECT 
	YEAR(F.order_date) AS order_year,
	P.product_name,
	SUM(F.sales_amount) AS current_sales
	FROM gold.fact_sales AS F
	JOIN gold.dim_products AS P
	ON F.product_key = P.product_key
	WHERE order_date IS NOT NULL
	GROUP BY YEAR( F.order_date), P.product_name
	)
	
	SELECT
	order_year,
	product_name,
	current_sales,
	AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
	current_sales-AVG(current_sales) OVER (PARTITION BY product_name) AS avg_diff,
	CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)>0 THEN 'Above Avg'
	WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) <0 THEN 'Below Avg'
	ELSE 'Avg'
	END avg_change,
	--Year-over-Year Analysis
	LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_sales,
	current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_diff,
	CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)>0 THEN
	'Increse'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)< 0 THEN
	'Decrease'
	ELSE 'No change'
	END py_change

	FROM yearly_product_sales