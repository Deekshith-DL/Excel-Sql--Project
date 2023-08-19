SELECT * FROM pizza_sales;
--KPI'S
--1. Total_Revenue
 SELECT SUM(total_price) AS Total_Revenue from pizza_sales;

 --2. Average Order value:

 SELECT SUM(total_price)/ Count(DISTINCT(order_id)) AS Average_Order_value from pizza_sales;

 --3. Total _Pizza_Sold

 SELECT SUM(quantity) as Total_Pizza_Sold from pizza_sales;

 --4. Total_order_Placed:

 SELECT COUNT(DISTINCT(order_id)) AS Total_order_Placed from pizza_sales;

 --5. Average_Pizza_per_Order

 SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /CAST(COUNt(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Average_Pizza_per_Order from pizza_sales;


 --CHARTS:

 --1. Daily_Trends:

 SELECT DATENAME(DW,order_date) as order_day, COUNT(DISTINCT order_id) AS  Toatal_orders
 from pizza_sales
 group by DATENAME(DW,order_date);

 --2.Hourly_trend:

 SELECT DATEPART(HOUR,order_time) AS order_Hours,  COUNT(DISTINCT order_id) AS  Toatal_orders
  from pizza_sales
 group by DATEPART(HOUR,order_time)
 order by DATEPART(HOUR,order_time);

 --3. Percentage_of_Sales_By_Pizza_category:

 SELECT pizza_category, sum(total_price) as Total_Sales ,
 sum(total_price)*100 /(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) as Total_Percentage_Sales
 from pizza_sales
 WHERE MONTH(order_date) = 1
 group by pizza_category ;

 --4.Percentge_of_Sales_By_Pizza_Size:

 SELECT pizza_size, CAST(sum(total_price) AS DECIMAL (10,2)) as Total_Sales ,
 CAST(sum(total_price)*100 /(SELECT SUM(total_price) from pizza_sales  where DATEPART(quarter,order_date)= 1) AS DECIMAL (10,2))as Total_Percentage_Sales
 from pizza_sales
 where DATEPART(quarter,order_date)= 1
 group by pizza_size
 order by pizza_size;


 --5. Total_pizza_Sold_By_Catagory:

 SELECT pizza_category , sum(quantity) AS Total_pizza_Sold
 from pizza_sales
 group by pizza_category ;

 --6.Top_5_Best-Sellers_By_total_Pizza_Sold:

 SELECT  TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
 from pizza_sales
 group by pizza_name
 order by SUM(quantity) DESC;

 --7. Bottom_5:

 SELECT  TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
 from pizza_sales
 group by pizza_name
 order by SUM(quantity) asc;