drop table orders cascade constraints;
drop table clients cascade constraints;
drop table order_items cascade constraints;
drop table products cascade constraints;
drop table product_versions cascade constraints;

drop trigger AFTER_DELETE_ORDER_ITEM;
drop trigger AFTER_INSERT_ORDER_ITEM;
drop trigger BEFORE_INSERT_ORDER;
drop trigger BEFORE_INSERT_ORDER_ITEM;
drop trigger BEFORE_INSERT_PRODUCT_VERSION;

drop view CLIENT_TRADE_BY_MONTH;
drop view CURRENT_PRICES;
drop view HIGHEST_GAIN_PRODUCTS;
commit;