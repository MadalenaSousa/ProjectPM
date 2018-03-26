String[] linhas;
int n, m;
PImage [][] pedacos = new PImage[n][m];
PImage img;

void setup() {
  size(600, 800);

  linhas =  loadStrings("texto.txt");

  n = parseInt(linhas[1]);
  m = parseInt(linhas[0]);

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      pedacos[i][j] = createImage(img.width/n, img.height/m, RGB);
      pedacos[i][j].loadPixels();
    }
  }

  img =  loadImage(linhas[2]);
  img.loadPixels();
}

void draw() {
  for (int x=0; x<n; x++) {
    for (int y=0; y<m; y++) {
      int loc = x + y * pedacos[n][m].width;
      pedacos[n][m].pixels[loc] = img.pixels[loc];
    }
  }

  image(img, 0, 0, 600, 800);
  stroke(0);
  image(pedacos[n][m], 0, 0);
}
