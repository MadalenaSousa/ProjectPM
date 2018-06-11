class Pedaco {

  int alt, larg;
  PImage pedaco;
  float x, y;
  int ident;

  Pedaco(int alt, int larg, PImage imgOriginal, float ix, float jy, int ident) { 
    this.alt = alt;
    this.larg = larg;
    x = 0;
    y = 0;
    this.ident = ident; // Numero de identificação
    pedaco = createImage(larg, alt, RGB);
    imgOriginal.resize(600, 800);
    pedaco = imgOriginal.get((int)jy*pedaco.width, (int)ix*pedaco.height, pedaco.width, pedaco.height); // Faz os pedacos a partir de uma imagem original
  }

  void desenha(float i, float j) { 
    this.x = (5 + pedaco.width) * j;
    this.y = (5 + pedaco.height) * i;
    imageMode(CORNER);
    image(pedaco, x, y); // Ele desenha cada pedaco a 5px * o indíce do pedaco anterior
  }

  
  // Verifica se o utilizador pressiona o rato dentro das margens da peça
  boolean pressed() {
    if ((mouseX - x  <= pedaco.width && mouseX - x >= 0) && (mouseY - y <= pedaco.height && mouseY - y >= 0)) {
      return true;
    } else {
      return false;
    }
  }
}
