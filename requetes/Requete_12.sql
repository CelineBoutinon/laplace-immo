SELECT 
    com_nom AS Commune,
    (COUNT(bien_id) / com_poptot * 1000) AS 'Ventes pour 1,000 habitants',
    CONCAT(FORMAT(com_poptot, 0), ' habitants') AS 'Population totale'
FROM
    bien
        LEFT JOIN
    commune USING (com_code)
        LEFT JOIN
    mutation USING (bien_id)
WHERE
    LOWER(mut_type) = 'vente'
        AND com_poptot > 10000
        AND (mut_date >= '2020-01-01')
        AND (mut_date <= '2020-06-30')
GROUP BY com_code
ORDER BY (COUNT(bien_id) / com_poptot * 1000) DESC
LIMIT 20;
