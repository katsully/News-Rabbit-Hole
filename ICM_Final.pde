//////////////////////////////////////
// By: Kat Sullivan
//////////////////////////////////////
import java.util.Collections;

String[] textFile;
ArrayList<NYTime> nyTimes = new ArrayList<NYTime>();
ArrayList<Tweet> tweets = new ArrayList<Tweet>();
ArrayList<Facebook> fbs = new ArrayList<Facebook>();
ArrayList<? extends NewsBlur> currentObjs;
int counter;
boolean twitter = false;
boolean nytimesCurr, endOfNews;

void setup() {
  open(new String[] {
    "cmd", "/c", "C:/Projects/ITP/ICM_Final/nytimes.bat"
  }
  );
  delay(1000);
  textFile = loadStrings("nytimes.txt");
  for (int i=0; i<textFile.length; i+=2) {
    nyTimes.add(new NYTime(textFile[i], textFile[i+1], i));
  }
  size(displayWidth, displayHeight);
  background(255);  
  currentObjs = nyTimes;
  nytimesCurr = true;
  counter = nyTimes.size();
  endOfNews = false;
}

void draw() {
  if (nytimesCurr) {
    text("Pick a Story", 450, 50);
  }
  if (currentObjs.size() != 0) {
    for (int i=0; i<counter; i++) {
      currentObjs.get(i).display();
    }
    if (!nytimesCurr) {
      if (frameCount % 60 == 0 && counter < currentObjs.size()) { 
        counter++;
      } else if (currentObjs.size() == counter) {
        endOfNews = true;
      }
    }
  }
  if (endOfNews) {
    open(new String[] {
      "cmd", "/c", "start", "/w", "C:/Projects/ITP/ICM_Final/facebook.bat"
    }
    );
    textFile = loadStrings("facebook.txt");
    for (int i=0; i<textFile.length; i++) {
      fbs.add(new Facebook(textFile[i], i));
    }
    counter = 1;
    currentObjs = fbs;    
    endOfNews = false;
    background(204);
  }
}

void keyPressed() {
  if (key == 't') {
    twitter = true;
    open("twitter.bat");
  }
}

void mouseClicked() {
  for (NYTime nyTime: nyTimes) {
    // RUN ALL BATCH FILES
    if (nyTime.mouseOver(mouseX, mouseY)) {
      try {
        saveStrings("keywords.txt", nyTime.keywords);
        Process p = Runtime.getRuntime().exec("cmd /c C:/Projects/ITP/ICM_Final/twitter.bat"
          );
        p.waitFor();        
      } 
      catch (Exception err) {
        err.printStackTrace();
      }

      textFile = loadStrings("tweets.txt");
      for (int i=0; i<textFile.length-1; i++) {
        tweets.add(new Tweet(textFile[i], i));
      }
      counter = 1;
      background(64, 153, 255);
      currentObjs = tweets;
      nytimesCurr = false;  
      break;
    }
  }
}
