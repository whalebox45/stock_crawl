import requests
import time, datetime, os, calendar

def fetch_webdata(year,month,day):

    date = str(year)+"%02d"%month+"%02d"%day

    # skip when the file exists
    filename = "closing_raw_data/"+str(year)+"/"+date+".csv"
    if os.path.isfile(filename):
        return

    try:
        response = requests.post("http://www.twse.com.tw/exchangeReport/MI_INDEX?response=csv&"+
                                "date="+date+"&type=ALLBUT0999")
        # delay prevents requesting too rapidly
        time.sleep(5)

        rt = response.text

        if(len(rt)<100):
            print(date+" empty")
            return
        outputFile = open(filename,"w",newline="",encoding="utf-8")
        outputFile.write(rt)
        outputFile.close()
        print(date+" ok")
    except requests.exceptions.Timeout:
        # Maybe set up for a retry, or continue in a retry loop
        pass
    except requests.exceptions.TooManyRedirects:
        # Tell the user their URL was bad and try a different one
        pass
    except requests.exceptions.RequestException as e:
        # catastrophic error. bail.
        print(e)
    except requests.exceptions.ConnectionError:
        pass



now_time = datetime.datetime.now()
# now_time.year returns current year

year_list = range(2017,now_time.year+1) # since year of first param to year of system clock
month_list = range(12,13) # since the x-th month to (13-1)th month



for year in year_list:
    for month in month_list:
        # break loop while month over current month
        if(now_time.year == year and month > now_time.month): break
        # calendar.monthrange returns a list with starting weekday and days of the month
        month_lastday = calendar.monthrange(year,month)[1]

        for day in range(7,month_lastday+1):
            print("fetching"+"%d"%year+"%02d"%month+"%02d"%day)
            fetch_webdata(year,month,day)


print("Done")


input()
