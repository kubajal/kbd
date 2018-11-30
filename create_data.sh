generate_number()
{
        n=$(((RANDOM % $1) + $2))
        echo $n
}

client_ids=()

i=1
while [ $i -lt 100 ]
do
        random="`generate_number 100 0`"
        id="`generate_number 8999 1000`"
        zip="`generate_number 89999 10000`"
        house_number="`generate_number 8999 1000`"
        first_name="`shuf -n1 names`"
        last_name="`shuf -n1 surnames`"
        city="`shuf -n1 cities`"
        street="`shuf -n1 streets`"
        phone1="`generate_number 899 100`"
        phone2="`generate_number 899 100`"
        phone3="`generate_number 899 100`"
        echo "insert into clients values ($id, '$zip', $house_number, '$first_name', '$last_name', '$city', '$street', '$phone1$phone2$phone3');"
        client_ids=( "$id" "${client_ids[@]} ")

        i=$(( $i + 1 ))
done

i=1
while [ $i -lt 100 ]
do
        id="`generate_number 89999 10000`"
        index_client="`generate_number 100 1`"
        client_id="${client_ids[$index_client]}"
        date_received=`date -d "$((RANDOM%1+2018))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%Y-%m-%d %H:%M:%S'`
        echo "insert into orders values ($id, $client_id, $date_received);"

        i=$(( $i + 1 ))
done

i=1
while [ $i -lt 10 ]
do
        #date -d "$((RANDOM%1+2010))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%d-%m-%Y %H:%M:%S'

        i=$(( $i + 1 ))
done