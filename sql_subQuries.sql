-- Question 1:
--Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT t3.sales_reps, t2.region, t2.max_sales
FROM
	(SELECT t1.region, MAX(t1.total_sales) AS max_sales
	FROM
		(SELECT s.name AS sales_reps,
				r.name AS region,
				SUM(o.total_amt_usd) AS total_sales
		FROM region AS r
		JOIN sales_reps AS s
			ON s.region_id = r.id
		JOIN accounts AS a
			ON a.sales_rep_id = s.id
		JOIN orders AS o
			ON o.account_id = a.id
		GROUP BY 1,2) t1
	GROUP BY 1) t2
JOIN
		(SELECT s.name AS sales_reps,
				r.name AS region,
				SUM(o.total_amt_usd) AS total_sales
		FROM region AS r
		JOIN sales_reps AS s
			ON s.region_id = r.id
		JOIN accounts AS a
			ON a.sales_rep_id = s.id
		JOIN orders AS o
			ON o.account_id = a.id
		GROUP BY 1,2) t3
ON t3.region = t2.region AND t3.total_sales = t2.max_sales
ORDER BY max_sales DESC
