import newspaper

trends =  newspaper.hot()

#print [x.encode('utf-8') for x in trends]

file = open("data/trends.txt", "w")

for trend in trends:
	file.write(trend.encode('utf-8') + "\n")

file.close()