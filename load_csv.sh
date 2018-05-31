#!/bin/bash


if test $# -eq 0
then
	load_date=`date "+%Y%m%d"`
else
	load_date="$1"
fi

echo "$load_date"

if
	date -d $load_date > /dev/null
then
	true
else
	echo "Invalid date format"
	exit 1
fi

load_year=`date -d $load_date "+%Y"`

if ! test -f ./closing_data/${load_year}/${load_date}.csv;
then
	echo "./closing_data/${load_year}/${load_date}.csv not found"
	exit 1
fi

query_load="LOAD DATA LOCAL INFILE"

query_file="\"closing_data/${load_year}/${load_date}.csv\" "

query_replace="REPLACE INTO TABLE \`stock_eagle\`.\`stock_${load_year}\` "

query_form="CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\\n'"

query_col="(\`security_code\`, \`name\`, \`trade_volume\`, \`transaction\`, \`trade_value\`, \`open_price\`, \`high_price\`,
	\`low_price\`, \`close_price\`, \`dir\`, \`price_change\`, \`last_best_bid_price\`, \`last_best_bid_volume\`,
	\`last_best_ask_price\`, \`last_best_ask_volume\`, \`price_earning_ratio\`) set\`date\` = $load_date"

echo $query_load$query_file$query_replace$query_form$query_col

mysql --user="stock_eagle" --password="hotelcalifornia" -e "$query_load$query_file$query_replace$query_form$query_col"


