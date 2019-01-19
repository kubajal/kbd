insert into clients values (2, 'first_name_2', 'last_name_2', '123456789', '1234', 'street_2', 'city_2', '12345')
/
insert into orders values(2, 2, 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into order_items values(2, 1, 1, 2) -- 2 * 5,26   = 10,52
/
insert into order_items values(2, 2, 1, 3) -- 3 * 8,18   = 25,54
/
insert into order_items values(2, 3, 1, 4) -- 4 * 11,41  = 45,64
-- ---------------------------------------------------- + ------
--                                                          80,7
/
commit
/
select * from orders where order_id = 2 and order_value = 80.7;
/