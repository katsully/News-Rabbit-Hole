//////////////////////////////////////
// By: Kat Sullivan
//////////////////////////////////////
import java.util.Collections;

String[] textFile;
PImage nytimesHeading, facebook, twitter;
ArrayList<NYTime> nyTimes = new ArrayList<NYTime>();
ArrayList<Tweet> tweets = new ArrayList<Tweet>();
ArrayList<Facebook> fbs = new ArrayList<Facebook>();
ArrayList<? extends NewsBlur> currentObjs;
int counter;
boolean nytimesCurr, pickSource, endOfNews;
ArrayList<PImage> icons = new ArrayList<PImage>();

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
  pickSource = false;
  counter = nyTimes.size();
  endOfNews = false;
  nytimesHeading = loadImage("nytimes_script.PNG");
  facebook = loadImage("facebook.jpg");
  icons.add(facebook);
  twitter = loadImage("twitter.jpg");
  icons.add(twitter);
}

void draw() {
  if (pickSource) {
    sourceScreen();
    selectSource();
  } else {
    if (nytimesCurr) {
      background(255);
      image(nytimesHeading, 450, 25);
      boxOver();
    } 
    if (!pickSource && currentObjs.size() != 0) {
      if (!nytimesCurr) {    
        background(64, 153, 255);
      }
      for (int i=0; i<counter; i++) {
        currentObjs.get(i).display();
      }
      if (!nytimesCurr) {
        if (frameCount % 60 == 0 && counter < currentObjs.size()) { 
          counter++;
        } else if (currentObjs.size() == counter) {
          endOfNews = true;
          drawBoxes();
        }
      }
    }
  }
}

void mouseClicked() {
  println("end of news: " + endOfNews); 
  if (nytimesCurr) {
    for (NYTime nyTime: nyTimes) {
      if (nyTime.mouseOver(mouseX, mouseY)) {
        saveStrings("keywords.txt", nyTime.keywords);      
        nytimesCurr = false;  
        pickSource = true;
        background(255);
        break;
      }
    }
  } else if (endOfNews) {
    if (mouseX >= 20 && mouseX <= 420 && mouseY >= 600 && mouseY <= 700) {
      pickSource = true;
      background(255);
    } else if(mouseX >=450 && mouseX <= 850 && mouseY >= 600 & mouseY <= 700){
      nytimesCurr = true;
      background(255);
      currentObjs = nyTimes;
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

void twitter() {
  try {
    Process p = Runtime.getRuntime().exec("cmd /c C:/Projects/ITP/ICM_Final/twitter.bat"
      );
    println("called it");
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
  println("total tweets: " + tweets.size());
  counter = 1;
  background(64, 153, 255);
  currentObjs = tweets;
}

void facebook() {
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


// Display the screen where a user selects a source
void sourceScreen() {
  text("Pick a Source", 100, 50);
  image(facebook, 20, 100);
  image(twitter, 20+facebook.width, 100);
}

// User selects a source()
void selectSource() {
  for (PImage icon : icons) {
    if (mouseX >= 20+facebook.width && mouseX <= 20+facebook.width+icon.width && mouseY >= 100 && mouseY <= 100+icon.height) {
      if (icon.equals(twitter)) {
        pickSource = false;
        twitter();        
        break;
      }
    }
  }
}

void drawBoxes() {
  fill(155, 89, 187);
  noStroke();
  rect(20, 600, 400, 100);
  rect(450, 600, 400, 100);
  fill(255);
  textSize(50);
  text("Pick New Source", 30, 675);
  text("Pick New Story", 480, 675);
}
