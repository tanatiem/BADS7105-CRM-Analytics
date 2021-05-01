-- Option 1 - SQL
WITH cust_month AS (
    select distinct cust_code, date_trunc(shop_date, month) shop_month
    from `tanat-project.supermarket.transactions`
    where cust_code is not null
)
SELECT report_month
    ,COUNT(DISTINCT CASE WHEN status = 'New' THEN cust_code ELSE NULL END) AS new_customers
    ,COUNT(DISTINCT CASE WHEN status = 'Repeat' THEN cust_code ELSE NULL END) AS repeat_customers
    ,COUNT(DISTINCT CASE WHEN status = 'Reactivated' THEN cust_code ELSE NULL END) AS reactivated_customers
    ,-COUNT(DISTINCT CASE WHEN status = 'Churn' THEN cust_code ELSE NULL END) AS churn_customers
FROM (
    SELECT cust_code, shop_month AS report_month, prev_month
        ,CASE 
            WHEN DATE_DIFF(shop_month, prev_month, MONTH) IS NULL THEN 'New'
            WHEN DATE_DIFF(shop_month, prev_month, MONTH) = 1 THEN 'Repeat'
            WHEN DATE_DIFF(shop_month, prev_month, MONTH) > 1 THEN 'Reactivated'
        ELSE NULL END AS status
    FROM (
        SELECT cust_code, shop_month, LAG(shop_month, 1) OVER (PARTITION BY cust_code ORDER BY shop_month) AS prev_month
        FROM cust_month
    )
    UNION ALL
    SELECT cust_code, DATE_ADD(shop_month, INTERVAL 1 MONTH) report_month, shop_month as prev_month
        ,'Churn' AS status
    FROM (
        SELECT cust_code, shop_month
            ,LEAD(shop_month, 1) OVER (PARTITION BY cust_code ORDER BY shop_month) AS next_trans_date
            ,DATE_DIFF(LEAD(shop_month, 1) OVER (PARTITION BY cust_code ORDER BY shop_month), shop_month, MONTH) AS n_months
        FROM cust_month
    ) WHERE 
        (n_months > 1 or n_months is null)
        AND shop_month < (SELECT MAX(shop_month) FROM cust_month)-- excluding last month
) GROUP BY report_month
order by report_month
;
