CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_region_category_rankings` AS
 select `dl`.`region` AS `region`,`dcat`.`category_name` AS `category_name`,sum(`fs`.`Total_sales`) AS 
 `Total_Sales_Region_Category`,sum(`fs`.`Profit`) AS `Total_Profit_Region_Category`,
 ((sum(`fs`.`Profit`) / sum(`fs`.`Total_sales`)) * 100) AS `Profit_Margin_Percentage`,
 rank() OVER (PARTITION BY `dl`.`region` ORDER BY (sum(`fs`.`Profit`) / sum(`fs`.`Total_sales`)) desc ) 
 AS `Category_Profit_Rank_in_Region` from 
 ((`fact_sales` `fs` join `dim_location` `dl` on((`fs`.`location_refn` = `dl`.`location_refn`)))
 join `dim_category` `dcat` on((`fs`.`category_key` = `dcat`.`category_key`))) 
 group by `dl`.`region`,`dcat`.`category_name` order by `dl`.`region`,`Category_Profit_Rank_in_Region`;
SELECT * FROM star_schema.vw_region_category_rankings;