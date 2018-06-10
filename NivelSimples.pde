class NivelSimples extends Jogo {

  int nLimite;

  NivelSimples(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar, int nLimite) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    this.nLimite = nLimite;
  }
  
  void desenhaJogo() {
    super.desenha();
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Jogadas Disponíveis", 800, 100);
    textSize(50);
    text(nLimite - moveJogador.size(), 800, 200);
  }

  boolean permiteJogar() {
    if (moveJogador.size() < nLimite) {
      return true;
    } else {
      return false;
    }
  }
}
