import facebook 
import json
import sys
import urllib

reload(sys)
sys.setdefaultencoding("utf-8")

file_keywords = open("keywords.txt")
new_keywords = []

for line in file_keywords:
    new_keywords.append(line.rstrip())

token = 'CAACEdEose0cBAJ8izKvkQOe3rUgFEOCH9NAS8RQbsmOSr8QQNJDOcxxAgi0TzEBcwCdSjcRsU28rrHULjZBt04w74PhPUWlgdiKGpzZAgyhhXxQzORQitWv8ljREODhApEhuOKEiLW6a0C8tlqbF3upV1zO6h0dlzhDSZCl94sHXhs3A6ikDIRLAiJezSwSxB5k5TKpvQ4c6sdidt6J'

# Create a connection to the Graph API with your access token
graph = facebook.GraphAPI(token)
txt_file = open("data/facebook.txt", "w")

json_data = graph.request("search", {'q': new_keywords[:1], 'type': 'post', 'from': 'User'})

nums = range(1,100)

for i,post in enumerate(json_data['data']):
	status_str = ""
	status_str += post['from']['name'] + "~"
	if 'picture' in post: 
		pic_file = open("data/image%i.jpg" %i, 'wb')
		pic_file.write(urllib.urlopen(post['picture']).read())
		pic_file.close()
	if 'caption' in post: status_str += post['caption'] + "~"
	if 'description' in post: status_str += post['description'] + "~"
	if 'link' in post: status_str += post['link'] + "~"
	if 'message' in post: status_str += post['message'] + "~"
	txt_file.write(status_str[:-1] + "\n")

txt_file.close()