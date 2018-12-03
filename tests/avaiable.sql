insert into orders values(2, 6974, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 123, 'test available', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 1111)
/
insert into order_items values(2, 1, 123, 2)
/
commit
/
select * from product_versions where
    product_id = 1 
    and version_id = 123
    and available = 1109;
/
