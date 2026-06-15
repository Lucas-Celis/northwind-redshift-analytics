WITH ranking_vendas AS (
    SELECT C.category_name AS "Categoria",
           DATE_PART('year', O.order_date) AS "ANO",
           ROUND(SUM(OD.unit_price * OD.quantity), 2) AS "VENDAS",
           -- O segredo está em ordenar por SUM(...) DESC dentro do OVER:
           ROW_NUMBER() OVER (
               PARTITION BY DATE_PART('year', O.order_date) 
               ORDER BY SUM(OD.unit_price * OD.quantity) DESC
           ) AS "RANKING"
    FROM categories C
    INNER JOIN products P ON P.category_id = C.category_id
    INNER JOIN order_details OD ON OD.product_id = P.product_id
    INNER JOIN orders O ON O.order_id = OD.order_id
    GROUP BY C.category_name, DATE_PART('year', O.order_date)
)
SELECT "Categoria", "ANO", "VENDAS"
FROM ranking_vendas
WHERE "RANKING" <= 5
ORDER BY "ANO" ASC, "VENDAS" DESC;