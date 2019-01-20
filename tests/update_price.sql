insert into clients values (5, 'first_name_5', 'last_name_5', '123456789', '1234', 'street_5', 'city_5', '12345') -- (client_id, first_name, last_name, phone, house_number, street, city, zip)
/
insert into orders values(5, 5, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 55, 'test PRODUCT_VERSIONS.price update', 2, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 10)
/
insert into order_items values(5, 1, 55, 5) -- 5 * 2.00 = 10.00
/
update order_items set price = 1.11 where product_id = 1 and version = 55;
/
select * from orders where order_id = 5;
/