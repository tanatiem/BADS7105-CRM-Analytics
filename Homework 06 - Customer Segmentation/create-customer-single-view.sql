CREATE TABLE `tanat-project.supermarket.customers` AS
SELECT
    cust.cust_code,
    total_visit, total_spend,
    avg_ticket_size, std_ticket_size,
    dur_since_last_purch, dur_since_first_purch, 
    length_of_stay, avg_time_to_event,
    avg_weekly_visit, std_weekly_visit, 
    avg_weekly_spend, std_weekly_spend,
    avg_monthly_visit, std_monthly_visit,
    avg_monthly_spend, std_monthly_spend,
    prop_visit_weekday, prop_visit_weekend,
    avg_ticket_size_weekday, avg_ticket_size_weekend,
    prop_visit_morning, prop_visit_afternoon, prop_visit_evening,
    avg_ticket_size_morning, avg_ticket_size_afternoon, avg_ticket_size_evening,
    prop_visit_basket_fresh, prop_visit_basket_grocery, prop_visit_basket_nonfood, prop_visit_basket_mixed,
    avg_ticket_size_basket_fresh, avg_ticket_size_basket_grocery, avg_ticket_size_basket_nonfood, avg_ticket_size_basket_mixed
FROM (
    SELECT cust_code,
        COUNT(DISTINCT basket_id) AS total_visit,
        SUM(spend) AS total_spend,
        AVG(spend) AS avg_ticket_size, 
        STDDEV_POP(spend) AS std_ticket_size,
        MIN(age) AS dur_since_last_purch,
        MAX(age) AS dur_since_first_purch,
        MAX(age) - MIN(age) AS length_of_stay,
        (MAX(age) - MIN(age)) / COUNT(DISTINCT basket_id) AS avg_time_to_event,

        # weekday/end - visit proportion
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN NOT is_weekend THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_weekday,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN is_weekend THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_weekend,
        # weekday/weekend - ticket size
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN NOT is_weekend THEN spend ELSE 0 END),SUM(CASE WHEN NOT is_weekend THEN 1 ELSE 0 END)),0) AS avg_ticket_size_weekday,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN is_weekend THEN spend ELSE 0 END),SUM(CASE WHEN is_weekend THEN 1 ELSE 0 END)),0) AS avg_ticket_size_weekend,
        
        # time of day - visit proportion
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN shop_daytime = 'morning' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_morning,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN shop_daytime = 'afternoon' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_afternoon,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN shop_daytime = 'evening' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_evening,
        # time of day - ticket_size
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN shop_daytime = 'morning' THEN spend ELSE 0 END),SUM(CASE WHEN shop_daytime = 'morning' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_morning,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN shop_daytime = 'afternoon' THEN spend ELSE 0 END),SUM(CASE WHEN shop_daytime = 'afternoon' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_afternoon,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN shop_daytime = 'evening' THEN spend ELSE 0 END),SUM(CASE WHEN shop_daytime = 'evening' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_evening,

        # basket dominant mission - visit proportion
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Fresh' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_basket_fresh,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Grocery' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_basket_grocery,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Nonfood' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_basket_nonfood,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Mixed' THEN 1 ELSE 0 END),COUNT(DISTINCT basket_id)),0) AS prop_visit_basket_mixed,
        # basket dominant mission - ticket_size
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Fresh' THEN spend ELSE 0 END),SUM(CASE WHEN basket_dominant_mission = 'Fresh' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_basket_fresh,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Grocery' THEN spend ELSE 0 END),SUM(CASE WHEN basket_dominant_mission = 'Grocery' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_basket_grocery,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Nonfood' THEN spend ELSE 0 END),SUM(CASE WHEN basket_dominant_mission = 'Nonfood' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_basket_nonfood,
        COALESCE(SAFE_DIVIDE(SUM(CASE WHEN basket_dominant_mission = 'Mixed' THEN spend ELSE 0 END),SUM(CASE WHEN basket_dominant_mission = 'Mixed' THEN 1 ELSE 0 END)),0) AS avg_ticket_size_basket_mixed
    FROM `tanat-project.supermarket.baskets` 
    GROUP BY cust_code
) cust
inner join (
    select cust_code, 
        avg(weekly_visit) avg_weekly_visit, stddev_pop(weekly_visit) std_weekly_visit,
        avg(weekly_spend) avg_weekly_spend, stddev_pop(weekly_spend) std_weekly_spend
    from (
        SELECT cust_code, shop_week, count(*) weekly_visit,sum(spend) weekly_spend
        FROM `tanat-project.supermarket.baskets`
        GROUP BY cust_code, shop_week
    ) group by cust_code
) week ON cust.cust_code = week.cust_code
inner join (
    select cust_code, 
        avg(monthly_visit) avg_monthly_visit, stddev_pop(monthly_visit) std_monthly_visit,
        avg(monthly_spend) avg_monthly_spend, stddev_pop(monthly_spend) std_monthly_spend
    from (
        SELECT cust_code, shop_month, count(*) monthly_visit,sum(spend) monthly_spend
        FROM `tanat-project.supermarket.baskets`
        GROUP BY cust_code, shop_month
    ) group by cust_code
) month ON cust.cust_code = month.cust_code;
