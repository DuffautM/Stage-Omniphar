/*Return the number of clients who had an order with an Avenes product*/

SELECT COUNT(avenes_buyer) As number_avenes_buyer

FROM (

	SELECT DISTINCT o.customer_id as avenes_buyer, order_id
		FROM sales_flat_order o
		INNER JOIN mage_sd.sales_flat_order_item s ON o.entity_id = s.order_id
		INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
		INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=25
) result