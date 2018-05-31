#!/bin/bash
begin_date=`date -d '20171001' '+%Y%m%d'`
dest_date=`date -d '20180430' '+%Y%m%d'`

date_iter=$begin_date
while [ $date_iter -ne $dest_date ]
do
    echo $date_iter
    python3 ./pepb_date.py $date_iter
    date_iter=`date -d "$date_iter + 1day" '+%Y%m%d'`
    sleep 0.3s
done

echo $dest
