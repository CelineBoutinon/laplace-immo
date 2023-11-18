SELECT 
    bien_type AS 'Type de bien',
    COUNT(bien_type) AS 'Nb de biens vendus',
    departement.reg_code AS 'Région',
    reg_nom AS 'Nom Région'
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
GROUP BY departement.reg_code , bien_type
ORDER BY COUNT(bien_type) DESC;
