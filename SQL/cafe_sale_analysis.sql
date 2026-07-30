CREATE DATABASE cafe_sales_db;
USE cafe_sales_db;

# Check Total Records 
SELECT COUNT(*) AS Total_Rows
FROM cafe_sales;

# Check Table Structure
DESCRIBE cafe_sales;

# Check Missing Values
SELECT
SUM(Item IS NULL) AS Missing_Item,
SUM(Quantity IS NULL) AS Missing_Quantity,
SUM('Price per Unit' IS NULL) AS Missing_Price,
SUM('Total Spent' IS NULL) AS Missing_Total,
SUM('Payment Method' IS NULL) AS Missing_Payments,
SUM(Location IS NULL) AS Missing_Location,
SUM('Transaction Date' IS NULL) AS Missing_Date
FROM cafe_sales;

# Check Duplicate Transactions IDs
SELECT
    `Transaction ID`,
    COUNT(*) AS Duplicate_Count
FROM cafe_sales
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;

# Total Revenue
SELECT
ROUND(SUM(`Total Spent`),2) AS Total_Revenue
FROM cafe_sales;

# Average Order value
SELECT
ROUND(AVG(`Total Spent`),2) AS Average_Order_Value
FROM cafe_sales;

# Total Transactions
SELECT
COUNT(*) AS Total_Transactions
FROM cafe_sales;

# PRODUCT ANALYSIS
# Best Selling Items (by Number of Orders)
SELECT
Item,
COUNT(*) AS Total_Orders
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item
ORDER BY Total_Orders DESC;

# Revenue by Product
SELECT
Item,
ROUND(SUM(`Total Spent`),2) AS Revenue
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item
ORDER BY Revenue DESC;

# Quantity Sold by Product
SELECT
Item,
SUM(Quantity) AS Total_Quantity
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item
ORDER BY Total_Quantity DESC;

# Average Selling Price Per Item
SELECT
Item,
ROUND(AVG(`Price Per Unit`),2) AS Average_Price
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item
ORDER BY Average_Price DESC;

# Payment Method Analysis
# Transaction by Payment Method
SELECT
`Payment Method`,
COUNT(*) AS Transactions
FROM cafe_sales
GROUP BY `Payment Method`
ORDER BY Transactions DESC; 

# Revenue by Payment Method
SELECT
`Payment Method`,
ROUND(SUM(`Total Spent`),2) AS Revenue
FROM cafe_sales
GROUP BY `Payment Method`
ORDER BY Revenue;

# Average Order Value by Payment Method
SELECT
`Payment Method`,
ROUND(AVG(`Total Spent`),2) AS Average_Order_Value
FROM cafe_sales
GROUP BY `Payment Method`
ORDER BY Average_Order_Value DESC;

# Location Analysis
# Transactions by Location
SELECT
Location,
COUNT(*) AS Transactions
FROM cafe_sales
GROUP BY Location
ORDER BY Transactions DESC;

# Revenue by Location
SELECT
Location,
ROUND(SUM(`Total Spent`),2) AS Revenue
FROM cafe_sales
GROUP BY Location
ORDER BY Revenue DESC;

# Average Order Value by Location
SELECT
Location,
ROUND(AVG(`Total Spent`),2) AS Average_Order_Value
FROM cafe_sales
GROUP BY Location
ORDER BY Average_Order_Value;

# Monthly Sales Trend
# Monthly Revenue
SELECT
    MONTH(`Transaction Date`) AS Month_Number,
    MONTHNAME(`Transaction Date`) AS Month_Name,
    ROUND(SUM(`Total Spent`),2) AS Revenue
FROM cafe_sales
WHERE `Transaction Date` IS NOT NULL
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;

# Monthly Transactions
SELECT
MONTH(`Transaction Date`) AS Month_Number,
MONTHNAME(`Transaction Date`) AS Month_Name,
COUNT(*) AS Total_Transactions
FROM cafe_sales
WHERE `Transaction Date` IS NOT NULL
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;

# Monthly Average Order Value
SELECT
MONTH(`Transaction Date`) AS Month_Number,
MONTHNAME(`Transaction Date`) AS Month_Name,
ROUND(AVG(`Total Spent`),2) AS Average_Order_Value
FROM cafe_sales
WHERE `Transaction Date` IS NOT NULL
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;

# . Top 10 Highest Value Transactions
SELECT
`Transaction ID`,
Item,
Quantity,
`Total Spent`
FROM cafe_sales
WHERE `Total Spent` IS NOT NULL
ORDER BY `Total Spent` DESC
LIMIT 10;

# Top 5 Products by Revenue (Ranking)
SELECT
Item,
ROUND(SUM(`Total Spent`),2) AS Revenue,
RANK() OVER (
	ORDER BY SUM(`Total Spent`) DESC
) AS Revenue_Rank
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item;

# Create a View
CREATE VIEW product_sales_summary AS
SELECT
Item,
COUNT(*) AS Orders,
SUM(Quantity) AS Quantity_Sold,
ROUND(SUM(`Total Spent`),2) AS Revenue
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item;

SELECT * 
FROM product_sales_summary;

# Top 10 Highest Value Transactions
SELECT
`Transaction ID`,
Item,
Quantity,
`Total Spent`
FROM cafe_sales
WHERE `Total Spent` IS NOT NULL
ORDER BY `Total Spent` DESC
LIMIT 10;

# Product Revenue Ranking
SELECT
Item,
ROUND(SUM(`Total Spent`),2) AS Revenue,
RANK() OVER(ORDER BY SUM(`Total Spent`) DESC) AS Revenue_Rank
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item;

SELECT * 
FROM product_sales_summary;
