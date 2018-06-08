import processing.sound.*;

String[] linhas;
PImage img, azulejo;
int n, m, nBaralhar;
int largura, altura;
Menu menu;
Pedaco[][] pedacos;
SoundFile win, wrong, move, lose;
PFont f;
ArrayList <String> moveBaralhar;
ArrayList <String> moveJogador;

void setup() {
  size(600, 800);

  //CARREGAMENTOS
  linhas = loadStrings("texto.txt");
  img = loadImage(linhas[2]);
  azulejo = loadImage("azulejo.jpg");

  //VARIÁVEIS
  n = parseInt(linhas[0]); //8
  m = parseInt(linhas[1]); //6
  nBaralhar = parseInt(linhas[3]); //100
  largura = 600;
  altura = 800;
  f = createFont("Baskerville", 100, true);

  //OBJETOS
  menu = new Menu(Menu.MENU);
  pedacos = new Pedaco[n][m];
  win = new SoundFile(this, "win.mp3");
  lose = new SoundFile(this, "lose.mp3");
  move = new SoundFile(this, "move.mp3");
  wrong = new SoundFile(this, "wrong.mp3");
  moveBaralhar = new ArrayList();

  //Criação dos pedaços à exceção do último que é nulo, não existe
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
  println(moveBaralhar);
}


void draw() {

  //Dedinição do Menu Inicial (MENU)
  if (menu.selected == Menu.MENU) {
    azulejo.resize(600, 800);
    image(azulejo, 0, 0);

    noStroke();
    textFont(f, 90);

    fill(255);
    rect(0, 100, 500, 100);
    rect(300, 500, 302, 102);

    fill(#1C477E);
    text("15 PUZZLE", 15, 180);
    fill(#AA2013);
    text("PLAY", 337, 582);

    //Apresentar o menu do Puzzle (JOGO)
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

  //Clicar e iniciar o JOGO
  if (menu.selected == Menu.MENU) {
    if (mouseX>=300 && mouseX<=width && mouseY>=500 && mouseY<=600) {
      menu.selected = Menu.JOGO;
    }
  }

  //Mover as peças + Som do movimento Válido
  if (menu.selected == Menu.JOGO) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        if (pedacos[i][j] != null) {
          if (pedacos[i][j].pressed()) {
            if (i!=0) { 
              move.play();
              if (pedacos[i-1][j] == null) { //Subir peça
                pedacos[i-1][j] = pedacos[i][j];
                pedacos[i][j] = null;
                moveJogador.add("UP");
                return;
              }
            } 

            if (i!=n-1) {
              move.play();
              if (pedacos[i+1][j] == null) { //Descer peça
                pedacos[i+1][j] = pedacos[i][j];
                pedacos[i][j] = null;
                moveJogador.add("DOWN");
                return;
              }
            } 

            if (j!=0) {
              move.play();
              if (pedacos[i][j-1] == null) { //Mover para direita
                pedacos[i][j-1] = pedacos[i][j];
                pedacos[i][j] = null;
                moveJogador.add("RIGHT");
                return;
              }
            } 

            if (j!=m-1) {
              move.play();
              if (pedacos[i][j+1] == null) { //Mover para a esquerda
                pedacos[i][j+1] = pedacos[i][j];
                pedacos[i][j] = null;
                moveJogador.add("LEFT");
                return;
              }
            }

            //Som de movimento Inválido
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

  //Mover as peças 
  for (int z=0; z<nMovimentos; z++) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        int r = (int)random(0, 4);

        while ((r==0 && i==0) || (r==1 && i==n-1) || (r==2 && j==0) || (r==3 && j==m-1)) { //cantos
          r = (int)random(0, 4);
        }

        if (p[i][j] == null) {
          if (r==0) {
            p[i][j] = p[i-1][j]; //r=0 puxa de cima, peça de baixo do nulo sobe
            p[i-1][j] = null;
            moveBaralhar.add("UP");
          } else if (r==1) {
            p[i][j] = p[i+1][j]; //r=1 puxa de baixo, peça por cima do nulo desce
            p[i+1][j] = null;
            moveBaralhar.add("DOWN");
          } else if (r==2) {
            p[i][j] = p[i][j-1]; //r=2 puxa da esquerda, peça à esquerda do nulo anda para a direita
            p[i][j-1] = null;
            moveBaralhar.add("LEFT");
          } else if (r==3) {
            p[i][j] = p[i][j+1]; //r=3 puxa da direita, peça à direita do nulo anda para a esquerda
            p[i][j+1] = null;
            moveBaralhar.add("RIGHT");
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
