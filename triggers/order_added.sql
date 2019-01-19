create or replace trigger order_added
before insert on orders
for each row
begin
    if :new.order_value is null
    then
        :new.order_value := 0;
    end if;
end;
/
commit;
/