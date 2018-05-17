class Pedaco {

  int alt, larg;
  PImage pedaco;
  float x, y;

  Pedaco(int alt, int larg, PImage imgOriginal, float ix, float jy) {
    this.alt = alt;
    this.larg = larg;
    x = 0;
    y = 0;
    pedaco = createImage(larg, alt, RGB);
    imgOriginal.resize(600, 800);
    pedaco = imgOriginal.get((int)jy*pedaco.width, (int)ix*pedaco.height, pedaco.width, pedaco.height);

    //pedaco.save("pedacos" + count + ".jpg");
  }

  void desenha(float ix, float jy) {
    this.x = (5 + pedaco.width) * jy;
    this.y = (5 + pedaco.width) * ix;

    image(pedaco, x, y); //ele desenha cada pedaco a 5px * o indíce do pedaco anterior
  }

  boolean pressed() {
    if ((mouseX - x  <= pedaco.width && mouseX - x >= 0) && (mouseY - y <= pedaco.height && mouseY - y >= 0)) {
      return true;
    } else {
      return false;
    }
  }
}
