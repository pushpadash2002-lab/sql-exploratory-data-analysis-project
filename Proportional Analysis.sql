use DataWarehouseAnalytics
--PROPORTIONAL ANALYSIS
	--Which categories contribute the most to overall sales
		 WITH category_sales AS 
		 (SELECT 
		 category,
		 SUM(sales_amount) AS total_sales
		 FROM 
		 gold.fact_sales AS F
		 JOIN GOLD.dim_products AS P
		 ON F.product_key = P.product_key
		 GROUP BY category)
		 
		 SELECT
		 category,
		 total_sales,
		 SUM(total_sales)OVER() AS overall_sales,
		 CONCAT(ROUND((CAST(total_sales AS float) /SUM(total_sales)OVER() *100),2),'%') AS percentage_of_total
		 FROM category_sales
		 ORDER BY total_sales DESC