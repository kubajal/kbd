insert into orders values(5, 6974, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 126, 'restore PRODUCTS_COUNT', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 54321)
/
insert into order_items values(5, 1, 126, 6)
/
delete from order_items where product_id = 1 and version_id = 126 and order_id = 5
/
select * from product_versions where product_id = 1
    and version = 126
    and available = 54321;
/