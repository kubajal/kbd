insert into clients values (1, 'first_name_1', 'last_name_1', '123456789', '1234', 'street_1', 'city_1', '12345') -- (client_id, first_name, last_name, phone, house_number, street, city, zip)
/
insert into orders values(1, 1, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS')) -- (order_id, client_id, order_value, date_ordered)
/
insert into product_versions values(1, 11, 'test available', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 1111) -- (product_id, version, version_name, price, date_created, available)
/
insert into order_items values(2, 1, 11, 2) -- (order_id, product_id, version, products_count)
/
commit
/
select * from product_versions where product_id = 1
    and version = 11
    and available = 1109;
/
