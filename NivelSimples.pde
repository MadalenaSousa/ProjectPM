class NivelSimples extends Jogo {

  NivelSimples(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
  }

  void startNivel() {
    moveBaralhar.clear(); // Limpa o array com os movimentos de baralhar
    misturar(); // Baralha
    moveJogador.clear(); // Limpa o array com os movimentos do jogador para poder voltar a jogar
    jaGanhou = false; // Garante que as variaveis que dizem se já perdeu ou ganhou o jogo estão a falso
    jaPerdeu = false;
  }

  // Estrutura geral do nível
  void desenhaJogo() {
    super.desenha();
  }
}