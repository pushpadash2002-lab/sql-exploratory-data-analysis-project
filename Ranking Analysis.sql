Use DataWarehouseAnalytics
--RANKING ANALYSIS
	--Which 5 products generate the highest revenue?
	SELECT TOP 5
	P.product_name,
	P.category,
	SUM(F.sales_amount) AS total_revenue
	FROM GOLD.fact_sales AS F
	JOIN gold.dim_products AS P
	ON F.product_key = P.product_key
	GROUP BY P.product_name,P.category
	ORDER BY total_revenue DESC
	--Using window function and subquery
	SELECT * FROM
	(SELECT 
	P.product_name,
	P.category,
	SUM(F.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount)  DESC) AS rank_products
	FROM GOLD.fact_sales AS F
	JOIN gold.dim_products AS P
	ON F.product_key = P.product_key
	GROUP BY P.product_name,P.category
	)T 
	WHERE rank_products <=5
		

	--What are the 5 worst-performing products in terms of sales?
	SELECT TOP 5
	P.product_name,
	P.category,
	SUM(F.sales_amount) AS total_revenue
	FROM GOLD.fact_sales AS F
	JOIN gold.dim_products AS P
	ON F.product_key = P.product_key
	GROUP BY P.product_name,P.category
	ORDER BY total_revenue 

--Top 10 customers who have generated highest revenue
	SELECT TOP 10
	c.customer_key,
	CONCAT(c.first_name,' ', c.last_name ) AS customer_name,
	SUM(F.sales_amount) AS total_revenue
	FROM gold.fact_sales AS F
	JOIN gold.dim_customers AS c
	ON c.customer_key = F.customer_key
	GROUP BY c.customer_key,CONCAT(c.first_name,' ', c.last_name )
	ORDER BY total_revenue DESC

--The 3 customers with fewest order placed
	SELECT TOP 3
	C.customer_key,
	CONCAT(C.first_name,' ',C.last_name) AS name,
	COUNT(DISTINCT order_number) AS total_orders
	FROM GOLD.fact_sales AS F
	JOIN gold.dim_customers AS C
	ON F.customer_key=C.customer_key
	GROUP BY C.customer_key, CONCAT(C.first_name,' ',C.last_name)
	ORDER BY total_orders