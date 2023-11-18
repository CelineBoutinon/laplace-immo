SELECT 
    bien_id AS 'Référence du bien',
    reg_code AS 'Région',
    reg_nom AS 'Nom Région',
    CONCAT(bien_carrez_1, ' m2') AS 'Surface Carrez',
    CONCAT(FORMAT(mut_val, 2), ' EUR') AS Prix
FROM
    mutation
        LEFT JOIN
    bien USING (bien_id)
        LEFT JOIN
    commune USING (com_code)
        LEFT JOIN
    departement USING (dep_code)
        LEFT JOIN
    region USING (reg_code)
WHERE
    (mut_date >= '2020-01-01')
        AND (mut_date <= '2020-06-30')
        AND LOWER(bien_type) = 'appartement'
        AND LOWER(mut_type) = 'vente'
ORDER BY mut_val DESC
LIMIT 10
;
