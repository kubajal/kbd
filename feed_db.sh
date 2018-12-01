generate_number()
{
	if [ $1 -eq "1" ]; then
		echo "$2"
	else
		echo "$(((RANDOM % $1) + $2))"
	fi
}

generate_date()
{
	echo "to_timestamp('`date -d "$((RANDOM%1+$1))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%Y-%m-%d %H:%M:%S'`')"
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
	client_ids=( "$id" "${client_ids[@]}")

	i=$(( $i + 1 ))
done

order_ids=()

i=1
while [ $i -lt 100 ]
do
	id="`generate_number 8999 1000`"
	index_client="`generate_number 99 1`"
	client_id="${client_ids[$index_client]}"
	date_received=`generate_date 2018`
	echo "insert into orders values ($id, $client_id, $date_received);"
	order_ids=("$id" "${order_ids[@]}")

	i=$(( $i + 1 ))
done

i=1
while read -r line; do
	name="$line"
	echo "insert into products values ($i, '$name');"
	i=$((i + 1))
done < "foods"

declare -a product_versions

#n - number of products
n=$i
i=1
while [ $i -lt "$n" ]
do
	random="`generate_number 3 1`"
	id=$i
	version="`generate_number 899 100`"
	price1="`generate_number 20 0`"
	price2="`generate_number 89 10`"
	available=$((`generate_number 30 10` * 100))

	for v in $(eval echo "{1..$random}")
	do
		date=`generate_date $((2015 + $v))`
		echo "insert into product_versions values ($id, $v, 'version $v', $price1.$price2, $date, $available);"
	done
	product_versions[$i]=$random
	i=$(($i + 1))
done


i=1
while [ $i -lt 99 ]
do
	random="`generate_number 3 1`"
	order_id="${order_ids[$i]}"
	products_count="`generate_number 89 10`"
	for v in $(eval echo "{1..$random}")
	do
		product_id="`generate_number $n 1`"
		t="${product_versions[$product_id]}"
		product_version=`generate_number $t 1`
		echo "insert into order_items values ($order_id, $product_id, $product_version, $products_count);"
	done
	i=$(($i+1))
done

i=1
while [ $i -lt 10 ]
do
#	generate_date 2018
	i=$(( $i + 1 ))
done

