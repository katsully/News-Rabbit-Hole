from TwitterSearch import *

file_keywords = open("keywords.txt")
file_keys = open("API_keys/twitter_oauth.txt")
new_keywords = []

for line in file_keywords:
    new_keywords.append(line.rstrip())

# get all keys
keys = file_keys.read()
keys_decoded = keys.decode("utf-8-sig")
keys = keys_decoded.encode("utf-8")
keys = keys.rstrip().split('\n')

# assign keys for TwitterSearch



try:
    tso = TwitterSearchOrder() # create a TwitterSearchOrder object
    tso.set_keywords(new_keywords[-3:]) # our keyword goes here
    tso.set_language('en') # we want to see English tweets only
    tso.set_include_entities(False) # and don't give us all those entity information
    #tso.set_count(25) #Don't want to query 100 tweets

    # it's about time to create a TwitterSearch object with our secret tokens
    ts = TwitterSearch(
        consumer_key = keys[0],
        consumer_secret = keys[1],
        access_token = keys[2],
        access_token_secret = keys[3]
     )

    file_keys.close()

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