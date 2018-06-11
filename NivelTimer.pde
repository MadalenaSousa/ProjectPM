class NivelTimer extends Jogo {

  boolean parar;
  long tInicial;
  int tempoLimiteM, tempoLimiteS;
  int tRestaS, tFinalS;
  ArrayList <Integer> recorde;

  NivelTimer(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    parar = false;
    tempoLimiteM = 1;
    tempoLimiteS = 01;
    tFinalS = tempoLimiteM * 60 + tempoLimiteS; //tempo limite total em segundos
    recorde = new ArrayList();
  }

  void startNivel() {
    moveBaralhar.clear();
    misturar(); //Limpa o array com os movimentos de baralhar //Baralha
    moveJogador.clear(); //Limpa o array com os movimentos do jogador para poder voltar a jogar
    jaGanhou = false; //Garante que as variaveis que dizem se já perdeu ou ganhou o jogo estão a falso
    jaPerdeu = false;
    status.selected = Status.TIMER; //Inicia o Jogo
    tRestaS = tFinalS; //O tempo que resta inicialmente é o tempo total limite
    tInicial = millis(); //tempo a que estou a comecar o nivel
  }

  void desenhaJogo() {
    super.desenha();

    int tempoMillis = (int)(millis() - tInicial); //tempo que ja passou em millissegundos
    int tPassadoS = (tempoMillis/1000); // tempo que ja passou convertido em segundos

    tRestaS = tFinalS - tPassadoS; 

    int tempoM = (int)(tRestaS/60); //calcula o tempo que resta em minutos
    int tempoS = (tRestaS%60); //calcula o tempo que resta em segundos

    //Adicionar aqui o desenho do cronometro
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Tempo de Sobra", 800, 300);
    textSize(50);
    text(nf(tempoM, 2)+":"+nf(tempoS, 2), 800, 400);
    textSize(30);
    text("Recorde", 800, 500);
    textSize(50);
    int recordeMin = parseInt(recorde())/60;
    int recordeSeg = parseInt(recorde())%60;
    text(nf(recordeMin, 2) + ":" + nf(recordeSeg, 2), 800, 600);
  }

  boolean permiteJogar() {
    if (tRestaS > 0) {
      return true;
    } else {
      return false;
    }
  }

  String recorde() {
    if (jaGanhou) {
      recorde.add(tFinalS - tRestaS);
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
