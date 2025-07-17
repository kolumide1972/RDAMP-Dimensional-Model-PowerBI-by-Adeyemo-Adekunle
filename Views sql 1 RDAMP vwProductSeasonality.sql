CREATE VIEW star_schema.vw_product_seasonality AS
SELECT
dp.product_name,
dd.year,
dd.month_name,
SUM(fs.Total_sales) AS Total_Sales_Amount,
SUM(fs.Quantity) AS Total_Quantity_Sold
FROM
star_schema.fact_sales fs
JOIN
star_schema.dim_product dp ON fs.product_key = dp.product_key
JOIN
star_schema.dim_date dd ON fs.date_key = dd.date_key
GROUP BY
dp.product_name,
dd.year,
dd.month_name
ORDER BY
dp.product_name,
dd.year,
dd.month_name; -- Assuming dim_date has a month_number for correct ordering
