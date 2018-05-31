#!/bin/bash
today=`date "+%Y/%m/%d %H:%M:%S"`
echo $today >> ./log/fetch.log
echo $today >> ./log/import.log
python3 ./fetch_date.py >> ./log/fetch.log
python3 ./pepb_date.py >> ./log/fetch.log
python3 ./trim_closing.py >> ./log/fetch.log
python3 ./trim_pepb.py >> ./log/fetch.log
bash ./load_csv.sh >> ./log/import.log
bash ./load_pepb.sh >> ./log/import.log
