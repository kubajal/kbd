create or replace trigger order_item_added
before insert on order_items
for each row
declare
    products_count number;
    price number;
    total_price number;
    available number;
    does_product_version_exist number;
begin

    select count(*) into does_product_version_exist from product_versions where :new.product_id = product_id and :new.version = version;

    if(does_product_version_exist = 0)
    then
        RAISE_APPLICATION_ERROR( -20001,
                               'Version of the product doesnt exist.');
    end if;                           

    select pv.available into available
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version = :new.version;

    if(available - :new.products_count < 0)
    then
    RAISE_APPLICATION_ERROR( -20002,
                             'Not enough products available.');
    end if;

-- 'order_value' column in ORDERS table
    select pv.price into price
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version = :new.version;
    total_price := price * :new.products_count;
    update orders
    set orders.order_value = orders.order_value + total_price
    where orders.order_id = :new.order_id;

-- 'available' column in PRODUCT_VERSIONS column
    update product_versions
    set product_versions.available = product_versions.available - :new.products_count
    where product_versions.product_id = :new.product_id
        and product_versions.version = :new.version;

end;
/