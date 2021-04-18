CREATE OR REPLACE MODEL `tanat-project.supermarket.onetime_clusters`
OPTIONS(model_type='kmeans', num_clusters=4, 
        kmeans_init_method='kmeans++', max_iterations=50)
AS (
    SELECT 
        total_spend, days_since_last_purch
    FROM `tanat-project.supermarket.customers`
    WHERE total_visit = 1
);