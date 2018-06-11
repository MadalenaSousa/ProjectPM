class Jogo {
  Pedaco[][] pedacos;
  int n, m;
  ArrayList <String> moveJogador; //ArrayLists que guardam os movimentos
  ArrayList <String> moveBaralhar;
  Status status;
  int nBaralhar;
  boolean jaPerdeu, jaGanhou;

  Jogo(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar) {
    this.n = n;
    this.m = m;
    this.status = status;
    this.nBaralhar = nBaralhar;

    //Criação dos pedacos, à exceção do último, atribuindo a cada um um numero de identificação
    pedacos = new Pedaco[n][m];
    int nIdentificacao = 0;
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if (i != (n-1) || j != (m-1)) {
          pedacos[i][j] = new Pedaco(alturaImg/n, larguraImg/m, img, i, j, nIdentificacao);
          nIdentificacao++;
        } else {
          pedacos[i][j] = null;
        }
      }
    }
    moveBaralhar = new ArrayList();
    moveJogador = new ArrayList();
    jaPerdeu = false;
    jaGanhou = false;
  }

  //Função para reeiniciar o jogo
  void startNivel() {
    moveBaralhar.clear();
    moveJogador.clear(); //Limpa o array com os movimentos do jogador para poder voltar a jogar
    misturar();
    jaGanhou = false; //Garante que as variaveis que dizem se já perdeu ou ganhou o jogo estão a falso
    jaPerdeu = false;
  }

  void desenha() {
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if (pedacos[i][j] != null) {
          pedacos[i][j].desenha(i, j);
        }
      }
    }

    if (permiteJogar() == false) {
      jaGanhou = false;
      jaPerdeu = true;
      status.selected = Status.PERDEU;
      printSolution(); //imprime os movimentos da solução, visto que a variavel jaPerdeu está a true
    }

    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Movimentos", 800, 100);
    textSize(50);
    text(moveJogador.size(), 800, 200);
    /*String[] movimentos = moveJogador.toArray(new String[0]);
    for (int i=0; i<movimentos.length; i++) {
      text(movimentos[i], 800, 200);
    }*/
  }

  //METODOS QUE NÃO FAZEM NADA NESTA CLASSE MAS SÃO NECESSÁRIOS NAS SUBCLASSES (OVERRIDE)
  void desenhaJogo() {
  }

  //Detetor de perder
  boolean permiteJogar() {
    return true;
  }

  //Detetor de ganhar
  boolean vitoria() {
    int posicao = 0;
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if (pedacos[i][j] != null) {
          if (pedacos[i][j].ident != posicao) {
            return false;
          }
        }
        posicao++;
      }
    }
    return true;
  }

  // Verifica se Ganhou
  void verificaGanhou() {
    if (vitoria()) {
      jaGanhou = true;
      jaPerdeu = false;
      status.selected = Status.GANHOU;
      recorde();
      printSolution(); //imprime os movimentos do jogador, visto que a variavel jaGanhou está a true
    }
  }

  String recorde() {
    return "";
  }

  //Lógica dos movimentos e adição do som de movimento válido
  void moverPecaSom(SoundFile move) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        if (permiteJogar()) {
          if (pedacos[i][j] != null) {
            if (pedacos[i][j].pressed()) {
              if (i!=0) {
                reproduzir(move);
                if (pedacos[i-1][j] == null) { //Desce a peça nula
                  pedacos[i-1][j] = pedacos[i][j];
                  pedacos[i][j] = null;
                  moveJogador.add("DOWN");
                  verificaGanhou();
                  return;
                }
              } 

              if (i!=n-1) {
                reproduzir(move);
                if (pedacos[i+1][j] == null) { //Sobe a peça nula
                  pedacos[i+1][j] = pedacos[i][j];
                  pedacos[i][j] = null;
                  moveJogador.add("UP");
                  verificaGanhou();
                  return;
                }
              } 

              if (j!=0) {
                reproduzir(move);
                if (pedacos[i][j-1] == null) { //Move a peça nula para a direita
                  pedacos[i][j-1] = pedacos[i][j];
                  pedacos[i][j] = null;
                  moveJogador.add("RIGHT");
                  verificaGanhou();
                  return;
                }
              } 

              if (j!=m-1) {
                reproduzir(move);
                if (pedacos[i][j+1] == null) { //Move a peça nula para a esquerda
                  pedacos[i][j+1] = pedacos[i][j];
                  pedacos[i][j] = null;
                  moveJogador.add("LEFT");
                  verificaGanhou();
                  return;
                }
              }
            }
          }
        }
      }
    }
  }

  //Adição do som de movimentos errados
  void somErrado(SoundFile wrong) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        if (pedacos[i][j] != null) {
          if (pedacos[i][j].pressed()) {
            if (i!=0 && i!=n-1 && j!=0 && j!=m-1) {
              if (pedacos[i+1][j] != null && pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i][j-1] != null) {
                reproduzir(wrong);
              }
            } else if (i==0) {
              if (j==0) {
                if (pedacos[i+1][j] != null && pedacos[i][j+1] != null) {
                  reproduzir(wrong);
                }
              } else if (j==m-1) {
                if (pedacos[i+1][j] != null && pedacos[i][j-1] != null) {
                  reproduzir(wrong);
                }
              } else {
                if (pedacos[i+1][j] !=null && pedacos[i][j+1] != null && pedacos[i][j-1] != null) {
                  reproduzir(wrong);
                }
              }
            } else if (i==n-1) {
              if (j==0) {
                if (pedacos[i-1][j] != null && pedacos[i][j+1] != null) {
                  reproduzir(wrong);
                }
              } else if (j==m-1) {
                if (pedacos[i-1][j] != null && pedacos[i][j-1] != null) {
                  reproduzir(wrong);
                }
              } else {
                if (pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i][j-1] != null) {
                  reproduzir(wrong);
                }
              }
            } else if (j==0) {
              if (pedacos[i-1][j] !=null && pedacos[i][j+1] != null && pedacos[i+1][j] != null) {
                reproduzir(wrong);
              }
            } else if (j==m-1) {
              if (pedacos[i-1][j] !=null && pedacos[i][j-1] != null && pedacos[i+1][j] != null) {
                reproduzir(wrong);
              }
            }
          }
        }
      }
    }
  }


  //Trocar as Palavras pela sua oposta para a solução fazer mais sentido
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

  //Baralha as peças, movendo-as, tornando as soluções sempre possíveis de resolver
  void misturar() {
    for (int z=0; z<nBaralhar; z++) {
      for (int i=0; i<n /*8*/; i++) {
        for (int j=0; j<m/*6*/; j++) {
          int r = (int)random(0, 4);

          while ((r==0 && i==0) || (r==1 && i==n-1) || (r==2 && j==0) || (r==3 && j==m-1)) { //cantos
            r = (int)random(0, 4);
          }

          if (pedacos[i][j] == null) {
            if (r==0) {
              pedacos[i][j] = pedacos[i-1][j]; //r=0 puxa de cima, peça de baixo do nulo sobe
              pedacos[i-1][j] = null;
              moveBaralhar.add(0, PalavraOposta("UP"));
            } else if (r==1) {
              pedacos[i][j] = pedacos[i+1][j]; //r=1 puxa de baixo, peça por cima do nulo desce
              pedacos[i+1][j] = null;
              moveBaralhar.add(0, PalavraOposta("DOWN"));
            } else if (r==2) {
              pedacos[i][j] = pedacos[i][j-1]; //r=2 puxa da esquerda, peça à esquerda do nulo anda para a direita
              pedacos[i][j-1] = null;
              moveBaralhar.add(0, PalavraOposta("LEFT"));
            } else if (r==3) {
              pedacos[i][j] = pedacos[i][j+1]; //r=3 puxa da direita, peça à direita do nulo anda para a esquerda
              pedacos[i][j+1] = null;
              moveBaralhar.add(0, PalavraOposta("RIGHT"));
            }
          }
        }
      }
    }
  }

  //Consoante a classificação do jogo, imprime um determinado arraylist
  void printSolution() {
    if (jaGanhou) {
      println("Os seus movimentos: Moveu a peça preta " + moveJogador);
    } else if (jaPerdeu) {
      println("Uma solução: Mover a peça preta " + moveBaralhar);
    }
    jaGanhou = false;
    jaPerdeu = false;
  }
}
