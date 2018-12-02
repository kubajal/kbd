SET SQLBLANKLINES ON
CREATE TABLE CLIENTS 
(
  ID NUMBER(6, 0) NOT NULL 
, ZIP CHAR(5 CHAR) NOT NULL 
, HOUSE_NUMBER NUMBER(4, 0) NOT NULL 
, FIRST_NAME VARCHAR2(50) NOT NULL 
, LAST_NAME VARCHAR2(50) NOT NULL 
, CITY VARCHAR2(30) NOT NULL 
, STREET VARCHAR2(30) NOT NULL 
, PHONE VARCHAR2(9 CHAR) 
, CONSTRAINT CLIENTS_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE PRODUCTS 
(
  ID NUMBER(5, 0) NOT NULL 
, NAME VARCHAR2(50) NOT NULL 
, CONSTRAINT PRODUCTS_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE ORDERS 
(
  ORDER_ID NUMBER(10, 0) NOT NULL 
, ID_CLIENT NUMBER(6, 0) NOT NULL 
, ORDER_VALUE NUMBER(6, 2) 
, ORDER_TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE NOT NULL 
, CONSTRAINT ORDERS_PK PRIMARY KEY 
  (
    ORDER_ID 
  )
  ENABLE 
);

CREATE TABLE PRODUCT_VERSIONS 
(
  PRODUCT_ID NUMBER(5, 0) NOT NULL 
, VERSION_ID NUMBER(3, 0) NOT NULL 
, VERSION_NAME VARCHAR2(50) 
, PRICE NUMBER(5, 2) NOT NULL 
, DATE_CREATED TIMESTAMP WITH LOCAL TIME ZONE 
, AVAILABLE NUMBER(5, 0) 
, CONSTRAINT PRODUCT_VERSIONS_PK PRIMARY KEY 
  (
    VERSION_ID 
  , PRODUCT_ID 
  )
  ENABLE 
);

CREATE TABLE ORDER_ITEMS 
(
  ORDER_ID NUMBER(10, 0) NOT NULL 
, PRODUCT_ID NUMBER(5, 0) NOT NULL 
, VERSION_ID NUMBER(3, 0) NOT NULL 
, PRODUCTS_COUNT NUMBER(3, 0) NOT NULL 
, CONSTRAINT ORDER_ITEMS_PK PRIMARY KEY 
  (
    ORDER_ID 
  , PRODUCT_ID 
  , VERSION_ID 
  )
  ENABLE 
);

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_FK1 FOREIGN KEY
(
  ID_CLIENT 
)
REFERENCES CLIENTS
(
  ID 
)
ENABLE;

ALTER TABLE ORDER_ITEMS
ADD CONSTRAINT ORDER_ITEMS_FK1 FOREIGN KEY
(
  ORDER_ID 
)
REFERENCES ORDERS
(
  ORDER_ID 
)
ENABLE;

ALTER TABLE ORDER_ITEMS
ADD CONSTRAINT ORDER_ITEMS_FK2 FOREIGN KEY
(
  VERSION_ID 
, PRODUCT_ID 
)
REFERENCES PRODUCT_VERSIONS
(
  VERSION_ID 
, PRODUCT_ID 
)
ENABLE;

ALTER TABLE PRODUCT_VERSIONS
ADD CONSTRAINT PRODUCT_VERSIONS_FK1 FOREIGN KEY
(
  PRODUCT_ID 
)
REFERENCES PRODUCTS
(
  ID 
)
ENABLE;

COMMENT ON TABLE CLIENTS IS 'Dictionary of clients';

COMMENT ON TABLE ORDERS IS 'Orders that clients make';

COMMENT ON TABLE ORDER_ITEMS IS 'Products that were requested in a particular order';

COMMENT ON TABLE PRODUCTS IS 'Dictionary of products';

COMMENT ON TABLE PRODUCT_VERSIONS IS 'Versions of products - price and stock availability';

COMMENT ON COLUMN CLIENTS.ZIP IS 'Clients address - zip code';

COMMENT ON COLUMN CLIENTS.HOUSE_NUMBER IS 'Clients address - house number';

COMMENT ON COLUMN CLIENTS.FIRST_NAME IS 'Clients first name';

COMMENT ON COLUMN CLIENTS.LAST_NAME IS 'Clients last name';

COMMENT ON COLUMN CLIENTS.CITY IS 'Clients address - city';

COMMENT ON COLUMN CLIENTS.STREET IS 'Clients address - street';

COMMENT ON COLUMN CLIENTS.PHONE IS 'Clients phone number';

COMMENT ON COLUMN ORDERS.ORDER_TIMESTAMP IS 'Timestamp when the order was received';

COMMENT ON COLUMN ORDER_ITEMS.ORDER_ID IS 'ID of the order connected with this item';

COMMENT ON COLUMN ORDER_ITEMS.PRODUCT_ID IS 'ID of the product that was ordered (first part of composite key)';

COMMENT ON COLUMN ORDER_ITEMS.PRODUCTS_COUNT IS 'How much of this product was ordered';

COMMENT ON COLUMN PRODUCTS.NAME IS 'Name of the product';

COMMENT ON COLUMN PRODUCT_VERSIONS.VERSION_NAME IS 'Name or short description of the version';

COMMENT ON COLUMN PRODUCT_VERSIONS.PRICE IS 'Unit price';

COMMENT ON COLUMN PRODUCT_VERSIONS.DATE_CREATED IS 'When the version was created';

COMMENT ON COLUMN PRODUCT_VERSIONS.AVAILABLE IS 'How many left in stock';
