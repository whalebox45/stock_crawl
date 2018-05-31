SELECT date,security_code,name as info,
    open_price, closing_price, dir,
    concat(round(abs(closing_price - open_price)/open_price*100,2),'%') as percentage
FROM stock_eagle.stock_2018
where date = 20180504 and open_price != '--' and dir = '+'
order by percentage desc limit 10;