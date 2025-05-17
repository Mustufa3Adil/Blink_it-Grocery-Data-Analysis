CREATE TABLE blinkit_grocery_data (
    Item_Fat_Content           varchar(255),
	Item_Identifier            varchar(255),
	Item_Type                  varchar(255),
	Outlet_Establishment_Year int,
	Outlet_Identifier          varchar(255),
    Outlet_Location_Type       varchar(255),
	Outlet_Size                varchar(255),
    Outlet_Type                varchar(255),
    Item_Visibility            float,
	Item_Weight                float,
    Item_Outlet_Sales          float,
	Rating                   float
);


select * from blinkit_grocery_data

DATA CLEANING:Cleaning the Item_Fat_Content field ensures data consistency and accuracy in analysis. The presence of multiple variations of the same category (e.g., LF, low fat vs. Low Fat) can cause issues in reporting, aggregations, and filtering. By standardizing these values, we improve data quality, making it easier to generate insights and maintain uniformity in our datasets.

UPDATE blinkit_grocery_data
SET Item_Fat_Content = 
CASE 
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END;
	
	
SELECT DISTINCT Item_Fat_Content FROM blinkit_grocery_data;

SELECT * FROM blinkit_grocery_data

1. TOTAL SALES:

SELECT CAST(SUM("item_outlet_sales") / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_grocery_data;


2. AVERAGE SALES

SELECT CAST(AVG("item_outlet_sales") AS INT) AS Avg_Sales
FROM blinkit_grocery_data;

3. NO OF ITEMS

SELECT COUNT(*) AS No_of_Orders
FROM blinkit_grocery_data;

4. AVG RATING

SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM blinkit_grocery_data;


B. Total Sales by Fat Content:

SELECT Item_Fat_Content, CAST(SUM("item_outlet_sales") AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_grocery_data
GROUP BY Item_Fat_Content


C. Total Sales by Item Type

SELECT Item_Type, CAST(SUM("item_outlet_sales") AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_grocery_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

D. Fat Content by Outlet for Total Sales

SELECT 
    Outlet_Location_Type,
    COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Item_Outlet_Sales END), 0) AS Low_Fat,
    COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Item_Outlet_Sales END), 0) AS Regular
FROM 
    blinkit_grocery_data
GROUP BY 
    Outlet_Location_Type
ORDER BY 
    Outlet_Location_Type;



E. Total Sales by Outlet Establishment

SELECT Outlet_Establishment_Year, CAST(SUM(  "item_outlet_sales") AS DECIMAL(10,2)) AS "item_outlet_sales"
FROM blinkit_grocery_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year


F. Percentage of Sales by Outlet Size

SELECT 
    Outlet_Size, 
    CAST(SUM( "item_outlet_sales") AS DECIMAL(10,2)) AS "item_outlet_sales",
    CAST((SUM( "item_outlet_sales") * 100.0 / SUM(SUM( "item_outlet_sales")) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_grocery_data
GROUP BY Outlet_Size
ORDER BY "item_outlet_sales" DESC;


G. Sales by Outlet Location

SELECT Outlet_Location_Type, CAST(SUM("item_outlet_sales") AS DECIMAL(10,2)) AS "item_outlet_sales"
FROM blinkit_grocery_data
GROUP BY Outlet_Location_Type
ORDER BY "item_outlet_sales" DESC




H. All Metrics by Outlet Type:

SELECT Outlet_Type, 
CAST(SUM("item_outlet_sales") AS DECIMAL(10,2)) AS "item_outlet_sales",
		CAST(AVG("item_outlet_sales") AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_grocery_data
GROUP BY Outlet_Type
ORDER BY "item_outlet_sales" DESC

