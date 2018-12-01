create or replace trigger order_item_added
before insert on order_items
for each row
declare
    products_count number;
    price number;
    total number;
begin
    select pv.price into price
        from product_versions pv
        where pv.product_id = :new.product_id
        and pv.version_id = :new.version_id;
    total := price * :new.products_count;
    update orders
    set orders.order_value = orders.order_value+ total
    where orders.order_id = :new.order_id;
end;
/