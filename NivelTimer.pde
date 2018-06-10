class NivelTimer extends Jogo {

  boolean parar;
  int s, m;
  PFont d;
  int tempo, tempos, tempoLimite, tempoLimites;

  NivelTimer(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar, int nLimite) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    parar=false;
    s=(millis()/1000)%60;
    m=((millis()/1000) / 60)%60;
    d=createFont("Baskerville", 75, true);
    tempoLimite=2;
    tempoLimites=59;
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

    //Adicionar aqui o desenho do cronometro
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Tempo de Sobra", 800, 100);
    textSize(50);
    //text(nf(tempo, 2)+":"+nf(tempos, 2), 800, 200);
    textSize(30);
    text("Recorde", 800, 300);
    textSize(50);
    //text(/*recorde min tempo*/, 800, 400);
    if (parar==false) {
      tempo = tempoLimite-m;
      tempos=tempoLimites-s;
    }
    if (tempo==0 && tempos==0) {
      parar=true;
    }
    if (parar) {
      m=tempoLimite;
      s=tempoLimite;
    }
  }

  //boolean permiteJogar() {
  //Adicionar aqui o que define que se perde quando o tempo acabar
  //}
}
