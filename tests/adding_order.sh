test_start()
{
        spaces="                                               "
        args="$2"
        printf "==================================================================================================\n"
        printf "|                                           Test                                                 |\n"
        printf "==================================================================================================\n"
        printf "|%-97s|\n" "$1"
        printf "|CLI args %-76s|\n" "$args"
        printf "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\n"
}

test_end()
{
        printf "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ \n"
        printf "|                                               |\n"
        printf "==================================================================================================\n"
        printf "|%-97s|\n" "$1 has ended"
        printf "==================================================================================================\n"
}

test() {

        test_start "$1" "$2"

        export result="`echo EXIT | sqlplus64 $db_user/$db_password@ora1.elka.pw.edu.pl/iais $2`"
        check=`echo $result | grep "$3"`
        if [ "$check" = "" ]; then
                echo "TEST FAILED"
                echo "Log of the test:"
                echo "$result";
        else
                echo "TEST PASSED"
        fi
        test_end "$1"
        printf "\n"
        printf "\n"
}

test_suite()
{
        test "Inserting into ORDER_ITEMS should subtract from PRODUCT_VERSIONS.AVAILABLE" "@tests/available.sql" "1109"
}

test_suite