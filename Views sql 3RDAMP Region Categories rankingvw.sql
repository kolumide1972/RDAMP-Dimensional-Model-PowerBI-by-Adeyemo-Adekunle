-- vw_region_category_rankings: Rank categories by profit margin per region
-- Identifying most profitable categories by region.
CREATE VIEW star_schema.vw_region_category_rankings AS
SELECT
    dl.region,
    dcat.category_name,
    SUM(fs.Total_sales) AS Total_Sales_Region_Category,
    SUM(fs.Profit) AS Total_Profit_Region_Category,
    (SUM(fs.Profit) / SUM(fs.Total_sales)) * 100 AS Profit_Margin_Percentage,
    RANK() OVER (PARTITION BY dl.region ORDER BY (SUM(fs.Profit) / SUM(fs.Total_sales)) DESC) AS Category_Profit_Rank_in_Region
FROM
    star_schema.fact_sales fs
JOIN
    star_schema.dim_location dl ON fs.location_refn = dl.location_refn -- Use location_refn from fact_sales
JOIN
    star_schema.dim_category dcat ON fs.category_key = dcat.category_key
GROUP BY
    dl.region,
    dcat.category_name
ORDER BY
    dl.region,
    Category_Profit_Rank_in_Region;
