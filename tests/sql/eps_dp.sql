SELECT 
	pepb_2018.date,
	pepb_2018.security_code,
	pepb_2018.name,
    close_price,
    pe_ratio,
    close_price / pe_ratio as eps,
    cast((dividend_yield * close_price) as decimal(10,2)) as `dividend(%)`,
    cast((dividend_yield * pe_ratio) as decimal(10,2)) as `dividend_payout_ratio(%)`
FROM pepb_2018 
left join
stock_2018
on stock_2018.date = pepb_2018.date and stock_2018.security_code = pepb_2018.security_code;