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

  img = loadImage(linhas[2]);
  img.loadPixels();
  img.resize(600,800);

  pedacos = new PImage[m][n];

  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {
      pedacos[i][j] = createImage(altura/m, largura/n, RGB);
      pedacos[i][j].loadPixels();
    }
  }
}

void draw() {

  //image(img, 0, 0, largura, altura);

  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {

      for (int l=0; l < pedacos[i][j].height; l++) {
        for (int c=0; c < pedacos[i][j].width; c++) {
          int loc = (l * pedacos[i][j].width) + c;
          int loc_original = ((j * pedacos[i][j].width) + c) + ((i * pedacos[i][j].height * img.width) + (l * img.width));
          pedacos[i][j].pixels[loc] = img.pixels[loc_original];
        }
      }

      noFill();
      stroke(0);
      strokeWeight(10);
      rect(pedacos[i][j].width * j, pedacos[i][j].height * i, pedacos[i][j].width, pedacos[i][j].height);
      pedacos[i][j].updatePixels();
      image(pedacos[i][j], pedacos[i][j].width * j, pedacos[i][j].height * i);
      //pedacos[i][j].save("pedacos" + i + j + ".jpg");
    }
  }
}
