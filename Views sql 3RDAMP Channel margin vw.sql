-- vw_channel_margin_report: Profitability comparison across online vs in-store
-- This view assumes 'Order Mode' in dim_order_mode differentiates between channels.
CREATE VIEW star_schema.vw_channel_margin_report AS
SELECT
    dom.order_mode AS Sales_Channel,
    SUM(fs.Total_sales) AS Total_Sales_Channel,
    SUM(fs.Total_cost) AS Total_Cost_Channel,
    SUM(fs.Profit) AS Total_Profit_Channel,
    (SUM(fs.Profit) / SUM(fs.Total_sales)) * 100 AS Profit_Margin_Percentage
FROM
    star_schema.fact_sales fs
JOIN
    star_schema.dim_order_mode dom ON fs.order_mode_key = dom.order_mode_key
GROUP BY
    dom.order_mode
ORDER BY
    Profit_Margin_Percentage DESC;