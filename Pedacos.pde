class Pedacos {

  int altura, largura;
  int n, m;
  float[] x, y;
  PImage [][] pedacos;
  PImage img;

  Pedacos(int altura, int largura, int n /*8*/, int m/*6*/, PImage img) {
    this.altura = altura;
    this.largura = largura;
    this.n = n;
    this.m = m;
    this.img = img;
    //criação dos pedacos
    x = new float[m];
    y = new float[n];
    pedacos = new PImage[n][m];
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        pedacos[i][j] = createImage(largura/m, altura/n, RGB);
        x[j] = 5 * j + pedacos[i][j].width * j;
        y[i] = 5 * i + pedacos[i][j].height * i;
      }
    }
  }

  void desenha() {
    img.loadPixels();
    img.resize(600, 800);

    for (int i=0; i<n/*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        pedacos[i][j].loadPixels();

        /* 
         for (int l=0; l < pedacos[i][j].height; l++) {
         for (int c=0; c < pedacos[i][j].width; c++) {
         int loc = (l * pedacos[i][j].width) + c;
         int loc_original = ((j * pedacos[i][j].width) + c) + ((i * pedacos[i][j].height * img.width) + (l * img.width));
         pedacos[i][j].pixels[loc] = img.pixels[loc_original];
         }
         }
         */

        //definição da imagem
        pedacos[i][j] = img.get(j*pedacos[i][j].width, i*pedacos[i][j].height, pedacos[i][j].width, pedacos[i][j].height);

        //display das novas imagens criadas, exceto a ultima
        if (i != (n-1) || j != (m-1)) {
          pedacos[i][j].updatePixels();
          image(pedacos[i][j], x[j], y[i]); //ele desenha cada pedaco a 5px * o indíce do pedaco anterior
        }
        //pedacos[i][j].save("pedacos" + count + ".jpg");
      }
    }
  }

  void mover() {
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if ((mouseX - x[j] <= pedacos[i][j].width && mouseX - x[j] >= 0) && (mouseY - y[i] <= pedacos[i][j].height && mouseY - y[i] >= 0)) {
          println(x[j]);
          println(pedacos[i][j].pixels[0]);
        }
      }
    }
  }
}
