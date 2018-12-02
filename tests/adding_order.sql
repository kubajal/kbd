insert into orders values(1, '6974', 0, to_date('2018-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'))
/
insert into order_items values(1, 1, 1, 2) -- 2 * 15,3   = 30,6
/
insert into order_items values(1, 2, 1, 3) -- 3 * 9,93   = 29,79
/
insert into order_items values(1, 3, 1, 4) -- 4 * 16,91  = 67,64 
/
commit
/
-- ----------------------------------------  + ----------------
--                                                          128,03
select * from orders where order_id = 1 and order_value = 128.03;
/
