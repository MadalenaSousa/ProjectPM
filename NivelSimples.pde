class NivelSimples extends Jogo {

  int nLimite;

  NivelSimples(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar, int nLimite) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    this.nLimite = nLimite;
  }

  void startNivel() {
    moveBaralhar.clear(); //Limpa o array com os movimentos de baralhar
    misturar(); //Baralha
    moveJogador.clear(); //Limpa o array com os movimentos do jogador para poder voltar a jogar
    status.selected = Status.SIMPLES; //Inicia o Jogo
    jaGanhou = false; //Garante que as variaveis que dizem se já perdeu ou ganhou o jogo estão a falso
    jaPerdeu = false;
  }
  
  //Estrutura geral do nível + Pontuação
  void desenhaJogo() {
    super.desenha();

    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Jogadas Disponíveis", 800, 100);
    textSize(50);
    text(nLimite - moveJogador.size(), 800, 200);
    textSize(30);
    text("Recorde", 800, 300);
    textSize(50);
    //text(/*recorde min jogadas*/, 800, 400);
  }

  //Determina se, consoante o numero de jogadas feitas, é ainda permitido jogar (tecnicamente, diz-nos se o jogar já perdeu ou não)
  boolean permiteJogar() {
    if (moveJogador.size() < nLimite) {
      return true;
    } else {
      return false;
    }
  }
}
