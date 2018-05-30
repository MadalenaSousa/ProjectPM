import processing.sound.*;

Menu menu;
Pedaco[][] pedacos;
int n, m, nBaralhar;
int largura, altura;
String[] linhas;
int count;
SoundFile win, wrong, move, lose;
PFont f;
PImage azulejo;

void setup() {
  //size(800, 1000);
  size(600, 800);
  azulejo=loadImage("azulejo.jpg");
  f = createFont("Baskerville", 100, true);
  menu = new Menu(Menu.MENU);

  win = new SoundFile(this, "win.mp3");
  lose = new SoundFile(this, "lose.mp3");
  move = new SoundFile(this, "move.mp3");
  wrong = new SoundFile(this, "wrong.mp3");

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

  misturar(pedacos, nBaralhar);
}


void draw() {
  if (menu.selected == Menu.MENU) {
    azulejo.resize(600, 800);
    image(azulejo, 0, 0);
    fill(255);
    noStroke();
    rect(0, 100, 500, 100);
    rect(300, 500, 302, 102);
    textFont(f, 90);
    fill(#1C477E);
    text("15 PUZZLE", 15, 180);
    fill(#AA2013);
    text("PLAY", 337, 582);
  } else if (menu.selected == Menu.JOGO) {
    background(0);
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if (pedacos[i][j] != null) {
          pedacos[i][j].desenha(i, j);
        }
      }
    }
  }
}

void mousePressed() {
  if (menu.selected == Menu.MENU) {
    if (mouseX>=300 && mouseX<=width && mouseY>=500 && mouseY<=600) {
      menu.selected = Menu.JOGO;
    }
  }

  if (menu.selected == Menu.JOGO) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        if (pedacos[i][j] != null) {
          if (pedacos[i][j].pressed()) {
            if (i!=0) { //Mexer as peças + Som de mover
              move.play();
              if (pedacos[i-1][j] == null) {
                pedacos[i-1][j] = pedacos[i][j];
                pedacos[i][j] = null;
                return;
              }
            } 

            if (i!=n-1) {
              move.play();
              if (pedacos[i+1][j] == null) {
                pedacos[i+1][j] = pedacos[i][j];
                pedacos[i][j] = null;
                return;
              }
            } 

            if (j!=0) {
              move.play();
              if (pedacos[i][j-1] == null) {
                pedacos[i][j-1] = pedacos[i][j];
                pedacos[i][j] = null;
                return;
              }
            } 

            if (j!=m-1) {
              move.play();
              if (pedacos[i][j+1] == null) {
                pedacos[i][j+1] = pedacos[i][j];
                pedacos[i][j] = null;
                return;
              }
            }
            //Sons: Som errado
            if (i!=0 && i!=n-1 && j!=0 && j!=m-1) {
              if (pedacos[i+1][j] != null && pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i][j-1] != null) {
                wrong.play();
              }
            } else if (i==0) {
              if (j==0) {
                if (pedacos[i+1][j] != null && pedacos[i][j+1] != null) {
                  wrong.play();
                }
              } else if (j==m-1) {
                if (pedacos[i+1][j] != null && pedacos[i][j-1] != null) {
                  wrong.play();
                }
              } else {
                if (pedacos[i+1][j] !=null && pedacos[i][j+1] != null && pedacos[i][j-1] != null) {
                  wrong.play();
                }
              }
            } else if (i==n-1) {
              if (j==0) {
                if (pedacos[i-1][j] != null && pedacos[i][j+1] != null) {
                  wrong.play();
                }
              } else if (j==m-1) {
                if (pedacos[i-1][j] != null && pedacos[i][j-1] != null) {
                  wrong.play();
                }
              } else {
                if (pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i][j-1] != null) {
                  wrong.play();
                }
              }
            } else if (j==0) {
              if (pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i-1][j] != null) {
                wrong.play();
              }
            } else if (j==m-1) {
              if (pedacos[i-1][j] !=null && pedacos[i][j-1] != null && pedacos[i+1][j] != null) {
                wrong.play();
              }
            }
          }
        }
      }
    }
  }
}

void misturar(Pedaco[][] p, int nMovimentos) {

  for (int z=0; z<nMovimentos; z++) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        int r = (int)random(0, 4);

        while ((r==0 && i==0) || (r==1 && i==n-1) || (r==2 && j==0) || (r==3 && j==m-1)) {
          r = (int)random(0, 4);
        }

        if (p[i][j] == null) {
          if (r==0) {
            p[i][j] = p[i-1][j];
            p[i-1][j] = null;
          } else if (r==1) {
            p[i][j] = p[i+1][j];
            p[i+1][j] = null;
          } else if (r==2) {
            p[i][j] = p[i][j-1];
            p[i][j-1] = null;
          } else if (r==3) {
            p[i][j] = p[i][j+1];
            p[i][j+1] = null;
          }
        }
      }
    }
  }
}


/* 
 
 WEBGRAFIA
 https://www.openprocessing.org/sketch/131051
 
 */
