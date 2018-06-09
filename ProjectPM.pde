import processing.sound.*;

String[] linhas;
PImage img, azulejo;
int n, m, nBaralhar;
int largura, altura;
Status status;
Principal principal; 
Ganhou ganhou; 
Perdeu perdeu;
Pedaco[][] pedacos;
SoundFile win, wrong, move, lose;
PFont f;
ArrayList <String> moveBaralhar;
ArrayList <String> moveJogador;
boolean noSitio;
float x, y;

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
  status = new Status(Status.MENU);
  pedacos = new Pedaco[n][m];
  win = new SoundFile(this, "win.mp3");
  lose = new SoundFile(this, "lose.mp3");
  move = new SoundFile(this, "move.mp3");
  wrong = new SoundFile(this, "wrong.mp3");
  moveBaralhar = new ArrayList();
  moveJogador = new ArrayList();
  principal = new Principal(azulejo, "15 PUZZLE", "JOGAR");
  ganhou = new Ganhou(azulejo, "GANHOU", "Jogar Novamente", win);
  perdeu = new Perdeu(azulejo, "PERDEU", "Jogar Novamente", lose);

  //Criação dos pedaços à exceção do último que é nulo, não existe, atribuindo um numero de identificação a cada pedaco
  int nIdentificacao = 0;
  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (i != (n-1) || j != (m-1)) {
        pedacos[i][j] = new Pedaco(altura/n, largura/m, img, i, j, nIdentificacao);
        nIdentificacao++;
      } else {
        pedacos[i][j] = null;
      }
    }
  }

  misturar(pedacos, nBaralhar);
}


void draw() {
  //Definição do Menu Inicial (MENU)
  if (status.selected == Status.MENU) {
    principal.desenha();

    //Apresentar o menu do Puzzle (JOGO)
  } else if (status.selected == Status.JOGO) {
    background(0);

    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if (pedacos[i][j] != null) {
          pedacos[i][j].desenha(i, j);
        }
      }
    }

    if (vitoria(pedacos)) {
      ganhou.viraFalse();
      status.selected = Status.GANHOU;
    }

    //Definição do menu PERDEU
  } else if (status.selected == Status.PERDEU) {
    perdeu.desenha();
    perdeu.tocou();
    println("A Solution: "+ "Move the Black Piece " + moveBaralhar); //Este print ainda não está bem, está a imprimir continuamente. Ainda tem de ser posto na classe

    //Definição do menu GANHOU
  } else if (status.selected == Status.GANHOU) {
    ganhou.desenha();
    ganhou.tocou();
  }

  //Limitar jogadas (Mensagem) 
  if (moveJogador.size() > nBaralhar * 2) {
    println("Esgotou o Número de Jogadas");
  }
}

void mousePressed() {
  //Clicar e iniciar o JOGO
  if (status.selected == Status.MENU) {
    if (mouseX>=100 && mouseX<=500 && mouseY>=400 && mouseY<=500) {
      status.selected = Status.JOGO;
    }
  }

  //Mover as peças + Som do movimento Válido
  if (status.selected == Status.JOGO) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        if (moveJogador.size() < nBaralhar*2) {
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
                if (pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i+1][j] != null) {
                  wrong.play();
                }
              } else if (j==m-1) {
                if (pedacos[i-1][j] !=null && pedacos[i][j-1] != null && pedacos[i+1][j] != null) {
                  wrong.play();
                }
              }
            }
          }
        } else {
          status.selected = Status.PERDEU;
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
            moveBaralhar.add(0, PalavraOposta("UP"));
          } else if (r==1) {
            p[i][j] = p[i+1][j]; //r=1 puxa de baixo, peça por cima do nulo desce
            p[i+1][j] = null;
            moveBaralhar.add(0, PalavraOposta("DOWN"));
          } else if (r==2) {
            p[i][j] = p[i][j-1]; //r=2 puxa da esquerda, peça à esquerda do nulo anda para a direita
            p[i][j-1] = null;
            moveBaralhar.add(0, PalavraOposta("LEFT"));
          } else if (r==3) {
            p[i][j] = p[i][j+1]; //r=3 puxa da direita, peça à direita do nulo anda para a esquerda
            p[i][j+1] = null;
            moveBaralhar.add(0, PalavraOposta("RIGHT"));
          }
        }
      }
    }
  }
}

String PalavraOposta(String s) {
  if (s.equals("UP")) {
    s = "DOWN";
  } else if (s.equals("DOWN")) {
    s = "UP";
  } else if (s.equals("RIGHT")) {
    s = "LEFT";
  } else if (s.equals("LEFT")) {
    s = "RIGHT";
  }
  return s;
}

boolean vitoria(Pedaco[][] p) {
  int posicao = 0;
  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (p[i][j] != null) {
        if (p[i][j].ident != posicao) {
          return false;
        }
      }
      posicao++;
    }
  }
  return true;
}

/* 
 
 WEBGRAFIA
 https://www.openprocessing.org/sketch/131051
 
 */
