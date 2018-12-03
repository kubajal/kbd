export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais @tests/order_value.sql`"
check=`echo $result | grep "128.03"`
if [ "$check" = "" ]; then
        echo "TEST FAILED: wrong order value"
        echo "Log of the test:"
        echo "$result";
else
        echo "TEST PASSEd: order value test passed"
fi

export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais @tests/available.sql`"
check=`echo $result | grep "1109"`
if [ "$check" = "" ]; then
        echo "TEST FAILED: wrong number of available products."
        echo "Log of the test:"
        echo "$result";
else
        echo "TEST PASSED: order value test passed"
fi
