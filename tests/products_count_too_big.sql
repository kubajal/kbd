insert into clients values (3, 'first_name_3', 'last_name_3', '123456789', '1234', 'street_3', 'city_3', '12345') -- (client_id, first_name, last_name, phone, house_number, street, city, zip)
/
insert into orders values(3, 3, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into product_versions values(1, 125, 'test too much PRODUCTS_COUNT', 1.11, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'), 10)
/
insert into order_items values(3, 1, 125, 20)
/