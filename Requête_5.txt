/*Récuperation de la moyenne du nombre de produts par commande contenant un article Avènes*/
SELECT AVG(count_prod) AS average_number_of_product

FROM(
    
	SELECT COUNT(DISTINCT product_id) AS count_prod
    
		FROM  mage_sd.sales_flat_order_item s 
		INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
		INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=25
            
		GROUP BY s.order_id
    
	)

AS temp ;