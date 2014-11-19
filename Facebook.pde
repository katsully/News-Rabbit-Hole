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
    name, caption, description, link, message
  };

  Facebook(String status, int location) {
    super();
    font = loadFont("ArialNarrow-14.vlw");
    String[] data = split(status, "~");
    for (int i=0; i<data.length; i++) {
      info[i] = data[i];
    }    
    loc = new PVector(20, location * 120 + 30);
    // println(info[1]);
    // if (info[1].contains(".jpg")) {
    //   pic = loadImage(info[1]);
    // }
    File file = new File(dataPath("image" + location + ".jpg"));

    if (file.exists()) {
      pic = loadImage("image" + location + ".jpg");
    }
  }


  void display() {
    //textFont(font, 14);
    fill(0);
    String status = info[0] + "\n" + info[1] + "\n" + info[2] + "\n" + info[3] + "\n" + info[4];
    if (pic != null) {
      image(pic, loc.x, loc.y);
      text(status, loc.x, loc.y+pic.height);
    } else {
      text(status, loc.x, loc.y);
    }    
  }
}
