SELECT 
    p.product_name,
    p.category,
    SUM(f.quantity_sold) AS units_sold,
    SUM(f.total_amount) AS revenue,
    (SUM(f.total_amount) / (SELECT SUM(total_amount) FROM fact_sales) * 100) AS revenue_percentage
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_key
ORDER BY revenue DESC
LIMIT 10;

WITH CustomerSpend AS (
    SELECT customer_key, SUM(total_amount) as total_spent
    FROM fact_sales
    GROUP BY customer_key
)
SELECT 
    CASE 
        WHEN total_spent > 50000 THEN 'High Value'
        WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    SUM(total_spent) AS total_revenue,
    AVG(total_spent) AS avg_revenue
FROM CustomerSpend
GROUP BY 1;
