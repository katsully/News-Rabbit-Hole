import tweepy

file_keywords = open("keywords.txt")
new_keywords = []

for line in file_keywords:
    new_keywords.append(line.rstrip())

consumer_key = '7Uifmz2gkHF8RcOcMtItTJRoF'
consumer_secret = 'YmcL95Yy15zvwAfGVaCrbGaUkcWo6wv0OT9RXCOxWfoHwuY1RT'
access_token = '382795211-QdEIUrwt5d30XSNbbVOqhr7pcC7UvUr96xWJNqe2'
access_token_secret = 'O0NQuaQPJo715naBUf5RVQKUfpFTiIyr1KmLSqE6CYQSS'
auth = tweepy.OAuthHandler( consumer_key,
	consumer_secret)
auth.set_access_token(
	access_token,
	access_token_secret)
api = tweepy.API(auth)

txt_file = open("data/buzzfeed.txt", "w")

for tweet in tweepy.Cursor(api.user_timeline, screen_name="buzzfeed", exclude_replies=True, include_rts=False).items(100):
	headline = tweet.text.encode('utf-8')
	print headline
	if new_keywords[:1][0] in headline: txt_file.write(headline + "\n")	

txt_file.close()

