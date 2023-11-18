WITH Trim1 AS(
SELECT count(mut_type) AS Ventes20Q1 FROM mutation WHERE (mut_date >= '2020-01-01') AND (mut_date <= '2020-03-31') AND lower(mut_type) = 'vente'
GROUP BY mut_type),
Trim2 AS(
SELECT count(mut_type) AS Ventes20Q2 FROM mutation WHERE (mut_date >= '2020-04-01') AND (mut_date <= '2020-06-30') AND lower(mut_type) = 'vente'
GROUP BY mut_type)
SELECT FORMAT(count(mut_type),0) AS 'Nb de ventes total 20S1', FORMAT(Ventes20Q1,0) AS 'Ventes 20Q1', FORMAT(Ventes20Q2,0) AS 'Ventes 20Q2', CONCAT(FORMAT((Ventes20Q2- Ventes20Q1)*100/Ventes20Q2,2),'%') AS 'Evo Q2 / Q1'
FROM mutation
JOIN Trim1
JOIN Trim2
GROUP BY Ventes20Q1, Ventes20Q2;