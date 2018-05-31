select s.security_code,name, category_list.category_code from (select distinct security_code , name from stock_2018
where security_code in (
	select security_code
	from stock_2018 where open_price = '--'
    	and date = date(now())
	)
and security_code in (
	select security_code from stock_2018 where open_price = '--'
    	and date = date(now())-1
	)
) as s join category_list on category_list.security_code = s.security_code
