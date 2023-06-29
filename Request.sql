 WITH sl_fact AS(SELECT SUM(sm1) AS sales_fact 
                 FROM
                (SELECT SUM(sales_cnt) AS sm1
                 FROM shop_dns sd
                 WHERE DATE_PART('month', sd."date") = ALL(SELECT DATE_PART('month', CURRENT_DATE) FROM plan pl WHERE DATE_PART('month',pl.plan_date) = DATE_PART('month', CURRENT_DATE)) AND DATE_PART('year', sd."date") = ALL(SELECT DATE_PART('year', CURRENT_DATE) FROM plan pl WHERE DATE_PART('year',pl.plan_date) = DATE_PART('year', CURRENT_DATE))
                 UNION ALL
                 SELECT SUM(sales_cnt)
                 FROM shop_mvideo sm
                 WHERE DATE_PART('month', sm."date") = ALL(SELECT DATE_PART('month', CURRENT_DATE) FROM plan pl WHERE DATE_PART('month',pl.plan_date) = DATE_PART('month', CURRENT_DATE)) AND DATE_PART('year', sm."date") = ALL(SELECT DATE_PART('year', CURRENT_DATE) FROM plan pl WHERE DATE_PART('year',pl.plan_date) = DATE_PART('year', CURRENT_DATE))
                 UNION ALL
                 SELECT SUM(sales_cnt)
                 FROM shop_sitilink ss
                 WHERE DATE_PART('month', ss."date") = ALL(SELECT DATE_PART('month', CURRENT_DATE) FROM plan pl WHERE DATE_PART('month',pl.plan_date) = DATE_PART('month', CURRENT_DATE)) AND DATE_PART('year', ss."date") = ALL(SELECT DATE_PART('year', CURRENT_DATE) FROM plan pl WHERE DATE_PART('year',pl.plan_date) = DATE_PART('year', CURRENT_DATE))) AS sum_fact),
    sl_plan AS (SELECT SUM(pl.plan_cnt) AS sales_plan
                 FROM plan pl
                 GROUP BY pl.plan_date),
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