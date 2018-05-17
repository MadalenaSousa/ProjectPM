class PedPreto extends Pedaco {
  color c;
  PImage black;
  
  PedPreto(int alt, int larg, PImage imgOriginal, float ix, float jy) {
    super(alt, larg, imgOriginal, ix, jy);
    c = color(0);
    black = createImage(larg, alt, RGB); 
  }
  
  void desenha() {
    image(black, x, y);
  }
}
