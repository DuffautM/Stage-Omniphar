/*Get the number of product from a brand send in each region
Can chose the date, the country*/

/*To get the full postal code (31000) instead of (31), delete 

	LEFT(postcode, 2) AS post

And replace

	post

By

	postcode

*/

SELECT post AS Code_Postal, COUNT(pro) AS Number_Product

	FROM
	(

		SELECT post, ord, pro

		FROM sales_flat_order o

		INNER JOIN
		(
					
			SELECT LEFT(postcode, 2) AS post, ord, pro
			
				FROM sales_flat_order_address a
				
				INNER JOIN
				(
					
					SELECT ord, pro
						
						FROM 
						(
							
							SELECT 
							s.order_id AS ord, sku AS pro

								FROM mage_sd.sales_flat_order_item s

								INNER JOIN
								(
									
									SELECT DISTINCT order_id 
									
										FROM mage_sd.sales_flat_order_item s
										INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
										INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=145
								
								) t ON t.order_id=s.order_id
								
								WHERE created_at BETWEEN CAST('2010-01-01' AS DATE) AND CAST('2017-04-27' AS DATE) AND sku IN
								(
									
									SELECT s.sku
								
										FROM mage_sd.sales_flat_order_item s
										INNER JOIN mage_sd.catalog_product_entity e ON s.sku = e.sku
										INNER JOIN mage_sd.catalog_product_entity_int i ON i.entity_id=e.entity_id AND i.attribute_id=81 AND i.value=145
								)
							
						) as dd
						
				)z ON z.ord = a.parent_id
					
				WHERE address_type = 'shipping' AND country_id='FR'
			) m ON m.ord=o.entity_id AND o.status in ('complete','paypal_reversed','picking','processing','verify_address','verify_payment') AND o.customer_id not in (244025,244026,179443) 

	) AS ds
			
    GROUP BY post

#o.status in ('complete','paypal_reversed','picking','processing','verify_address','verify_payment') AND o.customer_id not in (244025,244026,179443) 