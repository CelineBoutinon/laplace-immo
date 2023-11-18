WITH moyenne AS (
SELECT region.reg_code AS 'Région', region.reg_nom AS 'NomRégion', AVG(mut_val/bien_carrez_1) AS 'AvgPpxM2Apparts4p'
FROM mutation
LEFT JOIN bien USING (bien_id)
LEFT JOIN commune USING (com_code)
LEFT JOIN departement USING (dep_code)
LEFT JOIN region USING (reg_code)
WHERE (mut_date >= '2020-01-01') AND (mut_date <= '2020-06-30') AND lower(bien_type) = 'appartement' AND lower(mut_type) = 'vente' AND bien_numpieces >'4'
GROUP BY region.reg_nom, region.reg_code)
SELECT Région, NomRégion AS 'Nom Région', CONCAT(FORMAT(AvgPpxM2Apparts4p,2), ' EUR/m2') AS 'Prix moyen appartements > 4 pièces' FROM moyenne
GROUP BY Région
ORDER BY AvgPpxM2Apparts4p  DESC;
