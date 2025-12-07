CREATE DATABASE PIZZA_SALES
USE PIZZA_SALES
SELECT* FROM [dbo].[pizza_sales]
--1. Total Revenue:
   SELECT  ROUND(SUM(total_Price),2)AS Total_Revenue
   FROM pizza_sales

   --2. Average Order Value
      SELECT
	 ROUND (( SUM(total_price) / COUNT(DISTINCT(order_id) )),2)  AS   Average_Order_Value
		 FROM pizza_sales

----3. Total Pizzas Sold
        SELECT  SUM( quantity) AS Total_Pizzas_Sold
		FROM pizza_sales
----4. Total Orders
 SELECT COUNT(order_ID) AS  Total_Orders FROM pizza_sales
 ---5. Average Pizzas Per Order
             SELECT  CAST(CAST(SUM(quantity) AS  DECIMAL (10,2))
			 /(CAST(COUNT( DISTINCT (order_id)) AS  DECIMAL(10,2)) ) as  DECIMAL  (10,2))AS  Average_Pizzas_Per_Order
			 FROM pizza_sales

---5 Daily Trend for Total Orders
          SELECT 
		  DATENAME(WEEKDAY,order_date ) AS DAY_NAME,
		  COUNT(order_id) AS Total_Order
		  FROM pizza_sales     
		  GROUP BY DATENAME(WEEKDAY,order_date )
---7. Monthly Trend for Orders	
          SELECT 
		  DATENAME(MONTH,order_date) AS MONTH_NAME,
		  COUNT(order_id) AS Total_order
		  FROM pizza_sales 
		  GROUP BY  DATENAME(MONTH,order_date)
---8. Monthly  Revenue
       SELECT
	   DATENAME(MONTH,order_date) AS Month_name,
	   CAST (SUM(total_price) AS decimal (10,2)) AS Total_Revenue
	   FROM pizza_sales
		GROUP BY  DATENAME(MONTH,order_date)
		ORDER BY DATENAME(MONTH,order_date) DESC
----9.  Total % of Sales by Pizza Category 

           SELECT pizza_category,
		  CAST( SUM(total_price)  AS decimal (10,2)) AS Total_sales,
		  CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS  Total_PER_of_Sales
		   FROM pizza_sales
		   GROUP BY pizza_category
--- 10.Total % of Sales by Pizza Size
           SELECT  pizza_size,
		         CAST(SUM(Total_price) AS decimal (10,2)) AS Total_size,
				 CAST( SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS decimal (10,2) )AS Total_PER_of_Sales
             FROM pizza_sales
			 GROUP BY  pizza_size
---11. Total Pizzas Sold by Pizza Category
           SELECT pizza_category ,
		   COUNT(quantity) AS Total_Sold 
		   FROM pizza_sales
		   GROUP BY pizza_category

 ---12. Top 5 Pizzas by Revenue
         SELECT TOP 5
		 pizza_name,SUM(total_price) AS Total_sales
		 FROM pizza_sales
		 GROUP BY  pizza_name
		 ORDER BY SUM(total_price) DESC
---13.Bottom 5 Pizzas by Revenue
  SELECT TOP 5
		 pizza_name,
		 CAST(SUM(total_price)  AS decimal(10,2)) AS Total_sales
		 FROM pizza_sales
		 GROUP BY  pizza_name
		 ORDER BY SUM(total_price) ASC
		 
---14. Top 5 Pizzas by Quantity
      SELECT TOP 5
	  pizza_name,
	  SUM(quantity) AS Total_Quantity
	  FROM pizza_sales
	  GROUP BY pizza_name
	  ORDER BY SUM(quantity) DESC
----15. Bottom 5 Pizzas by Quantity
   SELECT TOP 5
	  pizza_name,
	  SUM(quantity) AS Total_Quantity
	  FROM pizza_sales
	  GROUP BY pizza_name
	  ORDER BY SUM(quantity) ASC
	   SELECT * FROM pizza_sales
-----16. Top 5 Pizzas by Total Orders
         SELECT TOP 5
		 pizza_name, COUNT (DISTINCT order_id) AS Total_Orders
		 FROM pizza_sales
		 GROUP BY pizza_name
	  ORDER BY COUNT (DISTINCT order_id) DESC