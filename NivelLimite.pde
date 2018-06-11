class NivelLimite extends Jogo {

  int nLimite;
  ArrayList <Integer> recorde;

  NivelLimite(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar, int nLimite) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    this.nLimite = nLimite;
    recorde = new ArrayList();
  }

  // Estrutura geral do nível + Jogadas
  void desenhaJogo() {
    super.desenha();
    
    // texto 2
    rectMode(CENTER);
    fill(#C16085);
    rect(800, 255, 300, 65, 50);

    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Jogadas Disponíveis", 800, 250);
    textSize(50);
    text(nLimite - moveJogador.size(), 800, 350);
    
    // texto 3
    rectMode(CENTER);
    fill(#C16085);
    rect(800, 455, 300, 65, 50);
    
    fill(255);
    textSize(30);
    text("Recorde", 800, 450);
    textSize(50);
    text(recorde(), 800, 550);
  }

  // Determina se, consoante o numero de jogadas feitas, é ainda permitido jogar
  boolean permiteJogar() {
    if (moveJogador.size() < nLimite) {
      return true;
    } else {
      return false;
    }
  }

  // Função que retorna o recorde
  String recorde() {
    if (jaGanhou) {
      recorde.add(moveJogador.size());
    }
    if (recorde.size() == 0) {
      return "";
    }
    int[] rec = new int[recorde.size()]; 
    for (int i = 0; i < recorde.size(); i++) {
      rec[i] = recorde.get(i);
    }
    return "" + min(rec);
  }
}
