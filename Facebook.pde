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
    font = createFont("Arial Narrow", 20);
    String[] data = split(status, "`");
    for (int i=0; i<data.length; i++) {
      info[i] = data[i];
    }    
    loc = new PVector(20, location * 220 + 30);

    File file = new File(dataPath("image" + location + ".jpg"));

    if (file.exists()) {
      pic = loadImage("image" + location + ".jpg");
    }
  }


  void display() {
    fill(0);
    textFont(font);
    String status = "";
    for(int i=0; i<info.length; i++) {
      if(i != 1){
        status += info[i] + "\n";
      }
    }
    text(status, loc.x, loc.y, 400, 200);
    if (info[1].equals("yes")) {
      println(info[0]);
      image(pic, loc.x, loc.y+75);
    }
    // if (info[1]) {
    //   image(pic, loc.x, loc.y);
    //   text(status, loc.x, loc.y+pic.height);
    // } else {
    //   text(status, loc.x, loc.y);
    // }
  }
}
