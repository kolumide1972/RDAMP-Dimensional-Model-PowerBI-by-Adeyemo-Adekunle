-- vw_customer_order_pattern: Average order value, frequency, and profit per customer segment
-- This view provides insights into customer behavior based on their segment.
CREATE VIEW star_schema.vw_customer_order_pattern AS
SELECT
    ds.segment_name,
    dc.customer_id, -- customer_id for individual customer analysis within segments
    COUNT(DISTINCT fs.date_key) AS Order_Frequency_Days, -- Number of distinct days a customer ordered
    SUM(fs.Total_sales) AS Total_Sales_Per_Customer,
    SUM(fs.Quantity) AS Total_Quantity_Per_Customer,
    SUM(fs.Profit) AS Total_Profit_Per_Customer,
    AVG(fs.Total_sales / fs.Quantity) AS Average_Unit_Price, -- Average price per unit sold
    SUM(fs.Total_sales) / COUNT(DISTINCT fs.date_key) AS Average_Order_Value_Per_Day -- Simplified AOV
FROM
    star_schema.fact_sales fs
JOIN
    star_schema.dim_customer dc ON fs.customer_key = dc.customer_key
JOIN
    star_schema.dim_segment ds ON fs.segment_key = ds.segment_key
GROUP BY
    ds.segment_name,
    dc.customer_id
ORDER BY
    ds.segment_name,
    Total_Sales_Per_Customer DESC;
