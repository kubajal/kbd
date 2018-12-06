insert into orders values(4, 6974, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 125, 'restore PRODUCTS_COUNT', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 54321)
/
insert into order_items values(4, 1, 125, 6)
/
delete from order_items where product_id = 1 and version_id = 125 and order_id = 4
/
select * from product_versions where product_id = 1
    and version_id = 125
    and available = 54321;
/