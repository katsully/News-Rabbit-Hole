from nytimesarticle import articleAPI
import datetime
import sys

date = datetime.datetime.now()
date_str = date.strftime('%Y%m%d')

reload(sys)
sys.setdefaultencoding("utf-8")

file_keywords = open("data/keywords.txt")
new_keywords = []

for line in file_keywords:
    new_keywords.append(line.rstrip())
file_key = open("API_keys/ny_times_key.txt")

token = file_key.readline()

file_key.close()

api = articleAPI(token)

articles = api.search(fq = {'news_desk':'National', 'source':['Reuters','AP', 'The New York Times']}, begin_date = date_str, facet_field = ['source','day_of_week'], facet_filter = True)
all_articles = articles['response']['docs']

txt_file = open("data/nytimes.txt", "w")

for stuff in all_articles:
	keyword_str = ""
	main_str = ""
	main_str += stuff['headline']['main'].encode('utf-8') + "`"
	main_str += stuff['lead_paragraph']
	#if 'byline' in stuff: main_str += stuff['byline']['original']
	txt_file.write(main_str + "\n")
	for keyword in stuff['keywords']:
		if keyword['name'] == 'persons':
			name = keyword['value'].split(",")
			name.reverse()
			name = (" ").join(name)
			keyword_str += name[1:] + "/ "
			continue
		keyword_str += keyword['value'] + "/ "
	txt_file.write(keyword_str[:-2])
	txt_file.write("\n")	

txt_file.close()