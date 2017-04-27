/*Recuperation of the number of orders where the first choice is a product from Avenes*/

SELECT COUNT(ord) AS Number_of_orders_with_Avens_as_first_choice

	FROM(
    
		SELECT ord, ite, pro
		
			FROM ( 
			
				SELECT 
				s.order_id AS ord, item_id AS ite, sku AS pro

				FROM mage_sd.sales_flat_order_item s

				INNER JOIN(
						SELECT DISTINCT order_id 
						FROM mage_sd.sales_flat_order_item s
						INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
						INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=25
				) t ON t.order_id=s.order_id
				
				GROUP BY s.order_id
			)p
		
			WHERE pro IN (
				SELECT s.sku
				
					FROM mage_sd.sales_flat_order_item s
					INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
					INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=25
			) 
	)as cd