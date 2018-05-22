Pedaco[][] pedacos;
int n, m, nBaralhar;
int largura, altura;
String[] linhas;
int count;

void setup() {
  //size(800, 1000);
  size(625, 835);

  largura = 600;
  altura = 800;
  count = 0;
  linhas = loadStrings("texto.txt");
  n = parseInt(linhas[0]); //8
  m = parseInt(linhas[1]); //6
  nBaralhar = parseInt(linhas[3]); //10

  pedacos = new Pedaco[n][m];

  PImage img = loadImage(linhas[2]);

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (i != (n-1) || j != (m-1)) {
        pedacos[i][j] = new Pedaco(altura/n, largura/m, img, i, j);
      } else {
        pedacos[i][j] = null;
      }
    }
  }

  for (int i=0; i<n /*8*/; i++) {
    for (int j=0; j<m/*6*/; j++) {
      misturar(pedacos, img);
    }
  }
}


void draw() {
  background(0);
  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (pedacos[i][j] != null) {
        pedacos[i][j].desenha(i, j);
      }
    }
  }
}

void mousePressed() {
  for (int i=0; i<n /*8*/; i++) {
    for (int j=0; j<m/*6*/; j++) {
      if (pedacos[i][j] != null) {
        if (pedacos[i][j].pressed()) {
          if (i!=0) {
            if (pedacos[i-1][j] == null) {
              pedacos[i-1][j] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }

          if (i!=n-1) {
            if (pedacos[i+1][j] == null) {
              pedacos[i+1][j] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }

          if (j!=0) {
            if (pedacos[i][j-1] == null) {
              pedacos[i][j-1] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }

          if (j!=m-1) {
            if (pedacos[i][j+1] == null) {
              pedacos[i][j+1] = pedacos[i][j];
              pedacos[i][j] = null;
              return;
            }
          }
        }
      }
    }
  }
}

void misturar(Pedaco[][] p, PImage img) {
  Pedaco pp;

  for (int z=0; z<10; z++) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        
        pp = new Pedaco(altura/n, largura/m, img, i, j);
        int r = (int)random(0, 4);
        
        if (r==0 && i!=0) {
          pp = p[i-1][j];
        } else if (r==1 && i!=n-1) {
          pp = p[i+1][j];
        } else if (r==2 && j!=0) {
          pp = p[i][j-1];
        } else if (r==3 && j!=m-1) {
          pp = p[i][j+1];
        }

        if (p[i][j] == null) {
          Pedaco temp = p[i][j];
          p[i][j] = pp;
          pp = temp;
        }
      }
    }
  }
}

/* 
 
 WEBGRAFIA
 http://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html
 https://rosettacode.org/wiki/15_Puzzle_Game#Java
 https://www.openprocessing.org/sketch/131051
 
 */
