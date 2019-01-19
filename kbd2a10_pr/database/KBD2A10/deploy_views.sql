SET SQLBLANKLINES ON
CREATE VIEW CLIENT_TRADE_BY_MONTH
AS select first_name, last_name, trade, yr as "year", mnt as "month"
  from clients left outer join 
    (select client_id as cid, sum(order_value) as trade, extract(year from date_ordered) as yr, extract(month from date_ordered) as mnt
        from orders
        group by (client_id, extract(year from date_ordered), extract(month from date_ordered)))
    on clients.client_id = cid;

CREATE VIEW CURRENT_PRICES
AS SELECT 
    products.name, date_cr, tmp.ver
FROM
    products join (select max(date_created) as date_cr, max(version) as ver, product_id as prod_id from product_versions group by product_id) tmp
    on products.product_id = prod_id;

CREATE VIEW HIGHEST_GAIN_PRODUCTS
AS select max(gain) as max_gain, "year", "month", max(prod_id)
from (select order_items.product_id as prod_id, sum(product_versions.price * order_items.products_count) as gain, extract(year from orders.date_ordered) as "year", extract(month from orders.date_ordered) as "month"
    from order_items 
        join product_versions on order_items.product_id = product_versions.product_id
        join orders on order_items.order_id = orders.order_id
    group by order_items.product_id, extract(year from orders.date_ordered), extract(month from orders.date_ordered))
group by "year", "month"
order by "year" desc, "month" desc;

COMMENT ON TABLE HIGHEST_GAIN_PRODUCTS IS 'Accumulates';
