/*Récuperation du prix moyen de paniers contenant un article Avènes*/
SELECT 

	ROUND(AVG(base_grand_total),2) AS average_price_with_avene 
    
FROM mage_sd.sales_flat_order o
INNER JOIN mage_sds.ales_flat_order_item s ON o.entity_id = s.order_id
INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=25;