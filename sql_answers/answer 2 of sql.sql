SELECT 
    city, COUNT(store_id) AS store_count
FROM
    retail_events_db.dim_stores
GROUP BY city
ORDER BY store_count DESC;