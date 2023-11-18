WITH OrdreCommunesParDept AS(
SELECT dep_code AS 'Département', com_nom AS Commune,  CONCAT(FORMAT(AVG(mut_val),2), ' EUR') AS 'Valeur foncière moyenne',
RANK() OVER(PARTITION BY dep_code ORDER BY AVG(mut_val) DESC) AS 'Classement'
FROM bien
LEFT JOIN mutation USING (bien_id)
LEFT JOIN commune USING (com_code)
LEFT JOIN departement USING (dep_code)
GROUP BY com_code
)
SELECT * FROM OrdreCommunesParDept
WHERE ((Classement <=3) AND (Département = '06')) OR ((Classement <=3) AND (Département = '13')) OR ((Classement <=3) AND (Département = '33')) OR ((Classement <=3) AND (Département = '59')) OR ((Classement <=3) AND (Département = '69'))
;