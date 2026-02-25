USE DataWarehouseAnalytics

--Explore all the objects in a Database
SELECT* FROM INFORMATION_SCHEMA.TABLES

--Explore all the columns in a database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dim_customers'

--Explore all countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

--Explore all categories "The major division"
SELECT  DISTINCT category, subcategory, product_name FROM gold.dim_products ORDER BY 1,2,3

--EXPLORE THE DIMENSIONS
	--Find the date of first and last order 
	--How many years of sales are available
		SELECT MIN(order_date) AS first_order_date,
		MAX(order_date) AS last_order_date,
		DATEDIFF(YEAR, MIN(order_date),MAX(order_date )) AS order_range_years
		FROM gold.fact_sales

	--Find the youngest and oldest customer and their age
		SELECT MIN(birthdate) AS oldest_birthdate,
		DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS oldest_age,
		MAX(birthdate) AS youngest_birthdate,
		DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
		FROM gold.dim_customers

--EXPLORE THE MEASURES

	--Find the total sales

		SELECT SUM(sales_amount) FROM gold.fact_sales

	--Find how many items are sold
		
		SELECT SUM(quantity)FROM gold.fact_sales

	--Find the avg selling price

		SELECT AVG(price) FROM GOLD.fact_sales

	--Find the total number of orders

		SELECT COUNT(DISTINCT order_number) FROM gold.fact_sales

	--Find the total number of products

		SELECT COUNT(DISTINCT product_number) FROM gold.dim_products

	--Find the total number of customers

		 SELECT  COUNT(DISTINCT customer_key)FROM gold.dim_customers

	-- Find the number customers who placed an order
		SELECT  COUNT(DISTINCT customer_key)FROM GOLD.fact_sales

	--Generate a report that shows all key metrics of business
		SELECT 'Total sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
		UNION ALL
		SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
		UNION ALL
		SELECT 'AVG selling Price' AS measure_name , AVG(price) AS measure_value FROM GOLD.fact_sales
		UNION ALL
		SELECT 'Total no. of orders' AS measure_name , COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
		UNION ALL
		SELECT 'Total no. of Products' AS measure_name , COUNT(DISTINCT product_number) AS measure_value FROM gold.dim_products
		UNION ALL
		SELECT 'Total number of customers' as measure_name,COUNT(DISTINCT customer_key)AS measure_value FROM gold.dim_customers 
		UNION ALL 
		SELECT 'No.of customers who placed an order' as measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.fact_sales