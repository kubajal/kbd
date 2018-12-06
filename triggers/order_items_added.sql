-- INSERT

create or replace trigger order_item_added
before insert on order_items
for each row
declare
    products_count number;
    price number;
    total_price number;
    available number;
begin

    select pv.available into available
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version_id = :new.version_id;
        
    if(available - :new.products_count < 0)
    then
    RAISE_APPLICATION_ERROR( -20001, 
                             'Not enough products available. Rolling back order.');
    end if;

-- 'order_value' column in ORDERS table
    select pv.price into price
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version_id = :new.version_id;
    total_price := price * :new.products_count;
    update orders
    set orders.order_value = orders.order_value + total_price
    where orders.order_id = :new.order_id;

-- 'available' column in PRODUCT_VERSIONS column
    update product_versions
    set product_versions.available = product_versions.available - :new.products_count
    where product_versions.product_id = :new.product_id
        and product_versions.version_id = :new.version_id;

end;
/