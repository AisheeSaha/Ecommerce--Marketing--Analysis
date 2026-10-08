-- We will solve business problems only, so let's get started! 

/* 1. Identify the key revenue and sales-volume drivers across products, categories, and regions. */
--Across Products
       SELECT Product_ID, 
       Round(SUM(Revenue),2) AS total_revenue,
       SUM(Units_Sold) AS total_unit_sold
       FROM Sales_Marketing_Dataset
       GROUP BY Product_ID
       ORDER BY total_revenue

-- Categories
        SELECT Category, 
       Round(SUM(Revenue),2) AS total_revenue,
       SUM(Units_Sold) AS total_unit_sold
       FROM Sales_Marketing_Dataset
       GROUP BY Category
       ORDER BY total_revenue;

--Regions
        SELECT Region, 
       Round(SUM(Revenue),2) AS total_revenue,
       SUM(Units_Sold) AS total_unit_sold
       FROM Sales_Marketing_Dataset
       GROUP BY Region
       ORDER BY total_revenue;
/* 2. Evaluate how discount levels are associated with revenue and units sold across
products and categories. */
--Across products 
        SELECT Product_ID, round(Discount_Applied,2) AS discounts ,
       Round(SUM(Revenue),2) AS total_revenue,
       SUM(Units_Sold) AS total_unit_sold
       FROM Sales_Marketing_Dataset
       GROUP BY Product_ID, round(Discount_Applied,2)
       ORDER BY discounts DESC;

--categories
        SELECT Category, round(Discount_Applied,2) AS discounts ,
       Round(SUM(Revenue),2) AS total_revenue,
       SUM(Units_Sold) AS total_unit_sold
       FROM Sales_Marketing_Dataset
       GROUP BY Category, round(Discount_Applied,2)
       ORDER BY discounts DESC;
        

/* 3. Evaluate advertising performance across products , 
categories, and regions using ad-spend,CTR,and conversion rate . */
--Across Products
        SELECT Product_ID,
        round(SUM(Ad_Spend),2) AS total_ad_spend,
       round( AVG(Ad_CTR),2) AS avg_ad_ctr,
       round( AVG(Conversion_Rate),2) AS avg_conversion_rate
        FROM Sales_Marketing_Dataset
        GROUP BY Product_ID
        ORDER BY total_ad_spend DESC;

--category
          SELECT Category,
        round(SUM(Ad_Spend),2) AS total_ad_spend,
       round( AVG(Ad_CTR),2) AS avg_ad_ctr,
       round( AVG(Conversion_Rate),2) AS avg_conversion_rate
        FROM Sales_Marketing_Dataset
        GROUP BY Category
        ORDER BY total_ad_spend DESC;

--Region 
         SELECT Region,
        round(SUM(Ad_Spend),2) AS total_ad_spend,
       round( AVG(Ad_CTR),2) AS avg_ad_ctr,
       round( AVG(Conversion_Rate),2) AS avg_conversion_rate
        FROM Sales_Marketing_Dataset
        GROUP BY Region
        ORDER BY total_ad_spend DESC;


/* 4. Identify products,categories, and regions where advertising spend is high
relative to revenue generated. */

--products 
SELECT Product_ID,
ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
ROUND(SUM(Revenue),2) AS total_revenue,
ROUND(SUM(Ad_Spend) / SUM(Revenue),2) AS ad_spend_to_revenue_pct
FROM Sales_Marketing_Dataset
GROUP BY Product_ID
ORDER BY ad_spend_to_revenue_pct DESC;

--category
SELECT Category,
ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
ROUND(SUM(Revenue),2) AS total_revenue,
ROUND(SUM(Ad_Spend) / SUM(Revenue),2) AS ad_spend_to_revenue_pct
FROM Sales_Marketing_Dataset
GROUP BY Category
ORDER BY ad_spend_to_revenue_pct DESC;

--regions
SELECT Region,
ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
ROUND(SUM(Revenue),2) AS total_revenue,
ROUND(SUM(Ad_Spend) / SUM(Revenue),2) AS ad_spend_to_revenue_pct
FROM Sales_Marketing_Dataset
GROUP BY Region
ORDER BY ad_spend_to_revenue_pct DESC;

/* 5. Compare marketing efficiency across products, categories, and regions
based on revenue generated per unit of advertising spend.*/
 --products
 SELECT Product_ID,
 ROUND(SUM(Revenue),2) AS total_revenue,
 ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
 Round(SUM(Revenue) / SUM(Ad_Spend),2) AS ROAS --(return on advertising spend)
 FROM Sales_Marketing_Dataset
 GROUP BY Product_ID
 ORDER BY ROAS DESC;

 --category 
 SELECT Category,
 ROUND(SUM(Revenue),2) AS total_revenue,
 ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
 Round(SUM(Revenue) / SUM(Ad_Spend),2) AS ROAS --(return on advertising spend)
 FROM Sales_Marketing_Dataset
 GROUP BY Category
 ORDER BY ROAS DESC;

 --region
 SELECT Region,
 ROUND(SUM(Revenue),2) AS total_revenue,
 ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
 Round(SUM(Revenue) / SUM(Ad_Spend),2) AS ROAS --(return on advertising spend)
 FROM Sales_Marketing_Dataset
 GROUP BY Region
 ORDER BY ROAS DESC;
/* 6. Analyze customer purchasing patterns and their contribution to overall revenue.*/
SELECT Customer_ID,
COUNT(Transaction_ID) AS transaction_id,
ROUND(SUM(Revenue),2) AS total_revenue,
SUM(Units_Sold) AS total_units_sold
FROM Sales_Marketing_Dataset
GROUP BY Customer_ID;
/* 7. Examine revenue and units-sold trends over time and identify notable
changes in sales performance.*/
 WITH Monthly_Sales AS (
    SELECT
        Transaction_Year,
        Transaction_Months,
        ROUND(SUM(Revenue),2) AS total_revenue,
        ROUND(SUM(Units_Sold),2) AS total_units_sold
    FROM Sales_Marketing_Dataset
    GROUP BY
        Transaction_Year,
        Transaction_Months
)

SELECT
    Transaction_Year,
    Transaction_Months,
    total_revenue,
    total_units_sold,

    LAG(total_revenue) OVER (
        ORDER BY Transaction_Year , Transaction_Months
    ) AS previous_revenue,

    total_revenue -
        LAG(total_revenue) OVER (
            ORDER BY Transaction_Year , Transaction_Months
        ) AS revenue_change

FROM Monthly_Sales
ORDER BY Transaction_Year, Transaction_Months;
/* 8. Identify top-performing and underperforming products based on revenue and units sold. */
--top-performing 
SELECT TOP 10 Product_ID, ROUND(SUM(Revenue),2) AS  total_revenue,
ROUND(SUM(Units_Sold),2) AS total_unit_sold
FROM Sales_Marketing_Dataset
GROUP BY Product_ID
ORDER BY total_revenue DESC;

--underperforming
SELECT TOP 10 Product_ID, ROUND(SUM(Revenue),2) AS  total_revenue,
ROUND(SUM(Units_Sold),2) AS total_unit_sold
FROM Sales_Marketing_Dataset
GROUP BY Product_ID
ORDER BY total_revenue;

/* 9.Analyze the relationship between advertising cost, 
cost per click, and conversion rate across categories and regions. */
--categories 
SELECT Category,
ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
ROUND(AVG(Ad_CPC),2) AS avg_ad_cpc,
ROUND(AVG(Conversion_Rate),2) AS avg_conversion_rate
FROM Sales_Marketing_Dataset
GROUP BY Category
ORDER BY total_ad_spend DESC;

--regions
SELECT Region,
ROUND(SUM(Ad_Spend),2) AS total_ad_spend,
ROUND(AVG(Ad_CPC),2) AS avg_ad_cpc,
ROUND(AVG(Conversion_Rate),2) AS avg_conversion_rate
FROM Sales_Marketing_Dataset
GROUP BY Region
ORDER BY total_ad_spend DESC;

/* 10. Identify the products and categories contrubutiong the most to overall 
revenue and sales volume. */
--products 
SELECT Product_ID,ROUND(SUM(Revenue),2) AS total_revenue,
ROUND(SUM(Units_Sold),2) AS total_units_sold
FROM Sales_Marketing_Dataset
GROUP BY Product_ID
ORDER BY total_revenue,total_units_sold DESC;

--category
SELECT Category,ROUND(SUM(Revenue),2) AS total_revenue,
ROUND(SUM(Units_Sold),2) AS total_units_sold
FROM Sales_Marketing_Dataset
GROUP BY Category
ORDER BY total_revenue,total_units_sold DESC;





