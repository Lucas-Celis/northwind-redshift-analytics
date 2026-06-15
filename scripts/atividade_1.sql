SELECT OD.order_id AS "ID DO PEDIDO",
       P.product_name AS "PRODUTO",
       P.unit_price AS "VALOR Tabela", 
       OD.unit_price AS "VALOR VENDA", 
       OD.quantity AS "QUANTIDADE",
       ROUND(P.unit_price - OD.unit_price, 2) AS "DIFERENCA",
       OD.discount AS "DESCONTO"
FROM products P
INNER JOIN order_details OD 
ON P.product_id = OD.product_id
WHERE OD.unit_price < P.unit_price
ORDER BY "DIFERENCA" DESC;
