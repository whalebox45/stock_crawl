select security_code,
(
	select open_price from stock_2010 
	where security_code = 1234 and
	date = (select min(date) from stock_2010 where security_code = 1234 and	
			month(date)=1 and open_price != '--')
) as open,
max(high_price) as high,
min(low_price) as low,
(
	select close_price from stock_2010
    where security_code = 1234 and
    date = (select max(date) from stock_2010 where security_code = 1234 and
			month(date)=1 and open_price != '--')
) as close
from stock_2010 
where security_code = 1234 and	
month(date)=1;
