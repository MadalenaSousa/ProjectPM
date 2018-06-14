class Solucao {
  Pedaco [][] peca;
  int m, n;
  ArrayList <String> moveSolucao;
  int s;

  Solucao(int n, int m, Pedaco[][] peca, ArrayList <String> moveSolucao) {
    this.peca = new Pedaco[n][m];
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        this.peca[i][j] = peca[i][j];
      }
    }
    this.n = n;
    this.m = m;
    this.moveSolucao = moveSolucao;
    this.s = 0;
  }

  void desenhaSolucao() {
    desenhaBaralhado(); // Desenha as peças na posição baralhada enviada anteriormente no construtor, dentro da classe nível, após baralhar

    // texto 2
    rectMode(CENTER);
    fill(#C16085);
    rect(800, 255, 300, 65, 50);

    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Solução", 800, 250);
    textSize(50);
    if (s > 0) {
      text(moveSolucao.get(s-1), 800, 350); // Mostra os movimentos executados para resolver
    }

    if (s < moveSolucao.size()) { // Move cada peça, percorrendo o array de movimentos
      movePeca(moveSolucao.get(s));
      delay(1000);
      s++;
    } 

    // texto 4
    rectMode(CENTER);
    fill(#C16085);
    rect(800, 655, 300, 65, 50);

    fill(255);
    textSize(30);
    text("Menu Principal", 800, 650);
  }

  void desenhaBaralhado() {
    for (int i=0; i<n; i++) {
      for (int j=0; j<m; j++) {
        if (peca[i][j] != null) {
          peca[i][j].desenha(i, j);
        }
      }
    }
  }
  
  // Deteta se o cursor está sobre o botão de regressar ao menu principal
  boolean cursorSobreDesistir() {
    if (mouseX >= 650 && mouseX <= 950 && mouseY >= 622.5 && mouseY <= 682.5) {
      return true;
    } else {
      return false;
    }
  }

  // Move as pecas consoante o que diz na string do array com a solução, executado relativamente à peça preta
  void movePeca(String movimento) {
    for (int i=0; i<n /*8*/; i++) {
      for (int j=0; j<m/*6*/; j++) {
        if (peca[i][j] != null) {
          if (movimento.equals("DOWN")) { 
            if (i!=0) {
              if (peca[i-1][j] == null) { // Desce a peça nula
                peca[i-1][j] = peca[i][j];
                peca[i][j] = null;
                return;
              }
            }
          }
          if (movimento.equals("UP")) {
            if (i!=n-1) {
              if (peca[i+1][j] == null) { // Sobe a peça nula
                peca[i+1][j] = peca[i][j];
                peca[i][j] = null;
                return;
              }
            }
          }
          if (movimento.equals("RIGHT")) {
            if (j!=0) {
              if (peca[i][j-1] == null) { // Move a peça nula para a direita
                peca[i][j-1] = peca[i][j];
                peca[i][j] = null;
                return;
              }
            }
          }
          if (movimento.equals("LEFT")) {
            if (j!=m-1) {
              if (peca[i][j+1] == null) { // Move a peça nula para a esquerda
                peca[i][j+1] = peca[i][j];
                peca[i][j] = null;
                return;
              }
            }
          }
        }
      }
    }
  }
}
