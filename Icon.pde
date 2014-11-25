class Icon{
  
  int x;
  int y;
  PImage logo;
  String title;
  
  Icon(int x, int y, PImage logo, String title){
    this.x = x;
    this.y = y;
    this.logo = logo;
    this.title = title;
  }
  
  void display(){
    image(logo,x,y);
  }
  
   
}
    
    
    
