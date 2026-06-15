SELECT E.first_name + ' ' + E.last_name AS "EMPREGADO",
       ROUND(SUM((OD.unit_price * OD.quantity) - OD.discount), 2) AS "TOTAL"
FROM order_details OD
INNER JOIN orders O
ON O.order_id = OD.order_id
INNER JOIN employees E
ON e.employee_id = O.employee_id
WHERE DATE_PART(year, O.order_date) = 2022
GROUP BY EMPREGADO
ORDER BY TOTAL DESC;