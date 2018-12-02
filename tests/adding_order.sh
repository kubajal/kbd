result="`sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais @tests/adding_order.sql << 'exit'`"
check=`echo $result | grep "128.03"`
if [ "$check" = "" ]; then
    echo "TEST FAILED: wrong order value"
else
    echo "TEST PASSED: order value test passed"
fi