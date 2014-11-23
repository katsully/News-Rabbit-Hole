from TwitterSearch import *

file_keywords = open("keywords.txt")
new_keywords = []

for line in file_keywords:
    new_keywords.append(line.rstrip())

try:
    tso = TwitterSearchOrder() # create a TwitterSearchOrder object
    tso.set_keywords(new_keywords[:2]) # our keyword goes here
    tso.set_language('en') # we want to see English tweets only
    tso.set_include_entities(False) # and don't give us all those entity information
    #tso.set_count(25) #Don't want to query 100 tweets

    # it's about time to create a TwitterSearch object with our secret tokens
    ts = TwitterSearch(
        consumer_key = '7Uifmz2gkHF8RcOcMtItTJRoF',
        consumer_secret = 'YmcL95Yy15zvwAfGVaCrbGaUkcWo6wv0OT9RXCOxWfoHwuY1RT',
        access_token = '382795211-QdEIUrwt5d30XSNbbVOqhr7pcC7UvUr96xWJNqe2',
        access_token_secret = 'O0NQuaQPJo715naBUf5RVQKUfpFTiIyr1KmLSqE6CYQSS'
     )

    txt_file = open("data/tweets.txt", "w")

    for i,tweet in enumerate(ts.search_tweets_iterable(tso)):
        tweet_str = ""
        tweet_str += tweet['user']['name'].encode('utf-8') + "~"
        tweet_str += tweet['user']['screen_name'].encode('utf-8') + "~"
        tweet_str += tweet['text'].encode('utf-8') + "~"
        txt_file.write(tweet_str[:-1] + "\n")
        if i == 15: break

    txt_file.close()

     # this is where the fun actually starts :)
    # for tweet in ts.search_tweets_iterable(tso):
    #     tweet_str = '@%s tweeted: %s' % ( tweet['user']['screen_name'], tweet['text'] )
    #     print tweet_str.encode('utf-8')

except TwitterSearchException as e: # take care of all those ugly errors if there are some
    print(e)