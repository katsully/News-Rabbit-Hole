class NYTime extends NewsBlur {

  String headline;
  String[] keywords;
  PFont font;

  NYTime(String headline, String keywords, int location) {
    super();
    font = loadFont("Georgia-Italic-34.vlw");
    this.headline = headline;
    this.keywords = split(keywords, "/ ");   
    for (int i=0; i<this.keywords.length; i++) {
      if (this.keywords[i].contains("Police Brutality")) {
        this.keywords[i] = "Police Brutality";
      }
      if(this.keywords[i].contains("and")){
        this.keywords[i] = this.keywords[i].split(" ")[0];
      }
    }
    if (location%4==0) {
      loc.x = displayWidth/2;
      loc.y = (location-2) * 30 + 170;
    } else {
      loc.x = 10;
      loc.y = location * 30 + 50;
    }
  }

  void display() {
    textFont(font, 34);
    fill(0);
    text(headline, loc.x, loc.y, displayWidth/2-40, 100);
  }

  boolean mouseOver(int mousex, int mousey) {
    if ((loc.x == 10 && mousex < displayWidth/2) || (loc.x == displayWidth/2 && mousex > displayWidth/2)) {
      if (loc.y < mousey && mousey < (loc.y + 100)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
