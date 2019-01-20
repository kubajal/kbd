create or replace PROCEDURE startWWW(max_number IN NUMBER DEFAULT 20)
-- PL/SQL Procedure generating:
-- The most profitable products
-- Best clients
-- product that price have changed during last month
IS
BEGIN
    HTP.HTMLOPEN;   -- <html>
    HTP.HEADOPEN;   -- <head>

    -- STYLES
    HTP.STYLE('
       html, body {
           width: 100%;
       }
       table, th, td {
           border: 1px solid black;
           padding: 5px;
       }
       table {
           border-spacing: 5px;
           margin: 0 auto;
       }
   ');

    HTP.TITLE('Raport');
    HTP.HEADCLOSE;  -- </head>
    HTP.BODYOPEN;   -- <body>

    --The most profitable products
    HTP.HEADER(1, 'Most profitable products', 'center');
    HTP.PARA;
        HTP.TABLEOPEN;
        HTP.TABLEROWOPEN;
            HTP.TABLEHEADER('Product Name');
            HTP.TABLEHEADER('Profit');
        HTP.TABLEROWCLOSE;
        FOR product IN (select * from (
        Select name, the_highest_value
        From(
        Select name, sum(the_highest_value) as the_highest_value 
        From(
        select name, products_count*price as the_highest_value
        From(
        select t3.product_id, t3.name, t3.products_count, t4.price
        From(
        select t1.product_id as product_id, t1.name as name, t2.products_count as products_count
        from 
        (select product_id, name from products)  t1
        inner join
        (select product_id, products_count from order_items) t2
        on t1.product_id=t2.product_id) t3
        inner join
        (select product_id, price from product_versions) t4
        on t3.product_id=t4.product_id) t5 ) t6
        group by name) t7
        order by the_highest_value desc
        )where ROWNUM <= max_number) LOOP
            HTP.TABLEROWOPEN;
                HTP.TABLEDATA(product.name);
                HTP.TABLEDATA(product.the_highest_value);
            HTP.TABLEROWCLOSE;
        END LOOP;
    HTP.TABLECLOSE;

    --Best clients
    HTP.HEADER(1, 'Best clients', 'center');
    HTP.PARA;
        HTP.TABLEOPEN;
        HTP.TABLEROWOPEN;
            HTP.TABLEHEADER('Client id');
            HTP.TABLEHEADER('First Name');
            HTP.TABLEHEADER('First Name');
            HTP.TABLEHEADER('Orders Number');
        HTP.TABLEROWCLOSE;
        FOR client IN (select * from (select client_id, first_name, last_name, count(*) as orders_number from clients join orders using (client_id) group by client_id, first_name, last_name order by orders_number desc )where ROWNUM <= max_number) LOOP
            HTP.TABLEROWOPEN;
                HTP.TABLEDATA(client.client_id);
                HTP.TABLEDATA(client.first_name);
                HTP.TABLEDATA(client.last_name);
                HTP.TABLEDATA(client.orders_number);
            HTP.TABLEROWCLOSE;
        END LOOP;
    HTP.TABLECLOSE;

    --Products that have hanged last month
    HTP.HEADER(1, 'Products that have hanged last month', 'center');
    HTP.PARA;
        HTP.TABLEOPEN;
        HTP.TABLEROWOPEN;
            HTP.TABLEHEADER('Product Name');
            HTP.TABLEHEADER('New version date');
            HTP.TABLEHEADER('Price');
            HTP.TABLEHEADER('Version');
        HTP.TABLEROWCLOSE;
        FOR product IN (select * from product_versions join products using (product_id) where product_versions.date_created between add_months(trunc(sysdate,'mm'),-1) and last_day(add_months(trunc(sysdate,'mm'),-1)) and ROWNUM <= max_number) LOOP
            HTP.TABLEROWOPEN;
                HTP.TABLEDATA(product.name);
                HTP.TABLEDATA(product.date_created);
                HTP.TABLEDATA(product.price);
                HTP.TABLEDATA(product.version);
            HTP.TABLEROWCLOSE;
        END LOOP;
    HTP.TABLECLOSE;

    HTP.BODYCLOSE;      -- </BODY>
    HTP.HTMLCLOSE;      -- </HTML>
END;