create or replace trigger order_item_added
before insert on order_items
for each row
declare
    order_item_product_version orders%ROWTYPE;
    ord_val number(6,2);
begin
    select oi.products_count, pv.price into ord_val
        from order_items oi
        join product_versions pv
        on oi.product_id = pv.product_id
        and oi.version_id = pv.version_id;
        
end;
/