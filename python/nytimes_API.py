from nytimesarticle import articleAPI
import datetime

date = datetime.datetime.now()
date_str = date.strftime('%Y%m%d')

api = articleAPI('8507eaad79faa9ac49204db270a8e0e3:13:70195569')

articles = api.search(fq = {'news_desk':'National', 'source':['Reuters','AP', 'The New York Times']}, begin_date = date_str, facet_field = ['source','day_of_week'], facet_filter = True)
all_articles = articles['response']['docs']

txt_file = open("data/nytimes.txt", "w")

for stuff in all_articles:
	keyword_str = ""
	txt_file.write(stuff['headline']['main'].encode('utf-8') + "\n")
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