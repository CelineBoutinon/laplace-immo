SELECT 
    IF(COUNT(mut_type) >= '50',
        com_code,
        ' ') AS 'Commune',
    IF(COUNT(mut_type) >= '50',
        com_nom,
        ' ') AS 'Nom commune',
    IF(COUNT(mut_type) >= '50',
        COUNT(mut_type),
        ' ') AS 'Nb de ventes',
    IF(COUNT(mut_type) >= '50',
        CONCAT(' Du ',
                MIN(mut_date),
                ' au ',
                MAX(mut_date)),
        ' ') AS 'Période'
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
        AND (mut_date <= '2020-03-31')
        AND LOWER(mut_type) = 'vente'
GROUP BY com_code
ORDER BY COUNT(mut_type) DESC
;
