 WITH sl_fact AS (SELECT sd.sales_cnt FROM shop_dns AS sd, (SELECT DATE_PART('month', CURRENT_DATE) AS curmonth, DATE_PART('YEAR', CURRENT_DATE) AS curyear, DATE_PART('month', pl.plan_date) as mont, DATE_PART('YEAR', pl.plan_date) as yea 
                 FROM plan as pl) as two WHERE yea = curyear AND mont = curmonth group by sd.sales_cnt),
                (SELECT SUM(sm1) AS sales_fact 
                 FROM
                (SELECT SUM(sales_cnt) AS sm1
                 FROM (SELECT sd.sales_cnt FROM shop_dns AS sd, (SELECT DATE_PART('month', CURRENT_DATE) AS curmonth, DATE_PART('YEAR', CURRENT_DATE) AS curyear, DATE_PART('month', pl.plan_date) as mont, DATE_PART('YEAR', pl.plan_date) as yea 
                 FROM plan as pl) as two WHERE yea = curyear AND mont = curmonth group by sd.sales_cnt) AS one
                 UNION ALL
                 SELECT SUM(sales_cnt)
                 FROM (SELECT sm.sales_cnt FROM shop_mvideo AS sm, (SELECT DATE_PART('month', CURRENT_DATE) AS curmonth, DATE_PART('YEAR', CURRENT_DATE) AS curyear, DATE_PART('month', pl.plan_date) as mont, DATE_PART('YEAR', pl.plan_date) as yea 
                 FROM plan as pl) as fre WHERE yea = curyear AND mont = curmonth group by sm.sales_cnt) AS four
                 UNION ALL
                 SELECT SUM(sales_cnt)
                 FROM (SELECT ss.sales_cnt FROM shop_sitilink AS ss, (SELECT DATE_PART('month', CURRENT_DATE) AS curmonth, DATE_PART('YEAR', CURRENT_DATE) AS curyear, DATE_PART('month', pl.plan_date) as mont, DATE_PART('YEAR', pl.plan_date) as yea 
                 FROM plan as pl) as five WHERE yea = curyear AND mont = curmonth group by ss.sales_cnt ) AS six) AS sumall),
    sl_plan AS (SELECT SUM(pl.plan_cnt) AS sales_plan 
                 FROM plan pl
                 group by pl.plan_date),
   sl_ratio AS (SELECT sales_fact/sales_plan AS sales_ratio
                 FROM sl_fact, sl_plan),
     income AS (SELECT income_fact/income_plan AS income_ratio, income_fact, income_plan, product_name
                 FROM 
               (SELECT pr.price * sales_fact AS income_fact, pr.price * sales_plan  AS income_plan, pr.product_name 
                 FROM products pr, sl_plan, sl_fact) AS incomeall),
   nameshop AS (SELECT shop_name
                 FROM shop_name sn )
SELECT shop_name, product_name, sales_fact, sales_plan, sales_ratio, income_fact, income_plan, income_ratio
FROM sl_fact, sl_plan, sl_ratio, income, nameshop, plan pl
GROUP BY sales_fact, sales_plan, sales_ratio, income_fact, income_plan, income_ratio, product_name, shop_name
ORDER BY shop_name