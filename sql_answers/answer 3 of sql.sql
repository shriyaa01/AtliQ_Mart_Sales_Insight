SELECT 
    dim_campaigns.campaign_name,
    SUM(fact_events.base_price * fact_events.quantity_sold_before_promo) AS total_revenue_before_promo,
    SUM(base_price * fact_events.quantity_sold_after_promo) AS total_revenue_after_promo
FROM
    fact_events
        JOIN
    dim_campaigns ON dim_campaigns.campaign_id = fact_events.campaign_id
GROUP BY fact_events.campaign_id;
