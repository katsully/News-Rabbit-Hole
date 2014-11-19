import newspaper
import nltk
import sys

reload(sys)
sys.setdefaultencoding("utf-8")

file_keywords = open("keywords.txt")
#print file_keywords.read()
#file_keywords.read()

new_keywords = []

for line in file_keywords:
	new_keywords.append(line.rstrip())

cnn_paper = newspaper.build('http://cnn.com', memoize_articles=False)

no_good = ["RidicuList", "blogs"]

txt_file = open("data/cnn.txt", "w")

for article in cnn_paper.articles[0:30]:
    article.download()
    article.parse()
    #article.nlp()
    title = article.title.encode('utf-8')
    print title
    if any(x in title for x in no_good): continue
    if any(x in title for x in new_keywords): 
    	txt_file.write(article.title)
    	break
    # print title
    # set_keywords = set(article.keywords)
    # set_new_keywords = set(new_keywords)
    # if set_keywords.intersection(set_new_keywords) ==  set([]):continue
    #ite(title)
    #break
    #print title.encode('utf-8')

txt_file.close()
