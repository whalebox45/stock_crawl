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

if ! test -f ./pepb_data/${load_year}/${load_date}.csv;
then
        echo "./pepb_data/${load_year}/${load_date}.csv not found"
        exit 1
fi

query_load="LOAD DATA LOCAL INFILE"

query_file="\"pepb_data/${load_year}/${load_date}.csv\" "

query_replace="REPLACE INTO TABLE \`stock_eagle\`.\`pepb_${load_year}\` "

query_form="CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'"

query_col="(\`security_code\`, \`name\`,\`dividend_yield\`,\`dividend_year\`,\`pe_ratio\`, \`pb_ratio\`,\`fiscal_quarter\`) set\`date\` = $load_date"

echo $query_load$query_file$query_replace$query_form$query_col

mysql --user="stock_eagle" --password="hotelcalifornia" -e "$query_load$query_file$query_replace$query_form$query_col"

