drop table orders cascade constraints;
drop table clients cascade constraints;
drop table order_items cascade constraints;
drop table products cascade constraints;
drop table product_versions cascade constraints;

drop trigger order_added;
drop trigger order_item_added;
drop trigger order_item_deleted;
commit;