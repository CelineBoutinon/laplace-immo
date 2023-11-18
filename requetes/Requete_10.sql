WITH Moy2pieces AS
(SELECT AVG(mut_val/bien_carrez_1) AS Apparts2Pieces
FROM mutation
JOIN bien USING (bien_id)
WHERE (mut_date >= '2020-01-01') AND (mut_date <= '2020-06-30') AND lower(bien_type) = 'appartement' AND lower(mut_type) = 'vente' AND bien_numpieces ='2'
),
Moy3pieces AS (SELECT AVG(mut_val/bien_carrez_1) AS Apparts3Pieces
FROM mutation
JOIN bien USING (bien_id)
WHERE (mut_date >= '2020-01-01') AND (mut_date <= '2020-06-30') AND lower(bien_type) = 'appartement' AND lower(mut_type) = 'vente' AND bien_numpieces ='3'
)
SELECT CONCAT(FORMAT(Apparts2Pieces,2), ' EUR/m2') AS 'Prix moyen appartements 2 pièces', CONCAT(FORMAT(Apparts3Pieces,2), ' EUR/m2') AS 'Prix moyen appartements 3 pièces', CONCAT(FORMAT((Apparts3Pieces-Apparts2Pieces)*100/Apparts2Pieces,2), '%') AS 'Ecart' FROM Moy2pieces
JOIN Moy3pieces
GROUP BY Apparts2Pieces,Apparts3Pieces
;
