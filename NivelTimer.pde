class NivelTimer extends Jogo {

  boolean parar;
  int s, m;
  PFont d;
  int tempoM, tempoS, tempoLimiteM, tempoLimiteS;

  NivelTimer(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar, int nLimite) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    parar=false;
    s=(millis()/1000)%60;
    m=((millis()/1000) / 60)%60;
    d=createFont("Baskerville", 75, true);
    tempoLimiteM=2;
    tempoLimiteS=59;
  }

  void startNivel() {
    moveBaralhar.clear(); //Limpa o array com os movimentos de baralhar
    misturar(); //Baralha
    moveJogador.clear(); //Limpa o array com os movimentos do jogador para poder voltar a jogar
    status.selected = Status.TIMER; //Inicia o Jogo
    jaGanhou = false; //Garante que as variaveis que dizem se já perdeu ou ganhou o jogo estão a falso
    jaPerdeu = false;
  }

  void desenhaJogo() {
    super.desenha();

    tempoM = tempoLimiteM-m;
    tempoS=tempoLimiteS-s;

    //Adicionar aqui o desenho do cronometro
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Tempo de Sobra", 800, 100);
    textSize(50);
    text(nf(tempoM, 2)+":"+nf(tempoS, 2), 800, 200);
    textSize(30);
    text("Recorde", 800, 300);
    textSize(50);
    //text(/*recorde min tempo*/, 800, 400);
  }

  boolean permiteJogar() {
    if (tempoM>0 && tempoS>0) {
      return true;
    } else {
      return false;
    }
  }
}
