class Tweet extends NewsBlur {

  String name = "";
  String handle = "";
  String message = "";
  String[] info = {name, handle, message};

  Tweet(String tweet, int location) {
    super();
    String[] data = split(tweet, "~");    
    for (int i=0; i<data.length; i++) {
      info[i] = data[i];      
    }   
    loc = new PVector(10, location * 75 + 30);
  }

  void display() {
    fill(255);
    textSize(20);
    String wholeTweet = info[0] + " @" + info[1] + "\n" + info[2];
    text(wholeTweet, loc.x, loc.y);
  }
}
