SELECT * 
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`;



--calculating sum of revenue, converting datatype of revenue column--
SELECT 
  FORMAT ('%.2f',
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)))
  AS total_revenue_from_sales
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`;



--high performing states--
SELECT
  State, 
  FORMAT('%.2f',
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64))) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  State;



--create view for sales in states--
CREATE VIEW  `francis-analytics-course.Portfolio_Projects.sales_by_state`
AS 
SELECT
  State, 
  FORMAT('%.2f',
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64))) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  State;


--most sold product--
SELECT 
Product_Name,
SUM(Quantity) AS total_quantity_sold
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY 
  Product_Name
ORDER BY
  total_quantity_sold DESC;



--create view for most sold product--
CREATE VIEW `francis-analytics-course.Portfolio_Projects.most_sold_product`
AS
SELECT 
Product_Name,
SUM(Quantity) AS total_quantity_sold
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY 
  Product_Name
ORDER BY
  total_quantity_sold DESC;



--best selling product (revenue)--
SELECT 
product_name,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY Product_Name
ORDER BY total_revenue DESC;



--create view for best selling product (revenue)
CREATE VIEW `francis-analytics-course.Portfolio_Projects.best_selling_product`
AS
SELECT 
product_name,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY 
  Product_Name
ORDER BY 
  total_revenue DESC;



--total profit--
SELECT
  SUM
  (CAST(REPLACE(REPLACE(Profit, '$', ''), ',' , '') AS FLOAT64)) AS total_profit
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`;



--most profitable product--
SELECT
  Product_Name,
  SUM
  (CAST(REPLACE(REPLACE(Profit, '$', ''), ',' , '') AS FLOAT64)) AS total_profit
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY 
  Product_Name
ORDER BY
  total_profit DESC;



--orders received per day--
SELECT
  Order_Date,
  COUNT(Order_ID) AS no_of_orders_received
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY Order_Date
ORDER BY Order_Date;



--create view for daily orders--
CREATE VIEW `francis-analytics-course.Portfolio_Projects.daily_orders`
AS
SELECT
  Order_Date,
  COUNT(Order_ID) AS no_of_orders_received
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY Order_Date
ORDER BY Order_Date;



--most preferred ship mode--
SELECT
  Ship_Mode,
  COUNT(Order_ID) AS no_of_orders
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Ship_Mode
ORDER BY 
  no_of_orders DESC;



--segment with most sales--
SELECT
  Segment,
  COUNT(Order_ID) AS no_of_orders
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Segment
ORDER BY
  no_of_orders DESC;



--revenue by category--
SELECT
  Category,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Category
ORDER BY
  total_revenue DESC;



--revenue by sub-category--
SELECT
  sub_category,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Sub_Category
ORDER BY
  total_revenue DESC;


--calaculating shipping delays--
SELECT
  Product_Name,
  Order_Date,
  Ship_Date,
  DATE_DIFF(Ship_Date, Order_Date, DAY) AS shipping_delay
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
ORDER BY shipping_delay DESC;



--product with the shipping delays of more than 5 days--
WITH Temptable AS (
SELECT
  Product_Name,
  DATE_DIFF(Ship_Date, Order_Date, DAY) AS shipping_delay
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
)
SELECT
  Product_name,
  shipping_delay
FROM
  Temptable
WHERE
  shipping_delay > 5;


--which region has the most orders--
SELECT
  Region,
 COUNT(*) AS order_count
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Region;

--create view for orders by region--
CREATE VIEW `francis-analytics-course.Portfolio_Projects.orders_by_region`
AS
SELECT
  Region,
 COUNT(*) AS order_count
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Region;



SELECT
  Segment,
  Category,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Segment, Category;



--create view for segment preference--
CREATE VIEW `francis-analytics-course.Portfolio_Projects.segment_heatmap`
AS
SELECT
  Segment,
  Category,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS total_revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Segment, Category;



--monthly revenue trends--
SELECT
  EXTRACT (YEAR FROM Order_Date) AS Year,
  EXTRACT (MONTH FROM Order_Date) AS Month,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS Revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Year, Month
ORDER BY
  Year, Month;


--create view for monthly revenue trends--
CREATE VIEW `francis-analytics-course.Portfolio_Projects.monthly_revenue_trends`
AS
SELECT
  EXTRACT (YEAR FROM Order_Date) AS Year,
  EXTRACT (MONTH FROM Order_Date) AS Month,
  SUM
  (CAST(REPLACE(REPLACE(Revenue, '$', ''),',','') AS FLOAT64)) AS Revenue
FROM
  `francis-analytics-course.Portfolio_Projects.superstore_data`
GROUP BY
  Year, Month
ORDER BY
  Year, Month;

