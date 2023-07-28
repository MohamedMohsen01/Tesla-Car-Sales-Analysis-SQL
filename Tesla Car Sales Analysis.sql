
--First, I cleaned the data in Excel and adjusted the date format.

USE TeslaSales

-- Adding a new column as a primary key called 'id'
ALTER TABLE CarSales
ADD id INT IDENTITY(1,1) NOT NULL PRIMARY KEY;

-- Altering Model column and making sure the column is not null
ALTER TABLE CarSales
ALTER COLUMN Model VARCHAR(50) NOT NULL;

-- Ensuring the Period column is not null and is of DATE data type
ALTER TABLE CarSales
ALTER COLUMN Period DATE NOT NULL;

-- Ensuring the Country column is not null
ALTER TABLE CarSales
ALTER COLUMN Country VARCHAR(50) NOT NULL;

-- Ensuring the Purchase_type column is not null
ALTER TABLE CarSales
ALTER COLUMN Purchase_type VARCHAR(50) NOT NULL;

-- Ensuring the Version column is not null
ALTER TABLE CarSales
ALTER COLUMN Version VARCHAR(50) NOT NULL;

-- Ensuring the Price column is not null and using DECIMAL data type for currency values
ALTER TABLE CarSales
ALTER COLUMN  Price DECIMAL(10,3) NOT NULL;

-- Ensure the Gross_Profit column is not null and use DECIMAL data type for currency values
ALTER TABLE CarSales
ALTER COLUMN Gross_Profit DECIMAL(10,3) NOT NULL;



 --Retrieving all the columns and rows from the table
SELECT *
FROM CarSales;


--What date range are we dealing with in this dataset?
SELECT MIN(Period) AS Min_Period, MAX(Period) AS Max_Period
FROM CarSales;																	


-- Are there any outliers in the car prices or gross profits?
  SELECT 
  MAX(Price) AS max_price,
  MIN(Price) AS min_price,
  MAX(Gross_Profit) AS max_profit,
  MIN(Gross_Profit) AS min_profit
FROM CarSales;


-- Let's determine the number of unique car models in the data
SELECT COUNT(DISTINCT Model) AS no_of_models
FROM CarSales;																	


--What is the total number of sales transactions in the dataset?
SELECT COUNT(id) AS no_total_sal
FROM CarSales;																	


--Which purchase type is most commonly used by people?
SELECT TOP 1 Purchase_type, COUNT(*) AS no_of_purchases 
FROM CarSales
GROUP BY Purchase_type
ORDER BY no_of_purchases DESC;													


--Which car version is the most popular among buyers?
SELECT Version, COUNT(*) AS no_of_versions 
FROM CarSales
GROUP BY Version
ORDER BY no_of_versions DESC;													


--What is the cumulative gross profit for both first and second quarters of year 2016? 
SELECT SUM(Gross_Profit) AS total_profit
FROM CarSales
WHERE Period >= '2016-01' AND Period <= '2016-06';


--What is the total sales for the first and second quarters of year 2016? 
SELECT SUM(Price) AS total_Sales
FROM CarSales
WHERE Period >= '2016-01' AND Period <= '2016-06';


--What is the most frequent purchase type?
SELECT TOP 1 Purchase_type, COUNT(*) AS Frequent_Purchase
FROM CarSales
GROUP BY Purchase_type
ORDER BY COUNT(*) DESC;


--What is the car version with the highest price?
SELECT TOP 1 Version, Price
FROM CarSales
ORDER BY Price DESC;


-- Which car version is generating the highest total sales?
SELECT TOP 1 Version, SUM(Price) AS Total_Sales
FROM CarSales
GROUP BY Version	
ORDER BY Total_Sales DESC;


--How does the average gross profit vary across different car versions for each country?
SELECT Country, Version, AVG(Gross_Profit) AS Avg_Gross_Profit
FROM CarSales
GROUP BY Country, Version
ORDER BY Country, Avg_Gross_Profit DESC;


-- what is the most sold car version in each country?
SELECT *
FROM (
  SELECT Country, Version, 
         ROW_NUMBER() OVER (PARTITION BY Country ORDER BY COUNT(*) DESC) AS RN
  FROM CarSales
  GROUP BY Country, Version
) AS sales_version
WHERE RN = 1;


-- Which car version is generating the highest total gross profit?
SELECT TOP 1 Version, SUM(Gross_Profit) AS Total_Profit
FROM CarSales
GROUP BY Version
ORDER BY Total_Profit DESC;


--Which Tesla car models do we have in our dataset?
SELECT DISTINCT Model from CarSales;


--What is the total gross profit and sales for each country?
SELECT Country, SUM(Gross_Profit) AS Total_Gross_Profit, SUM(Price) AS Total_Sales
FROM CarSales
GROUP BY Country
ORDER BY Total_Gross_Profit DESC;


-- Which model has the highest total gross profit?
SELECT Model, SUM(Gross_Profit) AS Total_Profit
FROM CarSales
GROUP BY Model
ORDER BY Total_Profit DESC;															


--What is the average sales price for each car model?
SELECT Model, AVG(Price) AS Avg_Price
FROM CarSales
GROUP BY Model
ORDER BY Avg_Price DESC;


--How many car models were sold in the US in January 2016?
SELECT Model, COUNT(DISTINCT Model) AS us_no_models
FROM CarSales
WHERE (Country = 'US') AND (Period = '2016-01')
GROUP BY Model;																		


--Which country had the highest demand for Tesla cars?
SELECT Country, COUNT(*) AS no_demand_cars
FROM CarSales
GROUP BY Country
ORDER BY no_demand_cars DESC;															


--How many unique car models were sold in the Australia in January 2016?
SELECT Model, COUNT(DISTINCT Model) AS AU_no_models
FROM CarSales
WHERE (Country = 'Australia') AND (Period = '2016-01')
GROUP BY Model;	


--What was the total gross profit generated from all sales in Germany?
SELECT Country, ROUND(SUM(Gross_Profit),3) AS Ger_total_prof
FROM CarSales
WHERE Country = 'Germany'
GROUP BY Country;																	


--What is the distribution of purchase types for each car model?
SELECT Model, Purchase_type, COUNT(*) AS Frequency
FROM CarSales
GROUP BY Model, Purchase_type
ORDER BY Model, Frequency DESC;


--What is the average price of all cars sold in the US?
SELECT Country, ROUND(AVG(Price),3) AS US_avg_Price
FROM CarSales 
WHERE Country = 'US'
Group BY Country;


--Which car version had the highest price in the US?
SELECT Model, ROUND(SUM(Price), 2) AS US_total_price
FROM CarSales
WHERE Country = 'US'
GROUP BY Model
ORDER BY US_total_price DESC;														


--Which car version had the highest price in Australia?
SELECT Model, ROUND(SUM(Price), 2) AS AU_total_price
FROM CarSales
WHERE Country = 'Australia'
GROUP BY Model
ORDER BY AU_total_price DESC;


--What was the total sales generated from all sales in Australia?
SELECT Country, ROUND(SUM(Price),3) AS AU_total_sal
FROM CarSales
WHERE Country = 'Australia'
GROUP BY Country;																																		


--Which country had the highest total sales?
SELECT Country, sum(Price) AS total_sales
FROM CarSales
GROUP BY Country
ORDER BY total_sales DESC;															


--Which country had the highest number of cash purchases?
SELECT TOP 1 Country, COUNT(*) AS no_Purchase
FROM CarSales
WHERE Purchase_type = 'Cash purchase'
GROUP BY Country
ORDER BY no_Purchase DESC;


-- What is the total sales for each purchase type?
SELECT Purchase_type, SUM(Price) AS Total_Sales
FROM CarSales
GROUP BY Purchase_type
ORDER BY Total_Sales DESC;


-- What is the average gross profit for each purchase type?
SELECT Purchase_type, AVG(Gross_Profit) AS Total_Sales
FROM CarSales
GROUP BY Purchase_type
ORDER BY Total_Sales DESC;
														

--How many different car versions were sold in the US?
SELECT Model, COUNT(*) AS no_model_us
FROM CarSales
WHERE Country = 'US'
GROUP BY Model;																		


--What is the distribution of car prices in the US for January 2016?
SELECT Price, COUNT(*) AS Frequency
FROM CarSales  
WHERE Country = 'US' AND Period >= '2016-01' AND Period < '2016-02'
GROUP BY Price
ORDER BY Frequency DESC;


-- What is the highest car price in each country
SELECT Country, Price
FROM (SELECT Country, Price, ROW_NUMBER() OVER(PARTITION BY Country ORDER BY SUM(Price) DESC) AS RN
		FROM CarSales
		GROUP BY Country, Price) as NewTable
WHERE RN = 1;


--Which purchase type is most commonly used in each country?
SELECT Country, Purchase_type
FROM (SELECT Country, Purchase_type, ROW_NUMBER() OVER(PARTITION BY Country ORDER BY count(*) DESC) AS RN
		FROM CarSales
		GROUP BY Country, Purchase_type) as NewTable
WHERE RN = 1;


--Which car model generated the highest gross profit in Germany?
SELECT Model, SUM(Gross_Profit) AS total_Prof
FROM CarSales
WHERE Country = 'Germany'
GROUP BY Model
ORDER BY total_Prof DESC;															


--How many sales transactions were made for each car model in the US?
SELECT Model, Country, COUNT(id) AS us_no_trnascations
FROM CarSales
WHERE Country = 'US'
GROUP BY Model, Country;															


--What is the total gross profit for each car model in the dataset?
SELECT Model, SUM(Gross_Profit) AS total_Profit
FROM CarSales
GROUP BY Model
ORDER BY total_Profit DESC;															


--Which country had the highest average sales for the car models sold?
SELECT TOP 1 Country, Model, ROUND(AVG(Price),2) AS avg_sal
FROM CarSales
GROUP BY Country, Model
ORDER BY avg_sal;																	


-- what is the most sold car Model in each country
SELECT *
FROM (SELECT Country, Model, ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Model DESC) AS RN
		FROM CarSales) as sales_model
WHERE RN = 1;


--What was the most common purchase type for Model S in Germany?
SELECT Model, Purchase_type, COUNT(Purchase_type) AS no_Pur_type
FROM CarSales
WHERE Country = 'Germany' AND Model = 'Model S'
GROUP BY Model, Purchase_type
ORDER BY no_Pur_type DESC;															


 --What is the total gross profit generated from each car version in the US?
SELECT Model, SUM(Gross_Profit) AS US_totalprofit
FROM CarSales
WHERE Country = 'US'
GROUP BY Model;																		


--How many sales transactions were made for each car version in the US?
SELECT Model, COUNT(id) AS no_sal_trans
FROM CarSales
WHERE Country = 'US'
GROUP BY Model;																	    


--What was the most popular car model in terms of sales volume?
SELECT Model, SUM(Price) AS total_sales
FROM CarSales
GROUP BY Model
ORDER BY total_sales DESC;															


--How does the average price vary for different purchase types in the US?
SELECT Purchase_type, ROUND(AVG(Price), 3) AS d_avg_sales
FROM CarSales
WHERE Purchase_type = 'Deposit'
GROUP BY Purchase_type;																 


SELECT Purchase_type, ROUND(AVG(Price), 3) AS c_avg_sales
FROM CarSales
WHERE Purchase_type = 'Cash purchase'
GROUP BY Purchase_type;																


-- what is the monthly gross profit for each month?
WITH monthly_profit AS(
    SELECT Gross_Profit, 
    	CASE 
			WHEN right(Period, 2) = '01' THEN 'January'
    		WHEN right(Period, 2) = '02' THEN 'February'
    		WHEN right(Period, 2) = '03' THEN 'March'
    		WHEN right(Period, 2) = '04' THEN 'April'
    		WHEN right(Period, 2) = '05' THEN 'May'
    		WHEN right(Period, 2) = '06' THEN 'June'
    		ELSE Period 
		END AS Month
    	FROM CarSales
    )
    SELECT Month, sum(Gross_Profit) AS 'monthly_profit'
    FROM monthly_profit
    GROUP BY Month
    ORDER BY 'monthly_profit' DESC;


--Calculating the average car price (Price_Mean)
SELECT
  AVG(Price) AS Price_Mean,

--Calculating the standard deviation of car prices (Price_StdDev)
  STDEV(Price) AS Price_StdDev,

--Calculating the average gross profit (Profit_Mean)
  AVG(Gross_Profit) AS Profit_Mean,

--Calculating the standard deviation of gross profits (Profit_StdDev) 
  STDEV(Gross_Profit) AS Profit_StdDev
FROM CarSales; 


--Is there a correlation between car price and gross profit?
SELECT 
  (SUM(Price * Gross_Profit) - COUNT(*) * AVG(Price) * AVG(Gross_Profit)) /
  (COUNT(*) * STDEV(Price) * STDEV(Gross_Profit)) AS CorrelationCoefficient
FROM CarSales;

 /* Yes, there is a correlation between car price and gross profit.
 The correlation coefficient of 0.1201 between car price and gross profit suggests a relatively weak positive correlation between these two variables. 
 This means that there is a slight tendency for higher car prices to be associated with slightly higher gross profits, but the relationship is not very strong. 
 The value being positive indicates that when car prices increase, gross profits also tend to increase to some extent.*/



