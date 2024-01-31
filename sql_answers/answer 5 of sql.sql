WITH IncrementalRevenue AS (
    SELECT
        ft.product_code,
        dp.product_name,
        dp.category,
        ((ft.quantity_sold_after_promo - ft.quantity_sold_before_promo) * ft.base_price) AS incremental_revenue,
        ft.base_price,
        ft.quantity_sold_after_promo,
        ft.quantity_sold_before_promo
    FROM
        fact_events ft
    JOIN
        dim_products dp ON ft.product_code = dp.product_code
)
SELECT
    product_name,
    category,
    (SUM(incremental_revenue) / SUM(base_price * quantity_sold_before_promo)) * 100 AS incremental_revenue_percentage
FROM
    IncrementalRevenue
GROUP BY
    product_name, category
ORDER BY
    incremental_revenue_percentage DESC
LIMIT 5;
