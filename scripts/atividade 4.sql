WITH for2020 AS (
    SELECT S.supplier_id AS "ID",
           S.company_name AS "FORNECEDOR",
           ROUND(SUM(OD.unit_price * od.quantity), 2) AS "TOTAL 2020"
    FROM order_details OD
    INNER JOIN products P
    ON P.product_id = OD.product_id
    INNER JOIN suppliers S
    ON S.supplier_id = P.supplier_id
    INNER JOIN orders O
    on O.order_id = OD.order_id
    WHERE DATE_PART(year, O.order_date) = 2020
    GROUP BY ID, FORNECEDOR
),

for2021 AS (
    SELECT S.supplier_id AS "ID",
           S.company_name AS "FORNECEDOR",
           ROUND(SUM(OD.unit_price * OD.quantity), 2) AS "TOTAL 2021"
    FROM order_details OD
    INNER JOIN products P
    ON P.product_id = OD.product_id
    INNER JOIN suppliers S
    ON S.supplier_id = P.supplier_id
    INNER JOIN orders O
    ON O.order_id = OD.order_id
    WHERE DATE_PART(year, O.order_date) = 2021
    GROUP BY ID, FORNECEDOR
),

total AS (
    SELECT for2021.id, 
           for2020.fornecedor,
           "TOTAL 2020", 
           "TOTAL 2021",
           ROUND("TOTAL 2021" - "TOTAL 2020", 2) AS "RESULTADO"
    FROM for2020
    INNER JOIN for2021
    ON for2021.id = for2020.id
    ORDER BY RESULTADO DESC
)

SELECT * FROM total;