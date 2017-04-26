/*Récuperation du pourcentage d'article Avènes avec + de 4/5 en note*/
/*Récuperation du pourcentage d'article Avènes avec + de 0 commentaires*/
SELECT 
		CONCAT(ROUND(((SUM(rate > 4)/COUNT(rate)))*100,2),' %') AS perc_superior_to_4, 
		CONCAT(ROUND(((SUM(nb_reviews > 0)/COUNT(rate)))*100,2),' %') AS perc_prod_with_review 
        
FROM avisverifies_products_average 
INNER JOIN catalog_product_entity ON avisverifies_products_average.ref_product=catalog_product_entity.sku 
INNER JOIN catalog_product_entity_int i ON i.entity_id=catalog_product_entity.entity_id AND i.attribute_id=81 AND i.value=25;