/*Selection of the average number of products in a command where an avenes product is included*/
/*Selection of the average price of a command where an avenes product is included*/


SELECT AVG(number_prod) AS Average_number_of_product_per_order_with_avenes, AVG(avg_price) AS Average_price_per_order_with_avenes
FROM( 
	SELECT 
	COUNT(item_id) as number_prod, i.order_id as Order_with_Prod, o.base_grand_total AS avg_price
		FROM mage_sd.sales_flat_order_item i
		INNER JOIN (
		SELECT DISTINCT order_id 
				FROM mage_sd.sales_flat_order_item s
				INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
				INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=25
		) t ON t.order_id=i.order_id
		INNER JOIN sales_flat_order o ON o.entity_id=i.order_id 
	GROUP BY i.order_id
    ) as too