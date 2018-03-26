int altura, largura;
String[] linhas;
int n, m;
PImage [][] pedacos;
PImage img;

void setup() {
  largura = 600;
  altura = 800;

  size(600, 800);

  linhas =  loadStrings("texto.txt");

  m = parseInt(linhas[0]); //8
  n = parseInt(linhas[1]); //6

  img =  loadImage(linhas[2]);
  img.loadPixels();

  pedacos = new PImage[n][m];

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      pedacos[i][j] = createImage(largura/n, altura/m, RGB);
      pedacos[i][j].loadPixels();
    }
  }
}

void draw() {

  image(img, 0, 0, largura, altura);

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {

      for (int x=0; x<pedacos[i][j].width; x++) {
        for (int y=0; y<pedacos[i][j].height; y++) {
          int loc = x + y * pedacos[i][j].width;

          color c = img.pixels[loc];

          float r = red(c);
          float g = green(c);
          float b = blue(c);

          pedacos[i][i].pixels[loc] = color(r, g, b);
        }
      }
      pedacos[i][j].updatePixels();
      image(pedacos[i][j], pedacos[i][j].width * j, pedacos[i][j].height * i);
    }
  }
}
