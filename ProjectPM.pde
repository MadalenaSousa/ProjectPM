String[] linhas;
int n, m;
PImage [][] pedacos;
PImage img;

void setup() {
  size(600, 800);

  linhas =  loadStrings("texto.txt");

  m = parseInt(linhas[0]); //8
  n = parseInt(linhas[1]); //6

  img =  loadImage(linhas[2]);
  img.loadPixels();

  pedacos = new PImage[m][n];

  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {
      pedacos[i][j] = createImage(img.width/n, img.height/m, RGB);
      pedacos[i][j].loadPixels();
    }
  }
}

void draw() {

  image(img, 0, 0, 600, 800);

  for (int x=0; x<m; x++) {
    for (int y=0; y<n; y++) {
      int loc = x + y * pedacos[x][y].width;
      pedacos[x][y].pixels[loc] = img.pixels[loc];
      stroke(0);
      image(pedacos[x][y], 0, 0);
    }
  }
}
