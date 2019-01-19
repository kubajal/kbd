insert into clients values (4, 'first_name_4', 'last_name_4', '123456789', '1234', 'street_4', 'city_4', '12345')
/
insert into orders values(4, 4, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 44, 'restore PRODUCTS_COUNT', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 54321)
/
insert into order_items values(4, 1, 44, 6)
/
delete from order_items where product_id = 1 and version = 44 and order_id = 4
/
select * from product_versions where product_id = 1
    and version = 44
    and available = 54321;
/