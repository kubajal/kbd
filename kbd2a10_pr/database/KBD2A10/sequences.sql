set echo on;
CREATE SEQUENCE ORDER_ID_SEQ  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE CLIENT_ID_SEQ  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE PRODUCT_ID_SEQ  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1000;
commit;
set echo off;