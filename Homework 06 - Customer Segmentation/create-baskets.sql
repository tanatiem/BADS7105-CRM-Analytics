CREATE OR REPLACE TABLE supermarket.baskets AS
SELECT
    cust_code, basket_id, spend, shop_date, 
    date_diff(DATE'2008-07-06', shop_date, DAY) as age,
    extract(year from shop_date)*100 + extract(month from shop_date) as shop_month,
    shop_week, shop_weekday,
    (case when shop_weekday in (1,7) then TRUE else FALSE end) as is_weekend,
    shop_hour,
    (case 
        when shop_hour <= 11 then 'morning'
        when shop_hour between 12 and 16 then 'afternoon'
        else 'evening' end
    ) as shop_daytime,
    basket_type, basket_dominant_mission
FROM (
    select cust_code, basket_id, 
        shop_date, shop_week, shop_weekday, shop_hour, basket_type, basket_dominant_mission,
        round(sum(spend),2) as spend
    from `tanat-project.supermarket.transactions`
    where cust_code is not null
    group by cust_code, basket_id, shop_date, shop_week, 
        shop_weekday, shop_hour, basket_type, basket_dominant_mission
);