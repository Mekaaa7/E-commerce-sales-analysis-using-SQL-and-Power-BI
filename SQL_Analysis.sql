CREATE DATABASE ecommerce_project;
use ecommerce_project;
SHOW TABLES;
SELECT COUNT(*)
FROM ecommerce_sales;
SELECT *
FROM ecommerce_sales
LIMIT 5;

SELECT
COUNT(*) - COUNT(Product) AS missing_product,
COUNT(*) - COUNT(Category) AS missing_category,
COUNT(*) - COUNT(Price) AS missing_price,
COUNT(*) - COUNT(Rating) AS missing_rating
FROM ecommerce_sales;

ALTER TABLE ecommerce_sales
RENAME COLUMN `ï»¿OrderID` TO OrderID;

SELECT OrderID,
COUNT(*) AS duplicate_count
FROM ecommerce_sales
GROUP BY OrderID
HAVING COUNT(*) > 1;

SELECT *
FROM ecommerce_sales
WHERE ABS((Price * Quantity) - TotalAmount) > 0.01;

SELECT ROUND(SUM(TotalAmount),2) AS Total_Revenue
FROM ecommerce_sales;

SELECT Count(*) As Total_orders
From ecommerce_sales;

SELECT round(AVG(TotalAmount),2) AS Avg_Order_Value
From ecommerce_sales;
Select Round(AVG(Rating),2) As Avg_Rating
FROM ecommerce_sales;
SELECT Category, round(SUM(TotalAmount),2) As Revenue
From ecommerce_sales
Group By Category
Order By Revenue desc;
SELECT
Product,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM ecommerce_sales
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 10;
SELECT
Product,
ROUND(AVG(Rating),2) AS Avg_Rating,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM ecommerce_sales
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 10;
SELECT
Category,
ROUND(AVG(Rating),2) AS Avg_Rating,
ROUND(SUM(TotalAmount),2) AS Revenue
FROM ecommerce_sales
GROUP BY Category
ORDER BY Revenue DESC;

SELECT
City,
ROUND(SUM(TotalAmount),2) AS Revenue,
COUNT(*) AS Orders
FROM ecommerce_sales
GROUP BY City
ORDER BY Revenue DESC;

SELECT
    Product,
    ROUND(SUM(TotalAmount),2) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(TotalAmount) DESC
    ) AS Revenue_Rank
FROM ecommerce_sales
GROUP BY Product;
SELECT
    Product,
    SUM(TotalAmount) Revenue,
    ROUND(
        SUM(TotalAmount) *100 /
        SUM(SUM(TotalAmount)) OVER(),
        2
    ) AS Revenue_Percentage
FROM ecommerce_sales
GROUP BY Product;
SELECT
    OrderDate,
    SUM(TotalAmount) Daily_Revenue,

    SUM(SUM(TotalAmount))
    OVER(
        ORDER BY OrderDate
    ) Running_Revenue
FROM ecommerce_sales
GROUP BY OrderDate;
WITH product_revenue AS
(
    SELECT
        Category,
        Product,
        SUM(TotalAmount) Revenue,

        RANK() OVER(
            PARTITION BY Category
            ORDER BY SUM(TotalAmount) DESC
        ) rnk

    FROM ecommerce_sales
    GROUP BY Category, Product
)

SELECT *
FROM product_revenue
WHERE rnk = 1;

SELECT
    Product,
    Rating,
    CASE
        WHEN Rating >= 4 THEN 'Good'
        WHEN Rating >= 3 THEN 'Average'
        ELSE 'Poor'
    END AS Rating_Category
FROM ecommerce_sales;

SELECT
    MONTHNAME(OrderDate) AS Month,
    ROUND(SUM(TotalAmount),2) AS Revenue
FROM ecommerce_sales
GROUP BY MONTH(OrderDate), MONTHNAME(OrderDate)
ORDER BY MONTH(OrderDate);
SELECT
    Platform,
    ROUND(SUM(TotalAmount),2) AS Revenue
FROM ecommerce_sales
GROUP BY Platform
ORDER BY Revenue DESC;















