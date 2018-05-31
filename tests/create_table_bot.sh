begin_date=`date -d '20100101' '+%Y%m%d'`
     
end_date=`date -d '20181201' '+%Y%m%d'`

date_iter=$begin_date
while [ $date_iter -ne $end_date ]
do
    echo $date_iter
    mysql -u whale -pbigwr@WB4.5 -e "use stock_eagle; create table stock_`date -d "$date_iter" '+%Y%m'` like stock_table"
    date_iter=`date -d "$date_iter + 1month" '+%Y%m%d'`
done

echo ok


