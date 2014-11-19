import urllib
import urllib2
import json

url = "http://{api_key}@code.huffingtonpost.com/api/v0"
headers = { "Authorization" : "Bearer e410aaa5bf"}
req = urllib2.Request(url, None, headers)
response = urllib2.urlopen(req)

data = json.load(response)