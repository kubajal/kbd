SET SQLBLANKLINES ON
CREATE TABLE CLIENTS 
(
  CLIENT_ID NUMBER(6, 0) NOT NULL 
, FIRST_NAME VARCHAR2(50) NOT NULL 
, LAST_NAME VARCHAR2(50) NOT NULL 
, PHONE VARCHAR2(9 CHAR) 
, HOUSE_NUMBER NUMBER(4, 0) NOT NULL 
, STREET VARCHAR2(30) NOT NULL 
, CITY VARCHAR2(30) NOT NULL 
, ZIP CHAR(5 CHAR) NOT NULL 
, CONSTRAINT CLIENTS_PK PRIMARY KEY 
  (
    CLIENT_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX CLIENTS_PK_I ON CLIENTS (CLIENT_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE PRODUCTS 
(
  PRODUCT_ID NUMBER(5, 0) NOT NULL 
, NAME VARCHAR2(50) NOT NULL 
, CONSTRAINT PRODUCTS_PK PRIMARY KEY 
  (
    PRODUCT_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX PRODUCTS_PK_I ON PRODUCTS (PRODUCT_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE ORDERS 
(
  ORDER_ID NUMBER(6, 0) NOT NULL 
, CLIENT_ID NUMBER(6, 0) NOT NULL 
, ORDER_VALUE NUMBER(6, 2) 
, DATE_ORDERED DATE NOT NULL 
, CONSTRAINT ORDERS_PK PRIMARY KEY 
  (
    ORDER_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ORDERS_PK_I ON ORDERS (ORDER_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE PRODUCT_VERSIONS 
(
  PRODUCT_ID NUMBER(5, 0) NOT NULL 
, VERSION NUMBER(3, 0) NOT NULL 
, VERSION_NAME VARCHAR2(50) 
, PRICE NUMBER(5, 2) NOT NULL 
, DATE_CREATED DATE 
, AVAILABLE NUMBER(5, 0) 
, CONSTRAINT PRODUCT_VERSIONS_PK PRIMARY KEY 
  (
    VERSION 
  , PRODUCT_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX PRODUCT_VERSIONS_PK_I ON PRODUCT_VERSIONS (VERSION ASC, PRODUCT_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE ORDER_ITEMS 
(
  ORDER_ID NUMBER(6, 0) NOT NULL 
, PRODUCT_ID NUMBER(5, 0) NOT NULL 
, VERSION NUMBER(3, 0) NOT NULL 
, PRODUCTS_COUNT NUMBER(3, 0) NOT NULL 
, CONSTRAINT ORDER_ITEMS_PK PRIMARY KEY 
  (
    ORDER_ID 
  , PRODUCT_ID 
  , VERSION 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ORDER_ITEMS_PK_I ON ORDER_ITEMS (ORDER_ID ASC, PRODUCT_ID ASC, VERSION ASC) 
  )
  ENABLE 
);

CREATE INDEX CLIENT_ID_FK_I ON ORDERS (CLIENT_ID);

CREATE INDEX ORDER_ID_FK_I ON ORDER_ITEMS (ORDER_ID);

CREATE INDEX PRODUCT_VERSION_FK_I ON ORDER_ITEMS (PRODUCT_ID, VERSION);

CREATE INDEX PRODUCT_ID_FK_I ON PRODUCT_VERSIONS (PRODUCT_ID);

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_CLIENTS_FK FOREIGN KEY
(
  CLIENT_ID 
)
REFERENCES CLIENTS
(
  CLIENT_ID 
)
ENABLE;

ALTER TABLE ORDER_ITEMS
ADD CONSTRAINT ORDER_ITEMS_ORDERS_FK FOREIGN KEY
(
  ORDER_ID 
)
REFERENCES ORDERS
(
  ORDER_ID 
)
ENABLE;

ALTER TABLE ORDER_ITEMS
ADD CONSTRAINT ORDER_ITEMS_PROD_VERSIONS_FK FOREIGN KEY
(
  VERSION 
, PRODUCT_ID 
)
REFERENCES PRODUCT_VERSIONS
(
  VERSION 
, PRODUCT_ID 
)
ENABLE;

ALTER TABLE PRODUCT_VERSIONS
ADD CONSTRAINT PRODUCT_VERSIONS_PRODUCTS_FK FOREIGN KEY
(
  PRODUCT_ID 
)
REFERENCES PRODUCTS
(
  PRODUCT_ID 
)
ENABLE;

ALTER TABLE CLIENTS
ADD CONSTRAINT CHECK_PHONE_FORMAT CHECK 
(REGEXP_LIKE(PHONE,'^\d{9}$'))
ENABLE;

ALTER TABLE CLIENTS
ADD CONSTRAINT CHECK_ZIP_CODE_FORMAT CHECK 
(REGEXP_LIKE(ZIP,'^\d{5}$'))
ENABLE;

ALTER TABLE ORDERS
ADD CONSTRAINT CHECK_ORDER_VALUE_NONNEGATIVE CHECK 
(ORDER_VALUE >= 0)
ENABLE;

ALTER TABLE ORDER_ITEMS
ADD CONSTRAINT PRODUCTS_COUNT_NONNEGATIVE CHECK 
(PRODUCTS_COUNT >= 0
)
ENABLE;

ALTER TABLE PRODUCT_VERSIONS
ADD CONSTRAINT CHECK_AVAILABLE_NONNGEGATIVE CHECK 
(AVAILABLE >= 0)
ENABLE;

ALTER TABLE PRODUCT_VERSIONS
ADD CONSTRAINT CHECK_PRICE_NONNEGATIVE CHECK 
(PRICE  >= 0)
ENABLE;

COMMENT ON TABLE CLIENTS IS 'Dictionary of clients';

COMMENT ON TABLE ORDERS IS 'Orders that clients make';

COMMENT ON TABLE ORDER_ITEMS IS 'Products that were requested in a particular order';

COMMENT ON TABLE PRODUCTS IS 'Dictionary of products';

COMMENT ON TABLE PRODUCT_VERSIONS IS 'Versions of products - price and stock availability';

COMMENT ON COLUMN CLIENTS.CLIENT_ID IS 'Clients identification number';

COMMENT ON COLUMN CLIENTS.FIRST_NAME IS 'Clients first name';

COMMENT ON COLUMN CLIENTS.LAST_NAME IS 'Clients last name';

COMMENT ON COLUMN CLIENTS.PHONE IS 'Clients phone number';

COMMENT ON COLUMN CLIENTS.HOUSE_NUMBER IS 'Clients house number';

COMMENT ON COLUMN CLIENTS.STREET IS 'Clients street';

COMMENT ON COLUMN CLIENTS.CITY IS 'Clients city';

COMMENT ON COLUMN CLIENTS.ZIP IS 'Clients ZIP code';

COMMENT ON COLUMN ORDERS.ORDER_ID IS 'Orders identification number';

COMMENT ON COLUMN ORDERS.CLIENT_ID IS 'Orders client';

COMMENT ON COLUMN ORDERS.ORDER_VALUE IS 'Total value of order';

COMMENT ON COLUMN ORDERS.DATE_ORDERED IS 'Date when the order was received';

COMMENT ON COLUMN ORDER_ITEMS.ORDER_ID IS 'Order identification number';

COMMENT ON COLUMN ORDER_ITEMS.PRODUCT_ID IS 'Product identification number';

COMMENT ON COLUMN ORDER_ITEMS.VERSION IS 'Products version';

COMMENT ON COLUMN ORDER_ITEMS.PRODUCTS_COUNT IS 'How much of this product was ordered';

COMMENT ON COLUMN PRODUCTS.PRODUCT_ID IS 'Products identification number
';

COMMENT ON COLUMN PRODUCTS.NAME IS 'Products name';

COMMENT ON COLUMN PRODUCT_VERSIONS.PRODUCT_ID IS 'Product identification number';

COMMENT ON COLUMN PRODUCT_VERSIONS.VERSION IS 'Products version';

COMMENT ON COLUMN PRODUCT_VERSIONS.VERSION_NAME IS 'Product versions name';

COMMENT ON COLUMN PRODUCT_VERSIONS.PRICE IS 'Unit price';

COMMENT ON COLUMN PRODUCT_VERSIONS.DATE_CREATED IS 'Date when version was created';

COMMENT ON COLUMN PRODUCT_VERSIONS.AVAILABLE IS 'How many left in stock';

commit;
