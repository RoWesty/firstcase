INSERT INTO products(product_name, price)
VALUES
('Испорченный телефон', 700),
('Сарафанное радио', 1800),
('Патефон', 250);

INSERT INTO shop_mvideo("date", product_id, sales_cnt)
VALUES
('2023-06-01', 2, 1),
('2023-06-02', 2, 3),
('2023-06-02', 1, 8),
('2023-06-09', 3, 1),
('2023-06-07', 2, 7),
('2023-06-21', 2, 3),
('2023-06-17', 3, 3);

INSERT INTO shop_dns("date", product_id, sales_cnt)
VALUES
('2023-06-07', 3, 1),
('2023-06-13', 3, 3),
('2023-06-02', 1, 8),
('2023-06-26', 2, 1),
('2023-06-21', 1, 7),
('2023-06-22', 1, 3),
('2023-06-15', 3, 3);

INSERT INTO shop_sitilink("date", product_id, sales_cnt)
VALUES
('2023-06-01', 1, 1),
('2023-06-02', 2, 3),
('2023-06-03', 2, 8),
('2023-06-04', 3, 1),
('2023-06-05', 3, 7),
('2023-06-06', 2, 3),
('2023-06-07', 1, 3);

INSERT INTO shop_name(shop_name)
VALUES
('dns'),
('sitilink'),
('mvideo');

INSERT INTO plan(product_id,id_shop, plan_cnt, plan_date)
VALUES
(1, 1, 15, '2023-06-30'),
(2, 1, 20, '2023-06-30'),
(3, 1, 10, '2023-06-30'),
(1, 2, 25, '2023-06-30'),
(2, 2, 10, '2023-06-30'),
(3, 2, 10, '2023-06-30'),
(1, 3, 35, '2023-06-30'),
(2, 3, 30, '2023-06-30'),
(3, 3, 29, '2023-06-30');
