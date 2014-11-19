class Trend extends NewsBlur{

  String text;
  int textSize;
  color c;

  Trend(String text, int size) {
    super();
    this.text = text;
    textSize = 100 - (size*5);
    if (size%2 == 0) {
      if (size%4 == 0) {
        c = color(51, 105, 232);
      } else {
        c = color(213, 15, 37);
      }
    } else {
      if (size%3 == 0) {
        c = color(238, 178, 17);
      } else {
        c = color(0, 153, 37);
      }
    }
  }

  void display() {
    fill(c);
    textSize(textSize);
    text(text, loc.x, loc.y);
  }
}
