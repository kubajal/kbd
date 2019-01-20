CREATE TRIGGER AFTER_DELETE_ORDER_ITEM 
-- Lowers price of the corresponding orders and returns number of items from this products stock.
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
  -- Updates price of the corresponding orders and returns subtracts products from this products stock.
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
-- Check if order_value is not equal to zero or null. Optionally set order_id to the next value from the sequence.
BEFORE INSERT ON ORDERS 
for each row
begin
    if :new.order_value != 0
    then
        RAISE_APPLICATION_ERROR( -20004,
                             'Value of a newly created order must be zero.');
    end if;
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
-- Check there is enough of this product.
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

CREATE TRIGGER BEFORE_INSERT_PRODUCT 
-- Optionally set product_id to the value from the sequence.
BEFORE INSERT ON PRODUCTS
for each row
BEGIN
  if :new.product_id is null
  then
    :new.product_id := product_id_seq.nextval;
  end if;
END;
/

CREATE TRIGGER BEFORE_INSERT_PRODUCT_VERSION 
-- Check if date_created is after current timestamp, if there is non-negative value of available products, optionally set date_created, available, version_name to non-null values. Optionally set version to the value from the sequence.
BEFORE INSERT ON PRODUCT_VERSIONS
for each row
declare
    highest_version number;
BEGIN
    if :new.date_created > SYSDATE
    then
        RAISE_APPLICATION_ERROR( -20001,
                             'Product version creation date cant be later than current time.');
    end if;
    if :new.available < 0
    then
        RAISE_APPLICATION_ERROR( -20003,
                             'Available products count cant be lower than zero.');
    end if;
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
    if :new.version is null
    then
        select max(version) into highest_version from product_versions where product_id = :new.product_id;
        if highest_version is null
        then
            highest_version := -1;
        end if;
      :new.version := highest_version + 1;
    end if;
END;
/

CREATE TRIGGER BEFORE_UPDATE_PRODUCT_VERSION 
BEFORE INSERT ON PRODUCT_VERSIONS
for each row
declare
    tmp ROWTYPE;
begin
    select (order_items.products_count * (:old.price - :new.price)) as diff, orders.order_id 
    into tmp 
    from orders 
    join order_items 
    on order_items.product_id = :new.product_id and order_items.version = :new.version;
    update orders
        set order_value = order_value - tmp.diff
        where order_id = tmp.order_id;
end;
/
