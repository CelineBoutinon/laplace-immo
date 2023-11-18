SELECT 
    bien_type AS 'Type de bien',
    FORMAT(COUNT(bien_type), 0) AS 'Nb de biens vendus',
    CONCAT(' Du ',
            MIN(mut_date),
            ' au ',
            MAX(mut_date)) AS 'Période'
FROM
    bien
        JOIN
    mutation ON bien.bien_id = mutation.bien_id
WHERE
    (mut_date >= '2020-01-02')
        AND (mut_date <= '2020-06-30')
        AND LOWER(bien_type) = 'appartement'
        AND LOWER(mut_type) = 'vente'
GROUP BY bien_type;
