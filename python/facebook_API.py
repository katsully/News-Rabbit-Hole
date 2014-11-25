import facebook 
import json
import sys
import urllib

reload(sys)
sys.setdefaultencoding("utf-8")

file_keywords = open("data/keywords.txt")
new_keywords = []

for line in file_keywords:
    new_keywords.append(line.rstrip())
file_key = open("API_keys/facebook_key.txt")

token = file_key.readline()

file_key.close()

# Create a connection to the Graph API with your access token
graph = facebook.GraphAPI(token)
txt_file = open("data/facebook.txt", "w")

json_data = graph.request("search", {'q': new_keywords[:2], 'type': 'post', 'from': 'User'})

nums = range(1,100)

for i,post in enumerate(json_data['data']):
	status_str = ""
	status_str += post['from']['name'] + "`"
	if 'picture' in post:
		status_str += 'yes' + '`'
		pic_file = open("data/image%i.jpg" %i, 'wb')
		pic_file.write(urllib.urlopen(post['picture']).read())
		pic_file.close()
	else:
		status_str += 'no' + '`'
	#if 'caption' in post: status_str += post['caption'] + "~"
	#if 'description' in post: status_str += post['description'] + "~"
	if 'link' in post: 
		status_str += post['link'] + "`"
	else: 
		status_str += " `"
	if 'message' in post and len(post['message']) < 300: status_str += post['message']
	txt_file.write(status_str + "\n")
	if i==10: break

txt_file.close()