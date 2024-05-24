create database project
use project


--Show all Sales records
SELECT * FROM [dbo].[Sales Sample Data]

--Show the start date of the sales and End date of the sales 
SELECT MIN(orderdate) AS start_date, MAX(orderdate) AS end_date
FROM [dbo].[Sales Sample Data]


---Checking unique sales records
select distinct status from [dbo].[Sales Sample Data]  -- 6 status -> Resolved, On Hold, Cancelled, Shipped, Dispatched, In Process

select distinct year_id from [dbo].[Sales Sample Data] -- 3 years -> 2003, 2004, 2005
	
select distinct PRODUCTLINE from[dbo].[Sales Sample Data] -- 7 products -> Trains, Motorccyle, Ships, Trucks and Buses, Vintage Cars, Classic Cars, Planes
 
select distinct COUNTRY from [dbo].[Sales Sample Data]  -- 19 countries -> From Finland to Singapore

select distinct DEALSIZE from [dbo].[Sales Sample Data]  -- 3 sizes -> Large, Medium, Small

select distinct TERRITORY from [dbo].[Sales Sample Data]  -- 4 territories -> EMCA, APAC, Japan, NA

select distinct MONTH_ID from [dbo].[Sales Sample Data]

where year_id = 2003;


---- Find the maximum sales amount
SELECT MAX(sales) AS max_sales
FROM [dbo].[Sales Sample Data];

-- Find the minimum sales amount
SELECT MIN(sales) AS min_sales
FROM [dbo].[Sales Sample Data];


--TO find which year has the maximum sales 
SELECT TOP 1
 orderdate,
    SUM(sales) AS total_sales
FROM 
    [dbo].[Sales Sample Data]
GROUP BY 
    orderdate
ORDER BY 
    total_sales DESC;

--productline Individual Maxium Sales
SELECT ProductLine, MAX(sales) AS max_sales
FROM [dbo].[Sales Sample Data]
GROUP BY ProductLine;

--To find the maximum andn minimum order details with respect to countrywise
SELECT 
    country,
    MIN(quantityOrdered) AS min_quantity_ordered,
    MAX(quantityOrdered) AS max_quantity_ordered
FROM 
    [dbo].[Sales Sample Data]
GROUP BY 
    country;

--To Find the most productline with respect to the countries 

SELECT 
    country,
    ProductLine AS most_sold_productline,
    COUNT(ProductLine) AS total_sales
FROM 
    [dbo].[Sales Sample Data]
GROUP BY 
    country, ProductLine
HAVING 
    COUNT(ProductLine) = (
        SELECT MAX(productline_count)
        FROM (
            SELECT 
                country,
                COUNT(ProductLine) AS productline_count
            FROM 
                [dbo].[Sales Sample Data]
            GROUP BY 
                country, ProductLine
        ) AS counts
        WHERE counts.country = [dbo].[Sales Sample Data].country
    );