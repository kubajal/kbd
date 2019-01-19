CREATE OR REPLACE VIEW CLIENT_TRADE_BY_MONTH
AS select first_name, last_name, trade, yr as "year", mnt as "month"
  from clients left outer join 
    (select client_id as cid, sum(order_value) as trade, extract(year from date_ordered) as yr, extract(month from date_ordered) as mnt
        from orders
        group by (client_id, extract(year from date_ordered), extract(month from date_ordered)))
    on clients.client_id = cid;

CREATEOR REPLACE  VIEW CURRENT_PRICES
AS SELECT 
    products.name, date_cr, tmp.ver
FROM
    products join (select max(date_created) as date_cr, max(version) as ver, product_id as prod_id from product_versions group by product_id) tmp
    on products.product_id = prod_id;
