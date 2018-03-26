String[] linhas;
int n, m;
PImage [][] pedacos = new PImage[m][n];
PImage img;

void setup() {
  size(600, 800);

  linhas =  loadStrings("texto.txt");
  
  m = parseInt(linhas[0]); //8
  n = parseInt(linhas[1]); //6

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
  
  image(img, 0, 0, 600, 800);
  
  for (int x=0; x<n; x++) {
    for (int y=0; y<m; y++) {
      int loc = x + y * pedacos[x][y].width;
      pedacos[x][y].pixels[loc] = img.pixels[loc];
      stroke(0);
      image(pedacos[x][y], 0, 0);
    }
  }
}
