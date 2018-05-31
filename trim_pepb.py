import calendar
import os,sys
import re
import datetime,time

import csv

exit_code = 0

date_str = "yyyymmdd"
today = datetime.datetime.now()
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


filename = "pepb_raw_data/"+str(fetch_date.tm_year)+"/"+date_str+".csv"
new_filename = "pepb_data/"+str(fetch_date.tm_year)+"/"+date_str+".csv"

try:
	if not os.path.isfile(filename):
		exit_code = 1
		raise Exception("Cannot trim: "+filename+" not exists")
	if os.path.isfile(new_filename):
		print("Re-trim: "+new_filename+" (existed)")
		
			
	of = open(new_filename,'w',newline="",encoding="utf-8")

	with open(filename,'r',newline="",encoding="utf-8") as fp:
		for line in fp:
			new_regex = "\"[0-9]{4}.*"
			m = re.compile(new_regex)

			# skip when filtered string is empty
			if(not m.findall(line)):
				continue
			
			wt = ''.join(m.findall(line))+"\n"
			
			num_for_regex = ",(?=\d{3})"

			wt = re.sub(num_for_regex,'',wt)
			
			# uncomment print to inspect the fetched string
			#print(wt)
			of.write(wt)
		
		of.close()
		print("\"%s\" saved"%new_filename)

except Exception as e:
	print(e)
	exit(exit_code)
