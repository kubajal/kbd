msg() {
        echo "$1" | figlet $2
}

test_start()
{
        spaces="                                               "
        args="$2"
        msg "============="
        msg "Test" "-c"
        echo ""
        echo "======================================================================================================================"
        printf "%-116s8\n" "$1"
        printf "CLI args %-109s\n" "$args"
        msg "\/\/\/\/\/\/"
}

test_end()
{
        msg "/\/\/\/\/\/\/"
        msg "============="
        printf "%-118s\n" "$1 has ended"
        msg "============="
}

test() {

        test_start "$1" "$2"

        export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais $2`"
        check=`echo $result | grep "$3"`
        if [ "$check" = "" ]; then
                msg "TEST FAILED" "-c"
                echo "Log of the test:"
                echo "$result";
        else
                msg "TEST PASSED" "-c"
        fi
        test_end "$1"
        echo "\n"
        echo "\n"
}

test_suite()
{
        test "Inserting into ORDER_ITEMS should subtract from PRODUCT_VERSIONS.AVAILABLE" "@tests/available.sql" "1109"
        test "Inserting into ORDER_ITEMS should set proper ORDERS.ORDER_VALUE" "@tests/order_value.sql" "128.03"
        test "Inserting into ORDER_ITEMS item with PRODUCT_COUNT bigger than ORDERS.AVAILABLE should throw error" "@tests/products_count_too_big.sql" "ORA-20001" # Not enough products available. Rolling back order.
        test "Deleting from ORDER_ITEMS should add to ORDERS.AVAILABLE" "@tests/products_count_restore.sql" "54321" # Adding to ORDERS.AVAILABLE when an order item is deleted.
}

test_suite