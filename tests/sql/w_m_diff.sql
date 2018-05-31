select 
	dd.date,
	dd.security_code,
    dd.name,
    cast(cp - mo as decimal(5,2)) as m_price_diff,
    cast(cp - wo as decimal(5,2)) as w_price_diff,
	cast((cp-mo)/mo *100 as decimal(5,2)) as 'm_diff_rate(%)',
    cast((cp-wo)/wo *100 as decimal(5,2)) as 'w_diff_rate(%)',
    cast((cp-wo)/wo * 100 - (cp-mo)/mo * 100 as decimal(5,2)) as 'w/m_diff_rate(%)'
from
(
	(
		select 
			date,
            security_code,
            open_price as mo
		from stock_2018 
		where date = (select * from (select distinct date from stock_2018 order by date desc limit 21) as a order by date limit 1)
	) as md
	right join
	(
		select 
			date,
            security_code,
            open_price as wo
		from stock_2018
		where date = (select  * from (select distinct date from stock_2018 order by date desc limit 6) as a order by date limit 1)
	) as wd
	on wd.security_code = md.security_code
    right join
    (
		select 
			date,
            security_code,
            name,
            close_price as cp
        from stock_2018
        where date = (select distinct date from stock_2018 order by date desc limit 1)
    ) as dd
    on dd.security_code = wd.security_code
)
where not(mo is null or wo is null or mo = "--" or wo = "--" or cp = "--");