export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais @tests/order_value.sql`"
check=`echo $result | grep "128.03"`
if [ "$check" = "" ]; then
	    echo "FAILED: wrong order value"
else
        echo "TESTOK: order value test passed"
fi

export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais @tests/available.sql`"
check=`echo $result | grep "98"`
if [ "$check" = "" ]; then
	    echo "FAILED: wrong order value"
else
        echo "TESTOK: order value test passed"
fi
