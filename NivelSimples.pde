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

    /*
     rectMode(CENTER);
     fill(#C16085);
     rect(800, 305, 300, 65, 50);
     textAlign(CENTER, CENTER);
     fill(255);
     textSize(30);
     text("Desistir", 800, 300);
     */
  }

  /*/ Deteta quando o cursor está sobre o botão de desistir
  boolean cursorSobreDesistir() {
    if (mouseX >= 800 && mouseX <=  && mouseY >= y + 20 + 4.5 * alt && mouseY <= y + 20 + 4.5 * alt + alt) {
      return true;
    } else {
      return false;
    }
  }*/
}
