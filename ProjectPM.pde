Pedaco[][] pedacos;
int n, m;
int largura, altura;
String[] linhas;
int count;

void setup() {
  background(0);
  size(625, 835);

  largura = 600;
  altura = 800;
  count = 0;
  linhas = loadStrings("texto.txt");
  n = parseInt(linhas[0]);
  m = parseInt(linhas[1]);

  pedacos = new Pedaco[n][m];

  PImage img = loadImage("img.jpg");

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (i != (n-1) || j != (m-1)) {
        pedacos[i][j] = new Pedaco(altura/n, largura/m, img, i, j);
      } else {
        pedacos[i][j] = null;
      }
    }
  }
}

void draw() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (pedacos[i][j] != null) {
        pedacos[i][j].desenha(i, j);
      }
    }
  }
}

void mousePressed() {
  for (int i=0; i<n; i++) {
    for (int j=0; i<m; j++) {
      if (pedacos[i][j] != null) {
        if (pedacos[i][j].pressed()) {
          if (i!=0) {
            if (pedacos[i][j+1] == null) {
              pedacos[i][j+1] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }

          if (i!=n-1) {
            if (pedacos[i][j-1] == null) {
              pedacos[i][j-1] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }

          if (j!=0) {
            if (pedacos[i-1][j] == null) {
              pedacos[i-1][j] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }

          if (j!=m-1) {
            if (pedacos[i+1][j] == null) {
              pedacos[i+1][j] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }
        }
      }
    }
  }
}
