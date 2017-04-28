SELECT s.store_id, s.product_id, s.sku, s.name AS Nom, LEFT(postcode, 2) AS Departement, COUNT(s.sku) AS Quantite

	FROM mage_sd.sales_flat_order_address a
		
        INNER JOIN mage_sd.sales_flat_order o ON a.parent_id=o.entity_id AND o.status in ('complete','paypal_reversed','picking','processing','verify_address','verify_payment')
        INNER JOIN mage_sd.sales_flat_order_item s ON o.entity_id=s.order_id
		INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
		INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=145
    
    WHERE address_type = 'shipping' 
		AND country_id='FR' 
		AND a.customer_id NOT IN (244025,244026,179443)
		AND s.created_at BETWEEN CAST('2016-09-01' AS DATE) AND CAST(NOW() AS DATE)
    
    GROUP BY s.sku, LEFT(postcode, 2), s.store_id
    ORDER BY LEFT(postcode, 2)