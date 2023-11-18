SELECT 
    bien_type AS 'Type de bien',
    CONCAT(FORMAT(AVG(mut_val / bien_carrez_1), 2),
            ' EUR/m2') AS 'Valeur foncière moyenne',
    region.reg_code AS 'Région',
    reg_nom AS 'Nom Région'
FROM
    mutation
        LEFT JOIN
    bien ON bien.bien_id = mutation.bien_id
        LEFT JOIN
    commune ON bien.com_code = commune.com_code
        LEFT JOIN
    departement ON commune.dep_code = departement.dep_code
        LEFT JOIN
    region ON departement.reg_code = region.reg_code
WHERE
    (mut_date >= '2020-01-01')
        AND (mut_date <= '2020-06-30')
        AND LOWER(bien_type) = 'maison'
        AND LOWER(mut_type) = 'vente'
        AND region.reg_code = '11'
GROUP BY region.reg_code , bien_type;
