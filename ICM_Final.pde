//////////////////////////////////////
// By: Kat Sullivan
//////////////////////////////////////
import java.util.Collections;

String[] textFile;
PImage nytimesHeading;
ArrayList<NYTime> nyTimes = new ArrayList<NYTime>();
ArrayList<Tweet> tweets = new ArrayList<Tweet>();
ArrayList<Facebook> fbs = new ArrayList<Facebook>();
ArrayList<? extends NewsBlur> currentObjs;
int counter;
boolean twitter = false;
boolean nytimesCurr, endOfNews;

void setup() {
  try {
    Process p = Runtime.getRuntime().exec("cmd /c C:/Projects/ITP/ICM_Final/nytimes.bat"    
      );
    p.waitFor();
  } 
  catch (Exception err) {
    err.printStackTrace();
  }

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
  nytimesHeading = loadImage("nytimes_script.PNG");
}

void draw() {
  if (nytimesCurr) {
    background(255);
    image(nytimesHeading, 450, 25);
    boxOver();
  }
  if (currentObjs.size() != 0) {
    
    for (int i=0; i<counter; i++) {
      currentObjs.get(i).display();
    }
    if (!nytimesCurr) {
      if (frameCount % 60 == 0 && counter < currentObjs.size()) { 
        println(counter);
        counter++;
      } else if (currentObjs.size() == counter) {
        endOfNews = true;
      }
    }
  }
  if (endOfNews) {
    try {
      Process p = Runtime.getRuntime().exec("cmd /c C:/Projects/ITP/ICM_Final/facebook.bat"    
        );
      p.waitFor();
    } 
    catch (Exception err) {
      err.printStackTrace();
    }
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
      int totalTweets = 12;
      if (textFile.length-1 < 12) {
        totalTweets = textFile.length-1;
      }
      int tweetCount = 0;
      for (int i=0; i<totalTweets; i++) {
        if (textFile[i].equals("")) {
          continue;
        } 
        if (!textFile[i].contains("~")) {
          continue;
        }
        tweets.add(new Tweet(textFile[i], tweetCount));
        tweetCount++;
      }
      counter = 1;
      background(64, 153, 255);
      currentObjs = tweets;
      nytimesCurr = false;  
      println("Twitter counter: " + counter);
      println(currentObjs.size());
      break;
    }
  }
}

void boxOver() {
  for (NYTime nyTime : nyTimes) {
    if (nyTime.mouseOver(mouseX, mouseY)) {
      fill(255, 0, 0, 100);
      noStroke();
      rect(nyTime.loc.x, nyTime.loc.y, displayWidth/2-40, 100);
      break;
    }
  }
}
