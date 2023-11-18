SELECT 
    bien_type AS 'Type de bien',
    bien_numpieces AS 'Nb de pièces',
    CONCAT(FORMAT(COUNT(bien_type) * 100 / (SELECT 
                        COUNT(bien_type)
                    FROM
                        bien
                    WHERE
                        LOWER(bien_type) = 'appartement'),
                4),
            '%') AS '% du total des ventes'
FROM
    bien
        JOIN
    mutation ON bien.bien_id = mutation.bien_id
WHERE
    (mut_date >= '2020-01-01')
        AND (mut_date <= '2020-06-30')
        AND LOWER(bien_type) = 'appartement'
        AND LOWER(mut_type) = 'vente'
GROUP BY bien_type , bien_numpieces
ORDER BY bien_numpieces ASC;
