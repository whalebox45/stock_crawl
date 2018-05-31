begin_date=`date -d '20180101' '+%Y%m%d'`
dest_date=`date '+%Y%m%d'`

date_iter=$begin_date
while [ $date_iter -ne $dest_date ]
do
    echo $date_iter
    date_iter=`date -d "$date_iter + 1day" '+%Y%m%d'`
    ./load_pepb.sh $date_iter
   # sleep 0.3s
done

echo $dest
