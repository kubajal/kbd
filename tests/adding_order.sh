msg() {
	if [ "$2" = "" ]; then
		echo "$1" | toilet --filter gay -f slant -t
	else
		echo "$1" | toilet "$2"
	fi
}

i=0;

test_start()
{
        echo "=================================================================================================="
        echo "= ********************************************************************************************** ="
	msg "- Test $i -> $3"
	args="$2"
        printf "%-116s\n" "$1"
        printf "CLI args %-109s\n" "$args"
}

test_end()
{
	if [ "$3" = "FAILED" ]; then
		
		echo "Log of the test:"
		echo "$result";
	fi
        echo "= ********************************************************************************************** ="
        echo "=================================================================================================="
	printf "\n\n\n"
}

test() {
	i=$(($i+1))
        export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais $2`"
        check=`echo $result | grep "$3"`
        if [ "$check" = "" ]; then
                status="FAILED"
                echo "Log of the test:"
                echo "$result";
        else
                status="PASSED"
        fi
        test_start "$1" "$2" "$status"
        test_end "$1" "$status"
}

test_suite()
{
        test "Inserting into ORDER_ITEMS should subtract from PRODUCT_VERSIONS.AVAILABLE" "@tests/available.sql" "1109"
        test "Inserting into ORDER_ITEMS should set proper ORDERS.ORDER_VALUE" "@tests/order_value.sql" "128.03"
        test "Inserting into ORDER_ITEMS item with PRODUCT_COUNT bigger than ORDERS.AVAILABLE should throw error" "@tests/products_count_too_big.sql" "ORA-20001" # Not enough products available. Rolling back order.
        test "Deleting from ORDER_ITEMS should add to ORDERS.AVAILABLE" "@tests/products_count_restore.sql" "54321" # Adding to ORDERS.AVAILABLE when an order item is deleted.
}

test_suite

