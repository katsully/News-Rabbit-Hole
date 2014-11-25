class Facebook extends NewsBlur {

  PFont font;   
  PImage pic;
  String name = "";
  String picture_str = "";
  String caption = "";
  String description = "";
  String link = "";
  String message = "";
  String[] info = {
    name, picture_str, link, message
  };

  Facebook(String status, int location) {
    super();
    font = createFont("Arial Narrow", 14);
    String[] data = split(status, "`");
    for (int i=0; i<data.length; i++) {
      info[i] = data[i];
    }    
    loc = new PVector(20, location * 170 + 30);
    
    File file = new File(dataPath("image" + location + ".jpg"));

    if (file.exists()) {
      pic = loadImage("image" + location + ".jpg");
    }
  }


  void display() {
    fill(0);
    textFont(font);
    String status = info[0] + "\n" + info[2] + "\n" + info[3];
    println(info[3]);    
    text(status, loc.x, loc.y, 800, 200);
    // if (info[1]) {
    //   image(pic, loc.x, loc.y);
    //   text(status, loc.x, loc.y+pic.height);
    // } else {
    //   text(status, loc.x, loc.y);
    // }    
  }
}
