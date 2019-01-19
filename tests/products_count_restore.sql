insert into clients values (3, 'first_name_3', 'last_name_3', '123456789', '1234', 'street_3', 'city_3', '12345')
/
insert into orders values(3, 3, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 33, 'restore PRODUCTS_COUNT', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 54321)
/
insert into order_items values(3, 1, 33, 6)
/
delete from order_items where product_id = 1 and version_id = 33 and order_id = 3
/
select * from product_versions where product_id = 1
    and version = 33
    and available = 54321;
/