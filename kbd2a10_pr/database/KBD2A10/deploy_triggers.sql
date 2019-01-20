CREATE TRIGGER AFTER_DELETE_ORDER_ITEM 
AFTER DELETE ON ORDER_ITEMS 
for each row
declare
    unit_price number;
    price_sum number;
    does_product_version_exist number;
BEGIN
    -- lower the price of the order
    select pv.price into unit_price
        from product_versions pv
        where pv.product_id = :old.product_id
        and pv.version = :old.version;
    price_sum := unit_price * :new.products_count;
    update orders
    set orders.order_value = orders.order_value - price_sum
    where orders.order_id = :old.order_id;
    
    -- return products_count to the stock
    update product_versions
    set product_versions.available = product_versions.available + :old.products_count
    where product_versions.product_id = :old.product_id
        and product_versions.version = :old.version;
END;
/

CREATE TRIGGER AFTER_INSERT_ORDER_ITEM 
AFTER INSERT ON ORDER_ITEMS 
for each row
declare
    unit_price number;
    price_sum number;
    does_product_version_exist number;
begin

-- 'order_value' column in ORDERS table
    select pv.price into unit_price
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version = :new.version;
    price_sum := unit_price * :new.products_count;
    update orders
    set orders.order_value = orders.order_value + price_sum
    where orders.order_id = :new.order_id;

-- 'available' column in PRODUCT_VERSIONS column
    update product_versions
    set product_versions.available = product_versions.available - :new.products_count
    where product_versions.product_id = :new.product_id
        and product_versions.version = :new.version;
end;
/

CREATE TRIGGER BEFORE_INSERT_ORDER 
BEFORE INSERT ON ORDERS 
for each row
begin
    if :new.order_value is null
    then
        :new.order_value := 0;
    end if;
    if :new.order_id is null
    then
        :new.order_id := order_id_seq.nextval;
    end if;
end;
/

CREATE TRIGGER BEFORE_INSERT_ORDER_ITEM 
BEFORE INSERT ON ORDER_ITEMS 
for each row
declare
    available number;
BEGIN
    select pv.available into available
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version = :new.version;

    if(available - :new.products_count < 0)
    then
    RAISE_APPLICATION_ERROR( -20002,
                             'Not enough products available.');
    end if;
END;
/

CREATE TRIGGER BEFORE_INSERT_PRODUCT_VERSION 
BEFORE INSERT ON PRODUCT_VERSIONS
for each row
BEGIN
    if :new.date_created is null
    then
      :new.date_created := sysdate;
    end if;
    if :new.available is null
    then
      :new.available := 0;
    end if;
    if :new.version_name is null
    then
      :new.version_name := '';
    end if;
END;
/
