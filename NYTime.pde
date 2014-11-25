class NYTime extends NewsBlur {

  String headline;
  String[] keywords;
  String leadParagraph;
  String author;
  PFont headlineFont;
  PFont articleFont;

  NYTime(String headline, String keywords, int location) {
    super();
    headlineFont = createFont("Georgia Italic", 34);
    articleFont = createFont("Georgia Italic", 22);
    String headers[] = split(headline, "`");
    this.headline = headers[0];
    this.leadParagraph = headers[1];
    this.keywords = split(keywords, "/ ");   
    for (int i=0; i<this.keywords.length; i++) {
      if (this.keywords[i].contains("Police Brutality")) {
        this.keywords[i] = "Police Brutality";
      }
      if (this.keywords[i].contains("and")) {
        this.keywords[i] = this.keywords[i].split(" ")[0];
      }
      if (this.keywords[i].contains("(")) {
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
    textFont(headlineFont);
    fill(0);
    text(headline, loc.x, loc.y, displayWidth/2-40, 100);
  }
  
  void fulldisplay(){
    textFont(headlineFont);
    fill(0);
    text(headline, 20, 20, displayWidth-40, 100);
    textSize(11);
    stroke(100);
    line(20, 140, displayWidth-40, 140);
    //text(author, 20, 160);
    textFont(articleFont);
    text(leadParagraph, 100, 180, displayWidth/2, 300);
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
