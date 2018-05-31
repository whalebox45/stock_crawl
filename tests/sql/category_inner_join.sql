SELECT pepb_2018.date,pepb_2018.security_code,pepb_2018.name,pe_ratio, category_code
FROM stock_eagle.pepb_2018 inner join category_list on category_list.security_code=convert(pepb_2018.security_code,char(10))
where date = 20180511 and category_code = 2 and pe_ratio != 0
order by convert(pe_ratio,decimal(5,2));
