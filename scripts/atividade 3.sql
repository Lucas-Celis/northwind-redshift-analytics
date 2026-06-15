SELECT P.product_name AS "PRODUTO",
       P.unit_price AS "PRECO"
FROM products P
ORDER BY P.unit_price DESC
LIMIT 10;