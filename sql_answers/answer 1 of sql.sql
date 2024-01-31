SELECT 
    dim_products.product_name,
    COUNT(fact_events.product_code) AS quantity_sold
FROM
    fact_events
        JOIN
    dim_products ON dim_products.product_code = fact_events.product_code
WHERE
    fact_events.base_price > 500
        AND fact_events.promo_type = 'BOGOF'
GROUP BY dim_products.product_name;
