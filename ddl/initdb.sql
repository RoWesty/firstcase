CREATE TABLE IF NOT EXISTS public.products(
    product_id serial PRIMARY KEY,
    product_name varchar(180),
    price money
);

CREATE TABLE IF NOT EXISTS public.shop_mvideo(
    "date" date,
    product_id int,
    sales_cnt money,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS public.shop_dns(
    "date" date,
    product_id int,
    sales_cnt money,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS public.shop_sitilink(
    "date" date,
    product_id int,
    sales_cnt money,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS public.shop_name(
    id_shop serial PRIMARY KEY,
    shop_name varchar(180)
);

CREATE TABLE IF NOT EXISTS public.plan(
    product_id int,
    id_shop int,
    plan_cnt money,
    plan_date date,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE SET NULL,
    FOREIGN KEY (id_shop) REFERENCES shop_name (id_shop) ON DELETE SET NULL
);