import os,sys
import datetime,time
import requests

error_code = 0
def main():
    date_str = "yyyymmdd"
    today = datetime.datetime.now()

    # Fetch today's csv if no argument
    if len(sys.argv) < 2:
        date_str = str(today.year) + "%02d"%today.month + "%02d"%today.day
    else:
        date_str = sys.argv[1]

    # Validate the date string
    try:
        fetch_date = time.strptime(date_str,'%Y%m%d')
    except ValueError as err:
        print(err)
        exit(1)



    try:
        filename = "closing_raw_data/"+str(fetch_date.tm_year)+"/"+date_str+".csv"

        if os.path.isfile(filename):
            print("%s: File already exists."%filename)
        print("fetching %s from http://twse.com.tw/ ..."%date_str)

        response = requests.get("http://www.twse.com.tw/exchangeReport/MI_INDEX?response=csv&"+
                                "date="+date_str+"&type=ALLBUT0999")

	# Delay in order to slow down the crawling
        time.sleep(3)

        response_data = response.text
        del response

        # When the fetched data is empty then skip saving file as csv
        if(len(response_data) < 100):
            raise Exception("Data is empty.")

        print("Saving as \"%s\""%filename)

        output_csv = open(filename,"w",newline="",encoding="utf-8")
        output_csv.write(response_data)
        output_csv.close()

        print("\"%s\" saved"%filename)

    except Exception as e:
        print(e)

    exit(error_code)

if __name__=="__main__":
    main()
