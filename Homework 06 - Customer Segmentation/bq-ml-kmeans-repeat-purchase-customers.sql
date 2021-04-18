CREATE OR REPLACE MODEL `tanat-project.supermarket.repeat_clusters`
OPTIONS(model_type='kmeans', num_clusters=6, kmeans_init_method='kmeans++', max_iterations=50)
AS (
    SELECT 
        avg_ticket_size , 
        avg_weekly_visit, avg_weekly_spend,
        days_since_last_purch, days_since_first_purch, avg_time_to_event,
    FROM `tanat-project.supermarket.customers`
    WHERE total_visit > 1
)