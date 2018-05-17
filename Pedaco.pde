class Pedacos {

  int altura, largura;
  int n, m;
  PImage [][] pedacos;
  PImage img;

  Pedacos(int altura, int largura, int n, int m, PImage img) {
    this.altura = altura;
    this.largura = largura;
    this.n = n;
    this.m = m;
    this.img = img;
    
    //criação dos pedacos
    pedacos = new PImage[n][m];
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        pedacos[i][j] = createImage(largura/m, altura/n, RGB);
      }
    }
  }

  void desenha() {
    img.loadPixels();
    img.resize(800, 450);

    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        pedacos[i][j].loadPixels();

        //definição da imagem
        pedacos[i][j] = img.get(j*pedacos[i][j].width, i*pedacos[i][j].height, pedacos[i][j].width, pedacos[i][j].height);

        //display das novas imagens criadas, exceto a ultima
        if (i != (n-1) || j != (m-1)) {
          pedacos[i][j].updatePixels();
          image(pedacos[i][j], 5 * j + pedacos[i][j].width * j, 5 * i + pedacos[i][j].height * i); //ele desenha cada pedaco a 5px * o indíce do pedaco anterior
          //pedacos[i][j].save("pedacos" + count + ".jpg");
        }
      }
    }
  }
}
