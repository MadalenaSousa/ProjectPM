class Pedaco {

  int alt, larg;
  PImage pedaco;

  Pedaco(int alt, int larg, PImage imgOriginal, float x, float y) {
    this.alt = alt;
    this.larg = larg;
    pedaco = createImage(larg, alt, RGB);
    imgOriginal.resize(600, 800);
    pedaco = imgOriginal.get((int)y*pedaco.width, (int)x*pedaco.height, pedaco.width, pedaco.height);

    //pedaco.save("pedacos" + count + ".jpg");
  }

  void desenha(float x, float y) {
    image(pedaco, (5 + pedaco.width) * y, (5 + pedaco.height) * x); //ele desenha cada pedaco a 5px * o indíce do pedaco anterior
  }
}
