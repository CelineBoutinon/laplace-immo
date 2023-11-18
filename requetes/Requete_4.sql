WITH Moy2Pieces AS (
SELECT AVG(mut_val/bien_carrez_1) AS Avg_px_m2_Apparts, commune.dep_code AS 'Département', ref_dep_nom AS 'NomDépartment' FROM commune 
LEFT JOIN bien USING (com_code)
LEFT JOIN mutation USING (bien_id)
LEFT JOIN departement USING (dep_code)
LEFT JOIN ref_dep ON (departement.dep_code = ref_dep_code)
WHERE (mut_date >= '2020-01-01') AND (mut_date <= '2020-06-30') AND lower(mut_type) = 'vente'
GROUP BY  commune.dep_code
)
SELECT Département, NomDépartment, CONCAT(FORMAT(Avg_px_m2_Apparts,2), ' EUR') AS 'Prix moyen au m2' FROM commune
JOIN Moy2Pieces
GROUP BY Département
ORDER BY Avg_px_m2_Apparts DESC
LIMIT 10
;


