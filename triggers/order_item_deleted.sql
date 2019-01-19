-- DELETE

create or replace trigger order_item_deleted
before delete on order_items
for each row
begin

-- 'available' column in PRODUCT_VERSIONS column
    update product_versions
    set product_versions.available = product_versions.available + :old.products_count
    where product_versions.product_id = :old.product_id
        and product_versions.version = :old.version;

end;
/
commit;
/