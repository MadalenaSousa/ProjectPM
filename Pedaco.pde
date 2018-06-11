class Pedaco {

  int alt, larg;
  PImage pedaco;
  float x, y;
  int ident;

  Pedaco(int alt, int larg, PImage imgOriginal, float ix, float jy, int ident) { //enviados no construtor para poder pôr as peças no lugar logo no início
    this.alt = alt;
    this.larg = larg;
    x = 0;
    y = 0;
    this.ident = ident;
    pedaco = createImage(larg, alt, RGB);
    imgOriginal.resize(600, 800);
    pedaco = imgOriginal.get((int)jy*pedaco.width, (int)ix*pedaco.height, pedaco.width, pedaco.height);
  }

  void desenha(float i, float j) { //enviar como argumento para eles poderem ser atualizados
    this.x = (5 + pedaco.width) * j;
    this.y = (5 + pedaco.height) * i;
    imageMode(CORNER);
    image(pedaco, x, y); //ele desenha cada pedaco a 5px * o indíce do pedaco anterior
  }

  
  //Verifica se o utilizador pressiona o rato dentro das margens da peça
  boolean pressed() {
    if ((mouseX - x  <= pedaco.width && mouseX - x >= 0) && (mouseY - y <= pedaco.height && mouseY - y >= 0)) {
      return true;
    } else {
      return false;
    }
  }
}
