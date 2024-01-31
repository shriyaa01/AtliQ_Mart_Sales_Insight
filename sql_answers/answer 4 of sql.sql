WITH DiwaliEvents AS (
    SELECT 
        dim_products.category,
        SUM(fact_events.quantity_sold_before_promo) AS total_quantity_before_diwali,
        SUM(fact_events.quantity_sold_after_promo) AS total_quantity_after_diwali
    FROM 
        fact_events
    JOIN 
        dim_products ON dim_products.product_code = fact_events.product_code
    WHERE 
        fact_events.campaign_id = 'CAMP_DIW_01'
    GROUP BY 
        dim_products.category
)

SELECT 
    category,
    ((SUM(total_quantity_after_diwali) - SUM(total_quantity_before_diwali)) / SUM(total_quantity_before_diwali)) * 100 AS isu_percent,
    RANK() OVER (ORDER BY ((SUM(total_quantity_after_diwali) - SUM(total_quantity_before_diwali)) / SUM(total_quantity_before_diwali)) DESC) AS rank_order
FROM 
    DiwaliEvents
GROUP BY 
    category
ORDER BY 
    rank_order;

